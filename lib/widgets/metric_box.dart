import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class MetricBox extends StatelessWidget {
  final String value;
  final String label;
  final IconData? icon;
  final double height;
  final double width;

  const MetricBox({
    super.key,
    required this.value,
    required this.label,
    this.height = 92,
    this.width = 128,
    this.icon,
  });

  const MetricBox.icon({
    super.key,
    required this.value,
    required this.label,
    this.height = 92,
    this.width = 128,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FTheme.of(context);
    return Container(
      width: height,
      height: width,
      padding: .only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colors.muted.withValues(alpha: 0.3),
        borderRadius: theme.cardStyle.decoration.borderRadius,
        border: .all(color: theme.colors.border),
      ),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          if (icon != null) Icon(icon, size: 32, color: theme.colors.primary),

          Text(
            value,
            style: theme.typography.xl2.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            label.toUpperCase(),
            style: theme.typography.xs.copyWith(
              color: theme.colors.mutedForeground,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
