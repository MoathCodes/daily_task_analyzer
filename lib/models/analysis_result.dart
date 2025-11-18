class AnalysisResult {
  final int wordCount;
  final double avgLettersPerWord;
  final String aiFeedback;
  final List<String> keyVocabulary;
  final String keyMetric;
  final double avgWordLength;
  final int clarityScore;

  AnalysisResult({
    required this.wordCount,
    required this.avgLettersPerWord,
    required this.aiFeedback,
    required this.keyVocabulary,
    required this.keyMetric,
    required this.avgWordLength,
    required this.clarityScore,
  });

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    return AnalysisResult(
      wordCount: json['wordCount'] as int,
      avgLettersPerWord: (json['avgLettersPerWord'] as num).toDouble(),
      aiFeedback: json['aiFeedback'] as String,
      keyVocabulary: (json['keyVocabulary'] as List).cast<String>(),
      keyMetric: json['keyMetric'] as String,
      avgWordLength: (json['avgWordLength'] as num).toDouble(),
      clarityScore: json['clarityScore'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'wordCount': wordCount,
    'avgLettersPerWord': avgLettersPerWord,
    'aiFeedback': aiFeedback,
    'keyVocabulary': keyVocabulary,
    'keyMetric': keyMetric,
    'avgWordLength': avgWordLength,
    'clarityScore': clarityScore,
  };
}
