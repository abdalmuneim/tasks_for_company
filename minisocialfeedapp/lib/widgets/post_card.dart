import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import '../providers/auth_provider.dart';
import '../providers/feed_provider.dart';
import '../utils/constants.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final feedProvider = Provider.of<FeedProvider>(context, listen: false);
    final bool isLiked =
        authProvider.user != null && post.isLikedBy(authProvider.user!.uid);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Image
          if (post.imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: post.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                placeholder: (context, url) => Container(
                  height: 250,
                  color: theme.colorScheme.surfaceContainerHighest,
                ),
                errorWidget: (context, url, error) => Container(
                  height: 250,
                  color: theme.colorScheme.errorContainer,
                  child: Icon(
                    Icons.broken_image,
                    color: theme.colorScheme.onErrorContainer,
                    size: 48,
                  ),
                ),
              ),
            ),
          kSizedBoxH16,

          // Post Content
          Text(post.title, style: theme.textTheme.titleLarge),
          kSizedBoxH8,
          Text(
            post.description,
            style: theme.textTheme.bodyMedium?.copyWith(color: kPrimaryColor),
          ),
          Text(
            '${post.likeCount} likes',
            style: theme.textTheme.bodyMedium?.copyWith(color: kPrimaryColor),
          ),
          kSizedBoxH8,

          // Post Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Like Button
              Row(
                children: [
                  IconButton(
                    icon: isLiked
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite_border),
                    onPressed: () {
                      if (authProvider.user != null) {
                        feedProvider.toggleLike(
                          post.id,
                          authProvider.user!.uid,
                        );
                      }
                    },
                  ),
                  Text(
                    '${post.likeCount}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),

              // Comment Button
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chat_bubble_outline),
                    onPressed: () {
                      _showCommentsBottomSheet(context, post);
                    },
                  ),
                  Text(
                    '${post.commentCount}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),

              // Share Button
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.share_outlined),
                    onPressed: () {
                      feedProvider.sharePost(post.id);
                    },
                  ),
                  Text(
                    '${post.shareCount}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCommentsBottomSheet(BuildContext context, PostModel post) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final feedProvider = Provider.of<FeedProvider>(context, listen: false);
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Comments',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Comments list
              Expanded(
                child: Consumer<FeedProvider>(
                  builder: (context, provider, child) {
                    final comments = provider.getCommentsForPost(post.id);

                    if (comments.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 64,
                              color: theme.dividerColor,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No comments yet',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.dividerColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Be the first to comment!',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.dividerColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: scrollController,
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        final isCommentLiked =
                            authProvider.user != null &&
                            comment.isLikedBy(authProvider.user!.uid);

                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: theme.primaryColor,
                                    child: Text(
                                      comment.authorName.isNotEmpty
                                          ? comment.authorName[0].toUpperCase()
                                          : '?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comment.authorName,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Text(
                                          _formatCommentTime(comment.createdAt),
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                color: theme.dividerColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                comment.content,
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (authProvider.user != null) {
                                        feedProvider.toggleCommentLike(
                                          comment.id,
                                          authProvider.user!.uid,
                                        );
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          isCommentLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 16,
                                          color: isCommentLiked
                                              ? Colors.red
                                              : theme.dividerColor,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${comment.likeCount}',
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Comment input
              Container(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  border: Border(
                    top: BorderSide(color: theme.dividerColor, width: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: kSecondaryColor,
                      child: Text(
                        authProvider.user?.displayName?.isNotEmpty == true
                            ? authProvider.user!.displayName![0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: theme.cardColor,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.send, color: kSecondaryColor),
                      onPressed: () {
                        final content = commentController.text.trim();
                        if (content.isNotEmpty && authProvider.user != null) {
                          feedProvider.addComment(
                            postId: post.id,
                            authorId: authProvider.user!.uid,
                            authorName:
                                authProvider.user!.displayName ?? 'Anonymous',
                            content: content,
                          );
                          commentController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCommentTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
