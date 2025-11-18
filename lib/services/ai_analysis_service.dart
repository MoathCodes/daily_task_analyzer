import 'dart:convert';

import 'package:firebase_ai/firebase_ai.dart';

import '../models/analysis_result.dart';

class AiAnalysisService {
  late final GenerativeModel _model;

  AiAnalysisService() {
    _model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');
  }

  /// Analyzes the given text and returns structured analysis results
  /// [languageCode] should be 'en' for English or 'ar' for Arabic
  Future<AnalysisResult> analyzeText(
    String text, {
    String languageCode = 'en',
  }) async {
    if (text.trim().isEmpty) {
      throw ArgumentError('Text cannot be empty');
    }

    // Calculate basic metrics locally
    final words = text.split(RegExp(r'\s+'));
    final wordCount = words.length;
    final letters = text.replaceAll(RegExp(r'[^a-zA-Z\u0600-\u06FF]'), '');
    final avgLettersPerWord = letters.length / wordCount;

    // Create prompt for AI feedback based on language
    final prompt = [Content.text(_getPromptForLanguage(text, languageCode))];

    try {
      final response = await _model.generateContent(prompt);
      final responseText = response.text ?? '';

      print(responseText);

      // Parse AI response
      final aiData = _parseAiResponse(responseText);

      return AnalysisResult(
        wordCount: wordCount,
        avgLettersPerWord: avgLettersPerWord,
        aiFeedback: aiData['feedback'] as String,
        keyVocabulary: (aiData['strongWords'] as List).cast<String>(),
        keyMetric: aiData['keyMetric'] as String,
        avgWordLength: aiData['avgWordLength'] as double,
        clarityScore: aiData['clarityScore'] as int,
      );
    } catch (e) {
      // Fallback if AI fails
      return AnalysisResult(
        wordCount: wordCount,
        avgLettersPerWord: avgLettersPerWord,
        aiFeedback: _getFallbackFeedback(
          wordCount,
          avgLettersPerWord,
          languageCode,
        ),
        keyVocabulary: _extractBasicKeywords(words),
        keyMetric: _getFallbackKeyMetric(avgLettersPerWord, languageCode),
        avgWordLength: avgLettersPerWord,
        clarityScore: 3,
      );
    }
  }

  List<String> _extractBasicKeywords(List<String> words) {
    // Simple keyword extraction: words with 6+ letters
    final keywords = words.where((w) => w.length >= 6).take(5).toList()
      ..shuffle();
    return keywords.take(3).toList();
  }

  String _getFallbackFeedback(
    int wordCount,
    double avgLettersPerWord,
    String languageCode,
  ) {
    if (languageCode == 'ar') {
      return 'تحتوي كتابتك على $wordCount كلمة بمتوسط ${avgLettersPerWord.toStringAsFixed(1)} حرف لكل كلمة. استمر في الممارسة لتحسين ثراء المفردات!';
    } else {
      return 'Your writing has $wordCount words with an average of ${avgLettersPerWord.toStringAsFixed(1)} letters per word. Keep practicing to improve vocabulary richness!';
    }
  }

  String _getFallbackKeyMetric(double avgLettersPerWord, String languageCode) {
    if (languageCode == 'ar') {
      return 'متوسط طول الكلمة: ${avgLettersPerWord.toStringAsFixed(1)} حرف. استمر في العمل على استخدام كلمات أكثر وصفاً.';
    } else {
      return 'Average word length: ${avgLettersPerWord.toStringAsFixed(1)} letters. Keep working on using more descriptive words.';
    }
  }

  String _getPromptForLanguage(String text, String languageCode) {
    if (languageCode == 'ar') {
      return '''
أنت مدرب كتابة بالذكاء الاصطناعي مصمم لتحليل "المهمة اليومية" للطالب. هذا تمرين كتابة مُوقّت تحت ضغط عالٍ لمدة دقيقة واحدة حيث يقوم الطلاب بالعصف الذهني لمدة دقيقة واحدة، ثم يكتبون لمدة دقيقة واحدة.

هدفك هو تحليل النص التالي وتقديم ملاحظات.

النص: "$text"

مقياس النجاح في هذه المهمة ليس عدد الكلمات، والذي يُعتبر معيباً. بدلاً من ذلك، يُقاس النجاح بـ: 
1. جودة المفردات: هل يستخدم الطالب كلمات أكثر وصفاً ودقة وتقدماً (~6 حروف/كلمة، مثل "تطوير"، "منصات"، "إطار عمل") بدلاً من الكلمات البسيطة (~3 حروف/كلمة، مثل "أنا"، "يوم"، "حار")؟ 
2. وضوح الرسالة: هل الكتابة "تُوصل الرسالة بدقة"، أم أنها "فقط من أجل الكتابة" مع "عدم وجود رسالة لتوصيلها"؟

قدم تحليلك بتنسيق JSON التالي بالضبط:
```JSON
{
  "feedback": "تحليل موجز ومُشجع (2-3 جمل) حول اختيار المفردات ووضوح الرسالة، مع اقتراح محدد واحد للتحسين.",
  "keyMetric": "شرح من 1-2 جملة لـ 'avgWordLength' و 'clarityScore'، مع الإشارة إلى تقدم الطالب.",
  "strongWords": ["كلمة1", "كلمة2", "كلمة3"],
  "avgWordLength": 0.0,
  "clarityScore": 0
}
```

كيفية ملء JSON:

    "feedback": قدم ملاحظات قابلة للتنفيذ ومُشجعة تركز على اختيار الكلمات والوضوح. (بالعربية)

    "keyMetric": اشرح ما يعنيه avgWordLength و clarityScore. على سبيل المثال: "متوسط طول كلمتك البالغ 4.5 يُظهر مزيجاً جيداً من الكلمات البسيطة والمعقدة. وضوحك عالٍ، حيث نجحت في تعريف مفهوم تقني." (بالعربية)

    "strongWords": استخرج 3-5 من الكلمات الأكثر تحديداً أو وصفاً أو خاصة بالمجال المستخدمة في النص.

    "avgWordLength": احسب متوسط عدد الحروف لكل كلمة (إجمالي الحروف / إجمالي الكلمات).

    "clarityScore": قدم درجة من 1 إلى 5:
    * 1: غير واضح (مثل "أكره الأيام الحارة").
    * 3: مفهوم، لكنه بسيط (مثل "أحب الذهاب إلى الجامعة").
    * 5: واضح ووصفي (مثل "Flutter هو إطار عمل لتطوير التطبيقات متعدد المنصات").

**مهم جداً: يجب أن تكون جميع الملاحظات ("feedback" و "keyMetric") باللغة العربية فقط.**
''';
    } else {
      return '''
You are an AI writing coach designed to analyze a student's "Daily Task." This is a high-pressure, 1-minute timed writing exercise where students first brainstorm for one minute, then write for one minute.

Your goal is to analyze the following text and provide feedback.

Text: "$text"

The metric for success in this task is NOT word count, which is considered flawed. Instead, success is measured by: 
1. Vocabulary Quality: Is the student using more descriptive, specific, and advanced words (~6 letters/word, e.g., "framework," "anonymous," "cross-platform") instead of simple filler words (~3 letters/word, e.g., "I like," "hot days")? 
2. Message Clarity: Does the writing "accurately deliver the message", or is it "just for the sake of writing" with "no message to deliver"?

Provide your analysis in this exact JSON format:
```JSON
{
  "feedback": "A brief, encouraging analysis (2-3 sentences) on vocabulary choice and message clarity, with one specific suggestion for improvement.",
  "keyMetric": "A 1-2 sentence explanation of the 'avgWordLength' and 'clarityScore', referencing the student's progress.",
  "strongWords": ["word1", "word2", "word3"],
  "avgWordLength": 0.0,
  "clarityScore": 0
}
```

How to Populate the JSON:

    "feedback": Provide actionable, encouraging feedback focused on word choice and clarity.

    "keyMetric": Explain what the avgWordLength and clarityScore mean. For example: "Your average word length of 4.5 shows a good mix of simple and complex words. Your clarity is high, as you successfully defined a technical concept."

    "strongWords": Extract 3-5 of the most specific, descriptive, or domain-specific words used in the text.

    "avgWordLength": Calculate the average number of letters per word (total letters / total words).

    "clarityScore": Provide a score from 1 to 5:
    * 1: Unclear (e.g., "I hate hot days").
    * 3: Understandable, but simple (e.g., "I like going to university").
    * 5: Clear and descriptive (e.g., "Flutter is a cross-platform app development framework").
''';
    }
  }

  Map<String, dynamic> _parseAiResponse(String response) {
    try {
      // Extract JSON from markdown code blocks if present
      var jsonStr = response.trim();
      if (jsonStr.contains('```json')) {
        jsonStr = jsonStr
            .substring(jsonStr.indexOf('```json') + 7)
            .replaceFirst('```', '')
            .trim();
      } else if (jsonStr.contains('```')) {
        jsonStr = jsonStr
            .substring(jsonStr.indexOf('```') + 3)
            .replaceFirst('```', '')
            .trim();
      }

      // Try to find JSON object
      final jsonStart = jsonStr.indexOf('{');
      final jsonEnd = jsonStr.lastIndexOf('}');
      if (jsonStart != -1 && jsonEnd != -1) {
        jsonStr = jsonStr.substring(jsonStart, jsonEnd + 1);
      }

      // Parse JSON properly
      final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;

      return {
        'feedback': decoded['feedback'] ?? 'Good effort! Keep writing.',
        'strongWords':
            (decoded['strongWords'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        'keyMetric':
            decoded['keyMetric'] ?? 'Keep working on your writing skills.',
        'avgWordLength': (decoded['avgWordLength'] as num?)?.toDouble() ?? 4.0,
        'clarityScore': decoded['clarityScore'] as int? ?? 3,
      };
    } catch (e) {
      // If parsing fails, extract feedback from plain text
      return {
        'feedback': response.length > 200
            ? '${response.substring(0, 200)}...'
            : response,
        'strongWords': <String>[],
        'keyMetric': 'Unable to calculate metrics.',
        'avgWordLength': 4.0,
        'clarityScore': 3,
      };
    }
  }
}
