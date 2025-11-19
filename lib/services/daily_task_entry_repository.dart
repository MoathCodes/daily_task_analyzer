import 'package:hivez_flutter/hivez_flutter.dart';

import '../models/daily_task_entry.dart';

/// Singleton instance of the repository
final dailyTaskEntryRepository = HivezDailyTaskEntryRepository();

/// Abstract interface for managing daily task entries
abstract class DailyTaskEntryRepository {
  Future<void> add(DailyTaskEntry entry);
  Future<void> clear();
  Future<void> delete(int id);
  Future<List<DailyTaskEntry>> getAll();
}

/// Hivez-backed implementation of the repository
class HivezDailyTaskEntryRepository implements DailyTaskEntryRepository {
  static const String _boxName = 'daily_task_entries';

  @override
  Future<void> add(DailyTaskEntry entry) async {
    final box = await _box();
    await box.add(entry);
    final id = await box.firstKeyWhere((key, value) => value == entry);
    if (id != null) {
      final en = entry.copyWith(id: id);
      await box.put(id, en);
    }
  }

  @override
  Future<void> clear() async {
    final box = await _box();
    await box.clear();
  }

  @override
  Future<void> delete(int id) async {
    final box = await _box();
    final values = await box.getValuesWhere((e) => e.id != null && e.id == id);
    for (final element in values) {
      await box.delete(element.id!);
    }
  }

  @override
  Future<List<DailyTaskEntry>> getAll() async {
    final box = await _box();
    final values = await box.getAllValues();
    // Sort by date descending (newest first)
    final list = values.toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  Future<Box<int, DailyTaskEntry>> _box() async {
    final box = Box<int, DailyTaskEntry>(_boxName);
    await box.ensureInitialized();
    return box;
  }
}
