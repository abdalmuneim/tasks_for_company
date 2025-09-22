import 'package:flutter/material.dart';

class PostCardPlaceholder extends StatelessWidget {
  const PostCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeholderColor = theme.brightness == Brightness.dark
        ? Colors.grey[800]!
        : Colors.grey[200]!;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Placeholder
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: placeholderColor,
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: 120,
                      color: placeholderColor,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 12,
                      width: 80,
                      color: placeholderColor,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Image Placeholder
            Container(
              height: 250,
              width: double.infinity,
              color: placeholderColor,
            ),
            const SizedBox(height: 16),

            // Text Placeholders
            Container(
              height: 20,
              width: double.infinity,
              color: placeholderColor,
            ),
            const SizedBox(height: 8),
            Container(
              height: 16,
              width: 250,
              color: placeholderColor,
            ),
          ],
        ),
      ),
    );
  }
}
