
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_task_entry.freezed.dart';

@freezed
abstract class DailyTaskEntry with _$DailyTaskEntry { 


  const factory DailyTaskEntry({
    required  int? id,
    required DateTime date,
    required String text,
    required int wordCount,
    required double avgLettersPerWord,
    required  String aiFeedback,
    required List<String> keyVocabulary,
    required String keyMetric,
    required double avgWordLength,
    required int clarityScore,
  }) = _DailyTaskEntry;
}
