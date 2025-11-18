import 'package:flutter/material.dart';

import '../constants/app_palette.dart';
import '../models/daily_task_entry.dart';

class EntryCard extends StatelessWidget {
  final DailyTaskEntry entry;
  final bool isSelected;
  final VoidCallback onTap;

  const EntryCard({
    super.key,
    required this.entry,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.white.withOpacity(isSelected ? 0.45 : 0.08);
    final gradient = isSelected
        ? LinearGradient(
            colors: [
              AppPalette.primary.withOpacity(0.18),
              AppPalette.surfaceHigh.withOpacity(0.95),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : AppPalette.cardGradient;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: gradient,
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: isSelected
            ? [AppPalette.glow(AppPalette.primary.withOpacity(0.7))]
            : null,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${entry.date.day}/${entry.date.month}/${entry.date.year}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppPalette.textMuted,
                    ),
                  ),
                  Icon(
                    isSelected ? Icons.visibility : Icons.chevron_right,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                entry.text,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(height: 1.4),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  MetricChip(
                    label: "Quality",
                    value: "${entry.avgLettersPerWord.toStringAsFixed(1)} L/W",
                    color: AppPalette.primary,
                  ),
                  const SizedBox(width: 10),
                  MetricChip(
                    label: "Quantity",
                    value: "${entry.wordCount} W",
                    color: AppPalette.secondary,
                  ),
                  const SizedBox(width: 10),
                  MetricChip(
                    label: "Clarity",
                    value: "${entry.clarityScore}/5",
                    color: _getClarityColor(entry.clarityScore),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getClarityColor(int score) {
    if (score >= 5) return Colors.green;
    if (score >= 4) return Colors.lightGreen;
    if (score >= 3) return Colors.orange;
    if (score >= 2) return Colors.deepOrange;
    return Colors.red;
  }
}

class MetricChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const MetricChip({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label · ",
              style: const TextStyle(fontSize: 12, color: AppPalette.textMuted),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
