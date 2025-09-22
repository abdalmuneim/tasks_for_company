import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();

  // Get posts stream
  Stream<List<PostModel>> getPosts() {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data();
            // Ensure the document ID is included before creating the model
            return PostModel.fromMap({'id': doc.id, ...data});
          }).toList();
        });
  }

  // Create a new post
  Future<void> createPost({
    required String title,
    required String description,
    required String imageUrl,
    required String authorId,
    required String authorName,
    List<String> hashtags = const [],
  }) async {
    try {
      final postId = _uuid.v4();
      final post = PostModel(
        id: postId,
        title: title,
        description: description,
        imageUrl: imageUrl,
        authorId: authorId,
        authorName: authorName,
        likedBy: [],
        createdAt: DateTime.now(),
        hashtags: hashtags,
        commentCount: 0,
        shareCount: 0,
      );

      await _firestore.collection('posts').doc(postId).set(post.toMap());
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  // Toggle like on a post
  Future<void> toggleLike(String postId, String userId) async {
    try {
      DocumentReference postRef = _firestore.collection('posts').doc(postId);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot postSnapshot = await transaction.get(postRef);

        if (!postSnapshot.exists) {
          // Throw a more specific error to help with debugging
          throw Exception('Post with ID $postId not found.');
        }

        Map<String, dynamic> postData =
            postSnapshot.data() as Map<String, dynamic>;
        List<String> likedBy = List<String>.from(postData['likedBy'] ?? []);

        if (likedBy.contains(userId)) {
          // Unlike the post
          likedBy.remove(userId);
        } else {
          // Like the post
          likedBy.add(userId);
        }

        transaction.set(postRef, {'likedBy': likedBy}, SetOptions(merge: true));
      });
    } catch (e) {
      throw Exception('Failed to toggle like: $e');
    }
  }

  // Get posts by user
  Stream<List<PostModel>> getUserPosts(String userId) {
    return _firestore
        .collection('posts')
        .where('authorId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data();
            data['id'] = doc.id;
            return PostModel.fromMap(data);
          }).toList();
        });
  }

  // Delete a post
  Future<void> deletePost(String postId, String userId) async {
    try {
      DocumentSnapshot postDoc = await _firestore
          .collection('posts')
          .doc(postId)
          .get();

      if (!postDoc.exists) {
        throw Exception('Post does not exist');
      }

      Map<String, dynamic> postData = postDoc.data() as Map<String, dynamic>;

      if (postData['authorId'] != userId) {
        throw Exception('You can only delete your own posts');
      }

      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }

  // Update a post
  Future<void> updatePost({
    required String postId,
    required String userId,
    String? title,
    String? description,
    String? imageUrl,
    List<String>? hashtags,
  }) async {
    try {
      DocumentSnapshot postDoc = await _firestore
          .collection('posts')
          .doc(postId)
          .get();

      if (!postDoc.exists) {
        throw Exception('Post does not exist');
      }

      Map<String, dynamic> postData = postDoc.data() as Map<String, dynamic>;

      if (postData['authorId'] != userId) {
        throw Exception('You can only edit your own posts');
      }

      Map<String, dynamic> updateData = {};
      if (title != null) updateData['title'] = title;
      if (description != null) updateData['description'] = description;
      if (imageUrl != null) updateData['imageUrl'] = imageUrl;
      if (hashtags != null) updateData['hashtags'] = hashtags;

      if (updateData.isNotEmpty) {
        await _firestore.collection('posts').doc(postId).update(updateData);
      }
    } catch (e) {
      throw Exception('Failed to update post: $e');
    }
  }

  // Get trending hashtags
  Future<List<String>> getTrendingHashtags({int limit = 10}) async {
    try {
      QuerySnapshot postsSnapshot = await _firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .limit(100) // Get recent posts to analyze hashtags
          .get();

      Map<String, int> hashtagCount = {};

      for (QueryDocumentSnapshot doc in postsSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<String> hashtags = List<String>.from(data['hashtags'] ?? []);

        for (String hashtag in hashtags) {
          hashtagCount[hashtag] = (hashtagCount[hashtag] ?? 0) + 1;
        }
      }

      // Sort hashtags by count and return top ones
      List<MapEntry<String, int>> sortedHashtags = hashtagCount.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      return sortedHashtags.take(limit).map((entry) => entry.key).toList();
    } catch (e) {
      // Return some default trending hashtags if there's an error
      return ['#flutter', '#mobile', '#coding', '#tech', '#social'];
    }
  }

  // Add comment to a post
  Future<void> addComment({
    required String postId,
    required String authorId,
    required String authorName,
    required String content,
  }) async {
    try {
      final commentId = _uuid.v4();
      final comment = CommentModel(
        id: commentId,
        postId: postId,
        authorId: authorId,
        authorName: authorName,
        content: content,
        createdAt: DateTime.now(),
      );

      // Add comment to comments subcollection
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set(comment.toMap());

      // Update comment count in the post
      await _firestore.collection('posts').doc(postId).update({
        'commentCount': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to add comment: $e');
    }
  }

  // Get comments for a post
  Stream<List<CommentModel>> getComments(String postId) {
    return _firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data();
            return CommentModel.fromMap({'id': doc.id, ...data});
          }).toList();
        });
  }

  // Toggle like on a comment
  Future<void> toggleCommentLike(
    String postId,
    String commentId,
    String userId,
  ) async {
    try {
      DocumentReference commentRef = _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot commentSnapshot = await transaction.get(commentRef);

        if (!commentSnapshot.exists) {
          throw Exception('Comment with ID $commentId not found.');
        }

        Map<String, dynamic> commentData =
            commentSnapshot.data() as Map<String, dynamic>;
        List<String> likedBy = List<String>.from(commentData['likedBy'] ?? []);

        if (likedBy.contains(userId)) {
          likedBy.remove(userId);
        } else {
          likedBy.add(userId);
        }

        transaction.set(commentRef, {
          'likedBy': likedBy,
        }, SetOptions(merge: true));
      });
    } catch (e) {
      throw Exception('Failed to toggle comment like: $e');
    }
  }

  // Delete a comment
  Future<void> deleteComment(
    String postId,
    String commentId,
    String userId,
  ) async {
    try {
      DocumentSnapshot commentDoc = await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .get();

      if (!commentDoc.exists) {
        throw Exception('Comment does not exist');
      }

      Map<String, dynamic> commentData =
          commentDoc.data() as Map<String, dynamic>;

      // Check if user is the comment author or post author
      DocumentSnapshot postDoc = await _firestore
          .collection('posts')
          .doc(postId)
          .get();

      if (postDoc.exists) {
        Map<String, dynamic> postData = postDoc.data() as Map<String, dynamic>;
        if (commentData['authorId'] != userId &&
            postData['authorId'] != userId) {
          throw Exception(
            'You can only delete your own comments or comments on your posts',
          );
        }
      }

      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .delete();

      // Update comment count in the post
      await _firestore.collection('posts').doc(postId).update({
        'commentCount': FieldValue.increment(-1),
      });
    } catch (e) {
      throw Exception('Failed to delete comment: $e');
    }
  }

  // Increment share count for a post
  Future<void> incrementShareCount(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).update({
        'shareCount': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to increment share count: $e');
    }
  }
}
