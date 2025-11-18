import 'package:flutter/material.dart';

import '../constants/app_palette.dart';
import '../l10n/app_localizations.dart';
import '../models/daily_task_entry.dart';

class EntryDetailView extends StatelessWidget {
  final DailyTaskEntry entry;

  const EntryDetailView({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: [
        Text(
          "${entry.date.day}/${entry.date.month}/${entry.date.year}",
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppPalette.textMuted),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.analysisDetails,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 18),
        _buildDetailCard(
          context,
          title: l10n.yourEntry,
          child: Text(
            entry.text,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(height: 1.5),
          ),
        ),
        _buildDetailCard(
          context,
          title: l10n.quantitativeMetrics,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMetricDisplay(
                context,
                label: l10n.wordCount,
                value: entry.wordCount.toString(),
                color: AppPalette.secondary,
              ),
              _buildMetricDisplay(
                context,
                label: l10n.avgLW,
                value: entry.avgLettersPerWord.toStringAsFixed(1),
                color: AppPalette.primary,
              ),
              _buildMetricDisplay(
                context,
                label: l10n.clarity,
                value: l10n.clarityScore(entry.clarityScore),
                color: _getClarityColor(entry.clarityScore),
              ),
            ],
          ),
        ),
        _buildDetailCard(
          context,
          title: l10n.keyMetricsExplanation,
          child: Text(
            entry.keyMetric,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
        ),
        _buildDetailCard(
          context,
          title: l10n.aiQualitativeFeedback,
          child: Text(
            entry.aiFeedback,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        _buildDetailCard(
          context,
          title: l10n.keyVocabulary,
          child: Wrap(
            spacing: 10.0,
            runSpacing: 8.0,
            children: entry.keyVocabulary
                .map(
                  (word) => Chip(
                    label: Text(word),
                    backgroundColor: AppPalette.surface,
                    side: BorderSide(color: Colors.white.withOpacity(0.08)),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18.0),
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppPalette.surfaceHigh,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [AppPalette.glow(AppPalette.surfaceHigh)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Divider(),
          child,
        ],
      ),
    );
  }

  Widget _buildMetricDisplay(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.4)),
        gradient: LinearGradient(
          colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppPalette.textMuted),
          ),
        ],
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
