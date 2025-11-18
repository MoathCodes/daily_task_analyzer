import 'package:flutter/material.dart';

import '../constants/app_palette.dart';

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
    final gradient = LinearGradient(
      colors: [color.withOpacity(0.45), color.withOpacity(0.15)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final card = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(28.0),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [AppPalette.glow(color.withOpacity(0.9))],
      ),
      padding: const EdgeInsets.all(20.0),
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: "  $unit",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (isDesktop) {
      return card;
    } else {
      return SizedBox(width: 180, child: card);
    }
  }
}
