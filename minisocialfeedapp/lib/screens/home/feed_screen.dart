import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minisocialfeedapp/services/admob_service.dart';
import 'package:minisocialfeedapp/utils/constants.dart';
import 'package:provider/provider.dart';
import '../../providers/feed_provider.dart';
import '../../widgets/error_message.dart';
import '../../widgets/post_card.dart';
import '../../widgets/post_card_placeholder.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/suggested_user_card.dart';
import '../../widgets/suggested_user_card_placeholder.dart';
import '../create_post/create_post_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data using the provider, but only if it hasn't been fetched yet.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final feedProvider = Provider.of<FeedProvider>(context, listen: false);
      if (feedProvider.posts.isEmpty) {
        feedProvider.fetchFeedData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        title: const Text('Connect'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/ima-ic.svg',
              color: Theme.of(context).brightness == Brightness.dark
                  ? kInputFieldColor
                  : null,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<FeedProvider>(
        builder: (context, feedProvider, child) {
          return Column(
            children: [
              AdBannerWidget(),
              kSizedBoxW16,
              Expanded(child: _buildFeedContent(feedProvider)),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFeedContent(FeedProvider feedProvider) {
    if (feedProvider.isLoading && feedProvider.posts.isEmpty) {
      return ShimmerLoading(
        isLoading: true,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => const PostCardPlaceholder(),
        ),
      );
    }

    if (feedProvider.errorMessage != null && feedProvider.posts.isEmpty) {
      return Center(
        child: ErrorMessage(
          message: feedProvider.errorMessage!,
          onRetry: () => feedProvider.fetchFeedData(),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => feedProvider.fetchFeedData(),
      child: ListView.builder(
        itemCount: feedProvider.posts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildSuggestedUsersSection(feedProvider);
          }
          final post = feedProvider.posts[index - 1];
          return PostCard(post: post);
        },
      ),
    );
  }

  Widget _buildSuggestedUsersSection(FeedProvider feedProvider) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Suggested',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildSuggestedUsersList(feedProvider),
      ],
    );
  }

  Widget _buildSuggestedUsersList(FeedProvider feedProvider) {
    if (feedProvider.isLoading && feedProvider.suggestedUsers.isEmpty) {
      return ShimmerLoading(
        isLoading: true,
        child: SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: 5,
            itemBuilder: (context, index) =>
                const SuggestedUserCardPlaceholder(),
          ),
        ),
      );
    }

    if (feedProvider.suggestedUsers.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.22,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: feedProvider.suggestedUsers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: SuggestedUserCard(user: feedProvider.suggestedUsers[index]),
          );
        },
      ),
    );
  }
}
