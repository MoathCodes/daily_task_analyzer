// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Daily Task AI Evaluator';

  @override
  String get homeTitle => 'Progress Dashboard';

  @override
  String get progress => 'Progress';

  @override
  String get noEntriesYet => 'No entries yet';

  @override
  String get addFirstTaskPrompt =>
      'Add your first daily task to see progress metrics.';

  @override
  String get vocabularyQuality => 'Vocabulary Quality';

  @override
  String get wordCount => 'Word Count';

  @override
  String get totalEntries => 'Total Entries';

  @override
  String get avgLettersPerWord => 'Avg. L/W';

  @override
  String get wordsPerEntry => 'Words/Entry';

  @override
  String get tasksLogged => 'Tasks Logged';

  @override
  String get newTask => 'New Task';

  @override
  String get addNewTask => 'Add New Task';

  @override
  String get recentEntries => 'Recent Entries';

  @override
  String get noEntriesYetTitle => 'No entries yet';

  @override
  String get useNewTaskButton =>
      'Use the \"New Task\" button to\ncreate your first daily task';

  @override
  String get tapPlusButton =>
      'Tap the + button to create\nyour first daily task';

  @override
  String get selectEntryDetails => 'Select an entry to see details';

  @override
  String get yourWritingProgress => 'Your Writing Progress';

  @override
  String get trackQualityQuantity =>
      'Track quality, quantity, and AI feedback across your journal entries.';

  @override
  String get wordsPerEntrySlash => 'Words / Entry';

  @override
  String get newDailyTask => 'New Daily Task';

  @override
  String get pleaseEnterText => 'Please enter some text to analyze';

  @override
  String analysisFailed(String error) {
    return 'Analysis failed: $error';
  }

  @override
  String get insightsAppearHere => 'Insights appear here';

  @override
  String get insightsDescription =>
      'Write your daily reflections and tap \"Analyze with AI\" to generate feedback and key vocabulary suggestions.';

  @override
  String get analysisResults => 'Analysis Results';

  @override
  String get words => 'Words';

  @override
  String get avgLW => 'Avg L/W';

  @override
  String get clarity => 'Clarity';

  @override
  String clarityScore(int score) {
    return '$score/5';
  }

  @override
  String get keyMetricsExplanation => 'Key Metrics Explanation';

  @override
  String get aiFeedback => 'AI Feedback';

  @override
  String get strongWords => 'Strong Words';

  @override
  String get captureReflection => 'Capture today\'s reflection';

  @override
  String get captureReflectionDescription =>
      'Describe what you learned, built, or observed. Richer details help the AI deliver more nuanced insights.';

  @override
  String get entryPlaceholder =>
      'Write or paste your daily task entry here...\n\n(e.g., \'Flutter is a cross-platform app development framework...\')';

  @override
  String get analyzeWithAI => 'Analyze with AI';

  @override
  String get runAnalysisPrompt =>
      'Run an analysis to unlock AI-generated insights.';

  @override
  String get saveToHistory => 'Save to History';

  @override
  String get quality => 'Quality';

  @override
  String get quantity => 'Quantity';

  @override
  String get analysisDetails => 'Analysis Details';

  @override
  String get yourEntry => 'Your Entry';

  @override
  String get quantitativeMetrics => 'Quantitative Metrics';

  @override
  String get keyVocabulary => 'Key Vocabulary';

  @override
  String get aiQualitativeFeedback => 'AI Qualitative Feedback';

  @override
  String get lettersSuffix => ' L/W';

  @override
  String get wordsSuffix => ' W';

  @override
  String fallbackFeedback(int wordCount, String avgLetters) {
    return 'Your writing has $wordCount words with an average of $avgLetters letters per word. Keep practicing to improve vocabulary richness!';
  }

  @override
  String fallbackKeyMetric(String avgLetters) {
    return 'Average word length: $avgLetters letters. Keep working on using more descriptive words.';
  }

  @override
  String get fallbackKeyMetricError => 'Keep working on your writing skills.';

  @override
  String get fallbackFeedbackBasic => 'Good effort! Keep writing.';

  @override
  String get fallbackKeyMetricBasic => 'Unable to calculate metrics.';

  @override
  String get textCannotBeEmpty => 'Text cannot be empty';
}
