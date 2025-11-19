import 'package:daily_task_analyzer/l10n/app_localizations.dart';
import 'package:daily_task_analyzer/widgets/ai_feedback.dart';
import 'package:daily_task_analyzer/widgets/metric_box.dart';
import 'package:daily_task_analyzer/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../models/daily_task_entry.dart';

class AnalysisDetailsPage extends StatelessWidget {
  final DailyTaskEntry entry;

  const AnalysisDetailsPage({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = FTheme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // --- Scrollable Content ---
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Section 1: Your Entry ---
                SectionHeader(
                  icon: FIcons.textAlignStart,
                  title: l10n.yourEntry,
                ),
                const SizedBox(height: 12),
                Center(
                  child: FCard(
                    style: (style) => style.copyWith(
                      decoration: style.decoration.copyWith(
                        color: theme.colors.muted.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        entry.text,
                        style: theme.typography.sm.copyWith(height: 1.6),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // --- Section 2: Quantitative Metrics ---
                SectionHeader(
                  icon: FIcons.activity,
                  title: l10n.quantitativeMetrics,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: .spaceEvenly,
                  children: [
                    MetricBox(
                      value: entry.wordCount.toString(),
                      label: l10n.words,
                    ),
                    const SizedBox(width: 12),
                    MetricBox(
                      value: entry.avgLettersPerWord.toStringAsFixed(1),
                      label: l10n.avgLW,
                    ),
                    const SizedBox(width: 12),
                    MetricBox(
                      value: "${entry.clarityScore}/5",
                      label: l10n.clarity,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // --- Section 3: Explanation ---
                SectionHeader(title: l10n.keyMetricsExplanation),
                const SizedBox(height: 12),
                Text(
                  entry.keyMetric,
                  style: theme.typography.sm.copyWith(
                    color: theme.colors.mutedForeground,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 32),

                SectionHeader(title: l10n.keyVocabulary),
                const SizedBox(height: 12),
                Row(
                  spacing: 8,
                  children: [
                    ...entry.keyVocabulary.map(
                      (e) => FBadge(
                        style: FBadgeStyle.secondary(
                          (style) => style.copyWith(
                            contentStyle: style.contentStyle
                                .copyWith(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 12,
                                  ),
                                )
                                .call,
                          ),
                        ),
                        child: Text(e, style: .new(fontWeight: .normal)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                FDivider(),
                const SizedBox(height: 24),

                AIFeedback(aiFeedback: entry.aiFeedback),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
