import 'package:daily_task_analyzer/widgets/ai_feedback.dart';
import 'package:daily_task_analyzer/widgets/metric_box.dart';
import 'package:daily_task_analyzer/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../constants/app_palette.dart';
import '../l10n/app_localizations.dart';
import '../models/analysis_result.dart';
import '../models/daily_task_entry.dart';
import '../services/ai_analysis_service.dart';

class AddEntryPage extends StatefulWidget {
  const AddEntryPage({super.key});

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;
  AnalysisResult? _analysisResult;
  final _aiService = AiAnalysisService();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return FScaffold(
      header: FHeader.nested(
        prefixes: [FHeaderAction.back(onPress: Navigator.of(context).pop)],
        title: Text(l10n.newDailyTask),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1000;
          return Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isDesktop ? 1200 : 640),
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: _buildFormSection(isDesktop),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 2,
                            child: _buildDesktopAnalysisPanel(),
                          ),
                        ],
                      )
                    : _buildMobileContent(),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _analyzeText() async {
    final locale = Localizations.localeOf(context);
    final l10n = AppLocalizations.of(context)!;

    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.pleaseEnterText)));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await _aiService.analyzeText(
        _textController.text,
        languageCode: locale.languageCode,
      );
      if (mounted) {
        setState(() {
          _analysisResult = result;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.analysisFailed(e.toString()))),
        );
      }
    }
  }

  Widget _buildAnalysisPlaceholder() {
    final l10n = AppLocalizations.of(context)!;
    final theme = context.theme;
    return SizedBox(
      height: 465,
      child: FCard(
        key: const ValueKey('placeholder'),
        // padding: const EdgeInsets.all(28),
        // decoration: BoxDecoration(
        //   color: AppPalette.surfaceHigh.withOpacity(0.7),
        //   borderRadius: BorderRadius.circular(32),
        //   border: Border.all(color: Colors.white.withOpacity(0.05)),
        // ),
        child: Expanded(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Icon(Icons.auto_awesome, size: 48, color: AppPalette.primary),
              const SizedBox(height: 16),
              Text(
                l10n.insightsAppearHere,
                style: theme.typography.xl.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.insightsDescription,
                textAlign: TextAlign.center,
                style: theme.typography.base.copyWith(
                  color: AppPalette.textMuted,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisResults() {
    final l10n = AppLocalizations.of(context)!;
    final result = _analysisResult!;
    final theme = context.theme;

    return FCard(
      key: const ValueKey('analysis-results'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.analysisResults,
            style: theme.typography.xl.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: MetricBox.icon(
                  label: l10n.words,
                  value: result.wordCount.toString(),
                  icon: FIcons.wholeWord,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MetricBox.icon(
                  label: l10n.avgLW,
                  value: result.avgWordLength.toStringAsFixed(1),
                  icon: FIcons.rulerDimensionLine,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MetricBox.icon(
                  label: l10n.clarity,
                  value: l10n.clarityScore(result.clarityScore),
                  icon: FIcons.star,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SectionHeader(title: l10n.keyMetricsExplanation),
          const SizedBox(height: 8),
          Text(
            result.keyMetric,
            style: theme.typography.base.copyWith(
              height: 1.6,
              color: theme.colors.mutedForeground,
            ),
          ),
          const SizedBox(height: 24),
          AIFeedback(aiFeedback: result.aiFeedback),
          if (result.keyVocabulary.isNotEmpty) ...[
            const SizedBox(height: 20),
            SectionHeader(title: l10n.keyVocabulary),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: result.keyVocabulary
                  .map(
                    (word) => FBadge(
                      style: (style) => style.copyWith(
                        decoration: style.decoration.copyWith(
                          color:
                              theme.colors.mutedForeground.withValues(alpha: 0.2),
                          border: Border.all(color: Colors.white),
                        ),
                      ),
                      child: Text(word, style: .new(color: Colors.white)),
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: 24),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildDesktopAnalysisPanel() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: _analysisResult == null
          ? _buildAnalysisPlaceholder()
          : _buildAnalysisResults(),
    );
  }

  Widget _buildFormSection(bool isDesktop) {
    final l10n = AppLocalizations.of(context)!;

    return FCard(
      // padding: const EdgeInsets.all(28),
      // decoration: BoxDecoration(
      //   color: AppPalette.surfaceHigh.withOpacity(0.9),
      //   borderRadius: BorderRadius.circular(32),
      //   border: Border.all(color: Colors.white.withOpacity(0.05)),
      // ),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(l10n.captureReflection),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(l10n.captureReflectionDescription),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FTextField.multiline(
            controller: _textController,
            minLines: isDesktop ? 14 : 8,
            maxLines: isDesktop ? 20 : 14,
            hint: l10n.entryPlaceholder,
            // decoration: InputDecoration(hintText: l10n.entryPlaceholder),
          ),
          const SizedBox(height: 16),
          FButton(
            onPress: _isLoading ? null : _analyzeText,
            prefix: const Icon(FIcons.wandSparkles),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: FCircularProgress.loader(),
                  )
                : Text(l10n.analyzeWithAI),
          ),
        ],
      ),
    );
  }



  Widget _buildMobileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildFormSection(false),
        if (_analysisResult != null) ...[
          const SizedBox(height: 32),
          _buildAnalysisResults(),
        ],
      ],
    );
  }

  Widget _buildSaveButton() {
    final l10n = AppLocalizations.of(context)!;

    return FButton(
      onPress: _saveEntry,
      prefix: const Icon(Icons.save),
      child: Text(l10n.saveToHistory),
    );
  }

  void _saveEntry() {
    if (_analysisResult == null) return;

    final entry = DailyTaskEntry(
      id: null,
      date: DateTime.now(),
      text: _textController.text,
      wordCount: _analysisResult!.wordCount,
      avgLettersPerWord: _analysisResult!.avgLettersPerWord,
      aiFeedback: _analysisResult!.aiFeedback,
      keyVocabulary: _analysisResult!.keyVocabulary,
      keyMetric: _analysisResult!.keyMetric,
      avgWordLength: _analysisResult!.avgWordLength,
      clarityScore: _analysisResult!.clarityScore,
    );

    Navigator.pop(context, entry);
  }
}
