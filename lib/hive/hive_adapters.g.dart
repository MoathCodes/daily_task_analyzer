// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class DailyTaskEntryAdapter extends TypeAdapter<DailyTaskEntry> {
  @override
  final typeId = 0;

  @override
  DailyTaskEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyTaskEntry(
      id: (fields[0] as num?)?.toInt(),
      date: fields[1] as DateTime,
      text: fields[2] as String,
      wordCount: (fields[3] as num).toInt(),
      avgLettersPerWord: (fields[4] as num).toDouble(),
      aiFeedback: fields[5] as String,
      keyVocabulary: (fields[6] as List).cast<String>(),
      keyMetric: fields[7] as String,
      avgWordLength: (fields[8] as num).toDouble(),
      clarityScore: (fields[9] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, DailyTaskEntry obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.wordCount)
      ..writeByte(4)
      ..write(obj.avgLettersPerWord)
      ..writeByte(5)
      ..write(obj.aiFeedback)
      ..writeByte(6)
      ..write(obj.keyVocabulary)
      ..writeByte(7)
      ..write(obj.keyMetric)
      ..writeByte(8)
      ..write(obj.avgWordLength)
      ..writeByte(9)
      ..write(obj.clarityScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyTaskEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
