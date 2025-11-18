import 'package:hive_ce_flutter/hive_flutter.dart';

import '../models/daily_task_entry.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<DailyTaskEntry>()])
class HiveAdapters {}
