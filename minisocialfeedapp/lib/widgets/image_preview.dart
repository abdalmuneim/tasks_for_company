import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;

  const ImagePreview({
    super.key,
    required this.imageUrl,
    this.height = 200,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, url) => Container(
          height: height,
          width: width,
          color: theme.colorScheme.surfaceVariant,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: height,
          width: width,
          color: theme.colorScheme.errorContainer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image,
                color: theme.colorScheme.onErrorContainer,
                size: 48,
              ),
              const SizedBox(height: 8),
              Text(
                'Invalid URL',
                style: TextStyle(color: theme.colorScheme.onErrorContainer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
