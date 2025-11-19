import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../constants/app_palette.dart';
import '../models/daily_task_entry.dart';

class EntryCard extends StatefulWidget {
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
  State<EntryCard> createState() => _EntryCardState();
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
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.3)),
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

class _EntryCardState extends State<EntryCard> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      decoration: BoxDecoration(
        borderRadius: theme.cardStyle.decoration.borderRadius,
        color: _isHover
            ? theme.colors.muted.withValues(alpha: 0.4)
            : widget.isSelected
                ? theme.colors.muted.withValues(alpha: 0.7)
                : theme.cardStyle.decoration.color,
        border: .all(
          color: widget.isSelected
              ? theme.colors.primary.withValues(alpha: 0.5)
              : theme.colors.border,
        ),
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              _isHover = true;
            });
          },
          onExit: (event) {
            setState(() {
              _isHover = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Icon(
                      FIcons.calendar,
                      size: 14,
                      color: theme.colors.mutedForeground,
                    ),
                    Text(
                      "${widget.entry.date.day}/${widget.entry.date.month}/${widget.entry.date.year}",
                      style: theme.typography.sm.copyWith(
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.entry.text,
                  style: theme.typography.sm.copyWith(
                    color: theme.colors.foreground,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: Row(
                    children: [
                      MetricChip(
                        label: "Quality",
                        value:
                            "${widget.entry.avgLettersPerWord.toStringAsFixed(1)} L/W",
                        color: AppPalette.primary,
                      ),
                      const SizedBox(width: 10),
                      MetricChip(
                        label: "Quantity",
                        value: "${widget.entry.wordCount} W",
                        color: AppPalette.secondary,
                      ),
                      const SizedBox(width: 10),
                      MetricChip(
                        label: "Clarity",
                        value: "${widget.entry.clarityScore}/5",
                        color: _getClarityColor(widget.entry.clarityScore),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
