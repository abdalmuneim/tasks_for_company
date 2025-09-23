import 'dart:async';
import 'package:flutter/material.dart';
import 'package:minisocialfeedapp/services/share_content.dart';
import 'package:share_plus/share_plus.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';
import '../models/suggested_user_model.dart';
import '../services/api_service.dart';
import '../services/firestore_service.dart';

class FeedProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final FirestoreService _firestoreService = FirestoreService();
  StreamSubscription? _postsSubscription;

  bool _isLoading = false;
  String? _errorMessage;
  List<PostModel> _posts = [];
  List<SuggestedUserModel> _suggestedUsers = [];
  final Map<String, List<CommentModel>> _postComments = {};

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<PostModel> get posts => [..._posts];
  List<SuggestedUserModel> get suggestedUsers => _suggestedUsers;
  Map<String, List<CommentModel>> get postComments => _postComments;

  FeedProvider() {
    fetchFeedData();
  }

  Future<void> fetchFeedData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Fetch suggested users and set up posts stream
      _suggestedUsers = await _apiService.fetchSuggestedUsers();
      _postsSubscription?.cancel();
      _postsSubscription = _firestoreService.getPosts().listen(
        (posts) async {
          _posts = posts;
          _isLoading = false;
          await _fetchCommentsForAllPosts();
          notifyListeners();
        },
        onError: (error) {
          _errorMessage = "Failed to load posts: $error";
          _isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      _errorMessage = "Failed to load feed data: $e";
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchCommentsForAllPosts() async {
    for (final post in _posts) {
      try {
        final comments = await _firestoreService.getComments(post.id).first;
        _postComments[post.id] = comments;
      } catch (e) {
        _postComments[post.id] = [];
      }
    }
    notifyListeners();
  }

  Future<void> toggleLike(String postId, String userId) async {
    try {
      await _firestoreService.toggleLike(postId, userId);
    } catch (e) {
      // Optionally, handle the error, e.g., show a snackbar
      print('Error toggling like: $e');
    }
  }

  // Get comments for a specific post
  List<CommentModel> getCommentsForPost(String postId) {
    return _postComments[postId] ?? [];
  }

  // Add comment to a post
  Future<void> addComment({
    required String postId,
    required String authorId,
    required String authorName,
    required String content,
  }) async {
    try {
      await _firestoreService.addComment(
        postId: postId,
        authorId: authorId,
        authorName: authorName,
        content: content,
      );

      notifyListeners();
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  // Toggle comment like
  Future<void> toggleCommentLike(String commentId, String userId) async {
    try {
      // Find the comment across all posts
      for (var postId in _postComments.keys) {
        final commentIndex = _postComments[postId]!.indexWhere(
          (c) => c.id == commentId,
        );
        if (commentIndex != -1) {
          final comment = _postComments[postId]![commentIndex];
          final isLiked = comment.isLikedBy(userId);
          List<String> newLikedBy = List.from(comment.likedBy);

          if (isLiked) {
            newLikedBy.remove(userId);
          } else {
            newLikedBy.add(userId);
          }

          _postComments[postId]![commentIndex] = comment.copyWith(
            likedBy: newLikedBy,
          );
          notifyListeners();
          break;
        }
      }
    } catch (e) {
      print('Error toggling comment like: $e');
    }
  }

  // Share post
  Future<void> sharePost(String postId) async {
    try {
      final post = posts.firstWhere((p) => p.id == postId);
      final shareText =
          '''
Check out this post: "${post.title}"

${post.description}

${post.hashtags.join(' ')}

#MiniSocialFeedApp
''';
      bool isShared = await ShareContent.instance
          .urlToFile(imageUrl: post.imageUrl)
          .then((file) async {
            return await SharePlus.instance.share(
              ShareParams(
                files: [XFile(file.path)],
                text: shareText,
                subject: post.title,
              ),
            );
          })
          .then(
            (ShareResult value) =>
                value.status.name == ShareResultStatus.success.name,
          )
          .catchError((e) {
            print('Error sharing post: $e');
            return false;
          });
      if (!isShared) return;

      await _firestoreService.incrementShareCount(postId);
    } catch (e) {
      print('Error sharing post: $e');
    }
  }

  // Delete comment (for post author or comment author)
  Future<void> deleteComment(String commentId, String userId) async {
    try {
      for (var postId in _postComments.keys) {
        final commentIndex = _postComments[postId]!.indexWhere(
          (c) => c.id == commentId,
        );
        if (commentIndex != -1) {
          final comment = _postComments[postId]![commentIndex];

          // Check if user can delete (comment author or post author)
          final post = posts.firstWhere((p) => p.id == postId);
          if (comment.authorId == userId || post.authorId == userId) {
            _postComments[postId]!.removeAt(commentIndex);

            notifyListeners();
          }
          break;
        }
      }
    } catch (e) {
      print('Error deleting comment: $e');
    }
  }

  @override
  void dispose() {
    _postsSubscription?.cancel();
    super.dispose();
  }
}
