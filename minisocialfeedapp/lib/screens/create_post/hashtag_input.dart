import 'package:flutter/material.dart';
import 'package:minisocialfeedapp/utils/constants.dart';
import 'package:provider/provider.dart';
import '../../providers/create_post_provider.dart';

class HashtagInput extends StatefulWidget {
  final Function(List<String>) onHashtagsChanged;
  final String? title;
  final String? description;

  const HashtagInput({
    super.key,
    required this.onHashtagsChanged,
    this.title,
    this.description,
  });

  @override
  State<HashtagInput> createState() => _HashtagInputState();
}

class _HashtagInputState extends State<HashtagInput> {
  final _controller = TextEditingController();
  final List<String> _hashtags = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showSuggestions = _controller.text.isNotEmpty;
    });
  }

  void _toggleHashtag(String hashtag) {
    final provider = Provider.of<CreatePostProvider>(context, listen: false);

    if (_hashtags.contains(hashtag)) {
      // Remove hashtag
      final updatedHashtags = provider.removeHashtag(_hashtags, hashtag);
      setState(() {
        _hashtags.clear();
        _hashtags.addAll(updatedHashtags);
        widget.onHashtagsChanged(_hashtags);
      });
    } else {
      // Add hashtag
      final updatedHashtags = provider.addHashtag(_hashtags, hashtag);
      if (updatedHashtags.length > _hashtags.length) {
        setState(() {
          _hashtags.clear();
          _hashtags.addAll(updatedHashtags);
          widget.onHashtagsChanged(_hashtags);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<CreatePostProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Smart suggestions based on title/description
            if (widget.title != null || widget.description != null) ...[
              _buildSmartSuggestions(provider, theme),
              const SizedBox(height: 12),
            ],

            // Popular hashtags
            _buildPopularHashtags(provider, theme),

            const SizedBox(height: 12),

            // All available hashtags
            if (_showSuggestions && provider.allHashtags.isNotEmpty) ...[
              _buildAllHashtagsSuggestions(provider, theme),
              const SizedBox(height: 12),
            ],
          ],
        );
      },
    );
  }

  Widget _buildSmartSuggestions(CreatePostProvider provider, ThemeData theme) {
    final suggestions = provider.getSuggestedHashtags(
      widget.title ?? '',
      widget.description ?? '',
    );

    if (suggestions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb_outline, size: 16, color: theme.primaryColor),
            const SizedBox(width: 4),
            Text(
              'Suggested for your post',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: suggestions.map((hashtag) {
            final isSelected = _hashtags.contains(hashtag);
            return GestureDetector(
              onTap: () => _toggleHashtag(hashtag),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.primaryColor
                      : theme.primaryColor.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? theme.primaryColor
                        : theme.primaryColor.withValues(alpha: .3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      hashtag,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isSelected ? Colors.white : theme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      isSelected ? Icons.check : Icons.add,
                      size: 14,
                      color: isSelected ? Colors.white : theme.primaryColor,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPopularHashtags(CreatePostProvider provider, ThemeData theme) {
    final popularHashtags = provider.getPopularHashtags();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: popularHashtags.take(6).map((hashtag) {
            final isSelected = _hashtags.contains(hashtag);
            return GestureDetector(
              onTap: () => _toggleHashtag(hashtag),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? theme.primaryColor : kInputFieldColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      hashtag,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAllHashtagsSuggestions(
    CreatePostProvider provider,
    ThemeData theme,
  ) {
    final filteredHashtags = provider.allHashtags
        .where(
          (tag) =>
              tag.toLowerCase().contains(_controller.text.toLowerCase()) &&
              !_hashtags.contains(tag),
        )
        .take(8)
        .toList();

    if (filteredHashtags.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'From existing posts',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          constraints: const BoxConstraints(maxHeight: 120),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              children: filteredHashtags.map((hashtag) {
                final isSelected = _hashtags.contains(hashtag);
                return GestureDetector(
                  onTap: () => _toggleHashtag(hashtag),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.primaryColor
                          : theme.colorScheme.secondary.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? theme.primaryColor
                            : theme.colorScheme.secondary.withValues(alpha: .3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          hashtag,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isSelected
                                ? Colors.white
                                : theme.colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          isSelected ? Icons.check : Icons.add,
                          size: 12,
                          color: isSelected
                              ? Colors.white
                              : theme.colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
