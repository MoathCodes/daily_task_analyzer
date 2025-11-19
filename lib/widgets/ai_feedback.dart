import 'package:daily_task_analyzer/l10n/app_localizations.dart';
import 'package:daily_task_analyzer/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class AIFeedback extends StatelessWidget {
  final String aiFeedback;
  const AIFeedback({super.key, required this.aiFeedback});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = context.theme;
    return Column(
      children: [
        SectionHeader(
          icon: FIcons.wandSparkles,
          title: l10n.aiQualitativeFeedback,
          iconColor: Colors.purpleAccent, // Specific accent
        ),
        const SizedBox(height: 12),

        // Custom Violet Card
        // (We construct this manually because it deviates from the strict Zinc theme)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2E1065).withValues(alpha: 0.3), // violet-950/30
            border: Border.all(color: Colors.purpleAccent.withValues(alpha: 0.2)),
            borderRadius: theme.cardStyle.decoration.borderRadius,
          ),
          child: Text(
            aiFeedback,
            style: theme.typography.sm.copyWith(
              color: const Color(0xFFE9D5FF), // violet-100
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
