import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Daily Task AI Evaluator'**
  String get appTitle;

  /// Home page app bar title
  ///
  /// In en, this message translates to:
  /// **'Progress Dashboard'**
  String get homeTitle;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @noEntriesYet.
  ///
  /// In en, this message translates to:
  /// **'No entries yet'**
  String get noEntriesYet;

  /// No description provided for @addFirstTaskPrompt.
  ///
  /// In en, this message translates to:
  /// **'Add your first daily task to see progress metrics.'**
  String get addFirstTaskPrompt;

  /// No description provided for @vocabularyQuality.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary Quality'**
  String get vocabularyQuality;

  /// No description provided for @wordCount.
  ///
  /// In en, this message translates to:
  /// **'Word Count'**
  String get wordCount;

  /// No description provided for @totalEntries.
  ///
  /// In en, this message translates to:
  /// **'Total Entries'**
  String get totalEntries;

  /// No description provided for @avgLettersPerWord.
  ///
  /// In en, this message translates to:
  /// **'Avg. L/W'**
  String get avgLettersPerWord;

  /// No description provided for @wordsPerEntry.
  ///
  /// In en, this message translates to:
  /// **'Words/Entry'**
  String get wordsPerEntry;

  /// No description provided for @tasksLogged.
  ///
  /// In en, this message translates to:
  /// **'Tasks Logged'**
  String get tasksLogged;

  /// No description provided for @newTask.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get newTask;

  /// No description provided for @addNewTask.
  ///
  /// In en, this message translates to:
  /// **'Add New Task'**
  String get addNewTask;

  /// No description provided for @recentEntries.
  ///
  /// In en, this message translates to:
  /// **'Recent Entries'**
  String get recentEntries;

  /// No description provided for @noEntriesYetTitle.
  ///
  /// In en, this message translates to:
  /// **'No entries yet'**
  String get noEntriesYetTitle;

  /// No description provided for @useNewTaskButton.
  ///
  /// In en, this message translates to:
  /// **'Use the \"New Task\" button to\ncreate your first daily task'**
  String get useNewTaskButton;

  /// No description provided for @tapPlusButton.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to create\nyour first daily task'**
  String get tapPlusButton;

  /// No description provided for @selectEntryDetails.
  ///
  /// In en, this message translates to:
  /// **'Select an entry to see details'**
  String get selectEntryDetails;

  /// No description provided for @yourWritingProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Writing Progress'**
  String get yourWritingProgress;

  /// No description provided for @trackQualityQuantity.
  ///
  /// In en, this message translates to:
  /// **'Track quality, quantity, and AI feedback across your journal entries.'**
  String get trackQualityQuantity;

  /// No description provided for @wordsPerEntrySlash.
  ///
  /// In en, this message translates to:
  /// **'Words / Entry'**
  String get wordsPerEntrySlash;

  /// No description provided for @newDailyTask.
  ///
  /// In en, this message translates to:
  /// **'New Daily Task'**
  String get newDailyTask;

  /// No description provided for @pleaseEnterText.
  ///
  /// In en, this message translates to:
  /// **'Please enter some text to analyze'**
  String get pleaseEnterText;

  /// Error message when AI analysis fails
  ///
  /// In en, this message translates to:
  /// **'Analysis failed: {error}'**
  String analysisFailed(String error);

  /// No description provided for @insightsAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Insights appear here'**
  String get insightsAppearHere;

  /// No description provided for @insightsDescription.
  ///
  /// In en, this message translates to:
  /// **'Write your daily reflections and tap \"Analyze with AI\" to generate feedback and key vocabulary suggestions.'**
  String get insightsDescription;

  /// No description provided for @analysisResults.
  ///
  /// In en, this message translates to:
  /// **'Analysis Results'**
  String get analysisResults;

  /// No description provided for @words.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get words;

  /// No description provided for @avgLW.
  ///
  /// In en, this message translates to:
  /// **'Avg L/W'**
  String get avgLW;

  /// No description provided for @clarity.
  ///
  /// In en, this message translates to:
  /// **'Clarity'**
  String get clarity;

  /// Clarity score display
  ///
  /// In en, this message translates to:
  /// **'{score}/5'**
  String clarityScore(int score);

  /// No description provided for @keyMetricsExplanation.
  ///
  /// In en, this message translates to:
  /// **'Key Metrics Explanation'**
  String get keyMetricsExplanation;

  /// No description provided for @aiFeedback.
  ///
  /// In en, this message translates to:
  /// **'AI Feedback'**
  String get aiFeedback;

  /// No description provided for @strongWords.
  ///
  /// In en, this message translates to:
  /// **'Strong Words'**
  String get strongWords;

  /// No description provided for @captureReflection.
  ///
  /// In en, this message translates to:
  /// **'Capture today\'s reflection'**
  String get captureReflection;

  /// No description provided for @captureReflectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Describe what you learned, built, or observed. Richer details help the AI deliver more nuanced insights.'**
  String get captureReflectionDescription;

  /// No description provided for @entryPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write or paste your daily task entry here...\n\n(e.g., \'Flutter is a cross-platform app development framework...\')'**
  String get entryPlaceholder;

  /// No description provided for @analyzeWithAI.
  ///
  /// In en, this message translates to:
  /// **'Analyze with AI'**
  String get analyzeWithAI;

  /// No description provided for @runAnalysisPrompt.
  ///
  /// In en, this message translates to:
  /// **'Run an analysis to unlock AI-generated insights.'**
  String get runAnalysisPrompt;

  /// No description provided for @saveToHistory.
  ///
  /// In en, this message translates to:
  /// **'Save to History'**
  String get saveToHistory;

  /// No description provided for @quality.
  ///
  /// In en, this message translates to:
  /// **'Quality'**
  String get quality;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @analysisDetails.
  ///
  /// In en, this message translates to:
  /// **'Analysis Details'**
  String get analysisDetails;

  /// No description provided for @yourEntry.
  ///
  /// In en, this message translates to:
  /// **'Your Entry'**
  String get yourEntry;

  /// No description provided for @quantitativeMetrics.
  ///
  /// In en, this message translates to:
  /// **'Quantitative Metrics'**
  String get quantitativeMetrics;

  /// No description provided for @keyVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Key Vocabulary'**
  String get keyVocabulary;

  /// No description provided for @aiQualitativeFeedback.
  ///
  /// In en, this message translates to:
  /// **'AI Qualitative Feedback'**
  String get aiQualitativeFeedback;

  /// No description provided for @lettersSuffix.
  ///
  /// In en, this message translates to:
  /// **' L/W'**
  String get lettersSuffix;

  /// No description provided for @wordsSuffix.
  ///
  /// In en, this message translates to:
  /// **' W'**
  String get wordsSuffix;

  /// Fallback feedback when AI fails
  ///
  /// In en, this message translates to:
  /// **'Your writing has {wordCount} words with an average of {avgLetters} letters per word. Keep practicing to improve vocabulary richness!'**
  String fallbackFeedback(int wordCount, String avgLetters);

  /// Fallback key metric when AI fails
  ///
  /// In en, this message translates to:
  /// **'Average word length: {avgLetters} letters. Keep working on using more descriptive words.'**
  String fallbackKeyMetric(String avgLetters);

  /// No description provided for @fallbackKeyMetricError.
  ///
  /// In en, this message translates to:
  /// **'Keep working on your writing skills.'**
  String get fallbackKeyMetricError;

  /// No description provided for @fallbackFeedbackBasic.
  ///
  /// In en, this message translates to:
  /// **'Good effort! Keep writing.'**
  String get fallbackFeedbackBasic;

  /// No description provided for @fallbackKeyMetricBasic.
  ///
  /// In en, this message translates to:
  /// **'Unable to calculate metrics.'**
  String get fallbackKeyMetricBasic;

  /// No description provided for @textCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Text cannot be empty'**
  String get textCannotBeEmpty;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
