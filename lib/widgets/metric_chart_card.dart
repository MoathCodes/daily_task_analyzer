import 'package:daily_task_analyzer/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class MetricChartCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final bool isDesktop;

  const MetricChartCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isArabic = AppLocalizations.of(context)!.localeName == 'ar';
    // Fallback in case decoration color is null in some scaffold contexts (mobile early build)
    final baseColor = theme.cardStyle.decoration.color ?? Colors.black;
    final card = Container(
      height: 120,
      clipBehavior: Clip.hardEdge, // Ensures the overflow icon is clipped
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isArabic ? [baseColor, color] : [color, baseColor],
          stops: isArabic ? [1 - 0.018, 1 - 0.018] : [0.018, 0.018],
        ),
        border: theme.cardStyle.decoration.border,
        borderRadius: theme.cardStyle.decoration.borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header Row
            Row(
              children: [
                Icon(icon, size: 16, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Big Value Text
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),

            // Subtitle Text
            Text(
              unit,
              style: TextStyle(
                color: Colors.grey[500], // muted-foreground
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );

    if (isDesktop) {
      return card;
    } else {
      return SizedBox(width: 180, child: card);
    }
  }
}
