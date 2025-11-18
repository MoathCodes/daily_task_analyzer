import 'package:hivez_flutter/hivez_flutter.dart';

import '../models/daily_task_entry.dart';

/// Singleton instance of the repository
final dailyTaskEntryRepository = HivezDailyTaskEntryRepository();

/// Abstract interface for managing daily task entries
abstract class DailyTaskEntryRepository {
  Future<void> add(DailyTaskEntry entry);
  Future<void> clear();
  Future<void> delete(String id);
  Future<List<DailyTaskEntry>> getAll();
}

/// Hivez-backed implementation of the repository
class HivezDailyTaskEntryRepository implements DailyTaskEntryRepository {
  static const String _boxName = 'daily_task_entries';

  @override
  Future<void> add(DailyTaskEntry entry) async {
    final box = await _box();
    await box.add(entry);
  }

  @override
  Future<void> clear() async {
    final box = await _box();
    await box.clear();
  }

  @override
  Future<void> delete(String id) async {
    final box = await _box();
    final keys = await box.getAllKeys();
    for (final key in keys) {
      final entry = await box.get(key);
      if (entry?.id == id) {
        await box.delete(key);
        break;
      }
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
