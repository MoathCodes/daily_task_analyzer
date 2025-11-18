import 'package:hive_ce/hive.dart';

part 'daily_task_entry.g.dart';

@HiveType(typeId: 1)
class DailyTaskEntry {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final String text;
  @HiveField(3)
  final int wordCount;
  @HiveField(4)
  final double avgLettersPerWord;
  @HiveField(5)
  final String aiFeedback;
  @HiveField(6)
  final List<String> keyVocabulary;
  @HiveField(7)
  final String keyMetric;
  @HiveField(8)
  final double avgWordLength;
  @HiveField(9)
  final int clarityScore;

  DailyTaskEntry({
    required this.id,
    required this.date,
    required this.text,
    required this.wordCount,
    required this.avgLettersPerWord,
    required this.aiFeedback,
    required this.keyVocabulary,
    required this.keyMetric,
    required this.avgWordLength,
    required this.clarityScore,
  });
}
