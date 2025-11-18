// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مقيّم المهام اليومية بالذكاء الاصطناعي';

  @override
  String get homeTitle => 'لوحة متابعة التقدم';

  @override
  String get progress => 'التقدم';

  @override
  String get noEntriesYet => 'لا توجد إدخالات بعد';

  @override
  String get addFirstTaskPrompt => 'أضف أول مهمة يومية لعرض مقاييس التقدم.';

  @override
  String get vocabularyQuality => 'جودة المفردات اللغوية';

  @override
  String get wordCount => 'إجمالي عدد الكلمات';

  @override
  String get totalEntries => 'إجمالي الإدخالات';

  @override
  String get avgLettersPerWord => 'متوسط حروف/كلمة';

  @override
  String get wordsPerEntry => 'كلمات لكل إدخال';

  @override
  String get tasksLogged => 'المهام المسجّلة';

  @override
  String get newTask => 'مهمة جديدة';

  @override
  String get addNewTask => 'إضافة مهمة جديدة';

  @override
  String get recentEntries => 'الإدخالات الأخيرة';

  @override
  String get noEntriesYetTitle => 'لا توجد إدخالات بعد';

  @override
  String get useNewTaskButton =>
      'استخدم زر \"مهمة جديدة\"\nلإنشاء أول مهمة يومية لك';

  @override
  String get tapPlusButton => 'اضغط على زر + لإنشاء\nأول مهمة يومية لك';

  @override
  String get selectEntryDetails => 'اختر إدخالاً لرؤية التفاصيل';

  @override
  String get yourWritingProgress => 'تقدم كتابتك';

  @override
  String get trackQualityQuantity =>
      'تابع الجودة والكمية وملاحظات الذكاء الاصطناعي عبر إدخالات يومياتك.';

  @override
  String get wordsPerEntrySlash => 'كلمات لكل إدخال';

  @override
  String get newDailyTask => 'إضافة مهمة يومية جديدة';

  @override
  String get pleaseEnterText => 'يرجى إدخال نص ليتم تحليله';

  @override
  String analysisFailed(String error) {
    return 'فشل التحليل: $error';
  }

  @override
  String get insightsAppearHere => 'ستُعرض الرؤى هنا';

  @override
  String get insightsDescription =>
      'اكتب تأملاتك اليومية واضغط على \"تحليل بالذكاء الاصطناعي\" للحصول على ملاحظات واقتراحات لأهم المفردات.';

  @override
  String get analysisResults => 'نتائج التحليل التفصيلي';

  @override
  String get words => 'كلمات';

  @override
  String get avgLW => 'متوسط ح/ك';

  @override
  String get clarity => 'الوضوح';

  @override
  String clarityScore(int score) {
    return '$score/5';
  }

  @override
  String get keyMetricsExplanation => 'شرح المؤشرات الرئيسية';

  @override
  String get aiFeedback => 'ملاحظات من الذكاء الاصطناعي';

  @override
  String get strongWords => 'كلمات قوية';

  @override
  String get captureReflection => 'دوّن تأملات اليوم';

  @override
  String get captureReflectionDescription =>
      'صِف ما تعلّمته أو أنجزته أو لاحظته اليوم. التفاصيل الغنية تساعد الذكاء الاصطناعي على تقديم رؤى أدق وأعمق.';

  @override
  String get entryPlaceholder =>
      'اكتب أو الصق هنا إدخال مهمتك اليومية...\n\n(مثال: \"فلاتر إطار عمل لتطوير التطبيقات متعددة المنصات...\")';

  @override
  String get analyzeWithAI => 'حلّل بالذكاء الاصطناعي';

  @override
  String get runAnalysisPrompt =>
      'قم بتشغيل التحليل للحصول على رؤى من الذكاء الاصطناعي.';

  @override
  String get saveToHistory => 'حفظ في السجلّ';

  @override
  String get quality => 'الجودة';

  @override
  String get quantity => 'الكمية';

  @override
  String get analysisDetails => 'تفاصيل نتائج التحليل';

  @override
  String get yourEntry => 'إدخالك';

  @override
  String get quantitativeMetrics => 'المقاييس الكمية';

  @override
  String get keyVocabulary => 'أهم المفردات';

  @override
  String get aiQualitativeFeedback => 'الملاحظات النوعية من الذكاء الاصطناعي';

  @override
  String get lettersSuffix => ' ح/ك';

  @override
  String get wordsSuffix => ' ك';

  @override
  String fallbackFeedback(int wordCount, String avgLetters) {
    return 'يحتوي نصّك على $wordCount كلمة بمتوسط $avgLetters حرفًا لكل كلمة. استمر في الكتابة لتحسين ثراء مفرداتك!';
  }

  @override
  String fallbackKeyMetric(String avgLetters) {
    return 'متوسط طول الكلمة: $avgLetters حرفًا. استمر في محاولة استخدام كلمات أكثر وصفًا.';
  }

  @override
  String get fallbackKeyMetricError => 'واصل تطوير مهاراتك في الكتابة.';

  @override
  String get fallbackFeedbackBasic => 'عمل جيّد! استمر في الكتابة.';

  @override
  String get fallbackKeyMetricBasic => 'تعذّر حساب المؤشرات.';

  @override
  String get textCannotBeEmpty => 'لا يمكن أن يكون النص فارغًا';
}
