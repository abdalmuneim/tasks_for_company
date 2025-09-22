import 'package:flutter/material.dart';

class SocialIconButton extends StatelessWidget {
  final String assetName;
  final VoidCallback onPressed;

  const SocialIconButton({
    super.key,
    required this.assetName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(assetName, height: 32, width: 32),
      ),
    );
  }
}
