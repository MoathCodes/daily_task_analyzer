import 'package:flutter/material.dart';

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

    return Scaffold(
      appBar: AppBar(title: Text(l10n.newDailyTask)),
      body: Container(
        decoration: const BoxDecoration(gradient: AppPalette.pageGradient),
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
    return Container(
      key: const ValueKey('placeholder'),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppPalette.surfaceHigh.withOpacity(0.7),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, size: 48, color: AppPalette.primary),
          const SizedBox(height: 16),
          Text(
            l10n.insightsAppearHere,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.insightsDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppPalette.textMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisResults() {
    final l10n = AppLocalizations.of(context)!;
    final result = _analysisResult!;

    return Container(
      key: const ValueKey('analysis-results'),
      decoration: BoxDecoration(
        color: AppPalette.surfaceHigh,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.analysisResults,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  l10n.words,
                  result.wordCount.toString(),
                  Icons.text_fields,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricItem(
                  l10n.avgLW,
                  result.avgWordLength.toStringAsFixed(1),
                  Icons.straighten,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricItem(
                  l10n.clarity,
                  l10n.clarityScore(result.clarityScore),
                  Icons.stars,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            l10n.keyMetricsExplanation,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppPalette.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppPalette.primary.withOpacity(0.3)),
            ),
            child: Text(
              result.keyMetric,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.aiFeedback,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            result.aiFeedback,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.6),
          ),
          if (result.keyVocabulary.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(
              l10n.strongWords,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: result.keyVocabulary
                  .map(
                    (word) => Chip(
                      label: Text(word),
                      backgroundColor: AppPalette.surface,
                      side: BorderSide(color: Colors.white.withOpacity(0.08)),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDesktopAnalysisPanel() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: _analysisResult == null
          ? _buildAnalysisPlaceholder()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildAnalysisResults(),
                const SizedBox(height: 24),
                _buildSaveButton(),
              ],
            ),
    );
  }

  Widget _buildFormSection(bool isDesktop) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppPalette.surfaceHigh.withOpacity(0.9),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [AppPalette.glow(AppPalette.surfaceHigh)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.captureReflection,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.captureReflectionDescription,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppPalette.textMuted),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _textController,
            minLines: isDesktop ? 14 : 8,
            maxLines: isDesktop ? 20 : 14,
            decoration: InputDecoration(hintText: l10n.entryPlaceholder),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _analyzeText,
            icon: const Icon(Icons.analytics_outlined),
            label: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(l10n.analyzeWithAI),
          ),
          if (!isDesktop && _analysisResult == null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                l10n.runAnalysisPrompt,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppPalette.textMuted),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: AppPalette.cardGradient,
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: AppPalette.secondary),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
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

  Widget _buildMobileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildFormSection(false),
        if (_analysisResult != null) ...[
          const SizedBox(height: 32),
          _buildAnalysisResults(),
          const SizedBox(height: 24),
          _buildSaveButton(),
        ],
      ],
    );
  }

  Widget _buildSaveButton() {
    final l10n = AppLocalizations.of(context)!;

    return FilledButton.icon(
      onPressed: _saveEntry,
      icon: const Icon(Icons.save),
      label: Text(l10n.saveToHistory),
    );
  }

  void _saveEntry() {
    if (_analysisResult == null) return;

    final entry = DailyTaskEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
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
