import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SectionHeader extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Color? iconColor;

  const SectionHeader({
    super.key,
    this.icon,
    required this.title,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FTheme.of(context);
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 16,
            color: iconColor ?? theme.colors.mutedForeground,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          title.toUpperCase(),
          style: theme.typography.xs.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colors.mutedForeground,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
