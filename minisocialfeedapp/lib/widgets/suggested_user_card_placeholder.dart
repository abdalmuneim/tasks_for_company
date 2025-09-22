import 'package:flutter/material.dart';

class SuggestedUserCardPlaceholder extends StatelessWidget {
  const SuggestedUserCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeholderColor = theme.brightness == Brightness.dark
        ? Colors.grey[800]!
        : Colors.grey[200]!;

    return SizedBox(
      width: 120,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 30, backgroundColor: placeholderColor),
            const SizedBox(height: 8),
            Container(height: 14, width: 80, color: placeholderColor),
            const SizedBox(height: 4),
            Container(height: 12, width: 60, color: placeholderColor),
          ],
        ),
      ),
    );
  }
}
