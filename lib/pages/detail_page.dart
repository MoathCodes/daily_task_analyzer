import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../models/daily_task_entry.dart';
import '../widgets/entry_detail_view.dart';

class DetailPage extends StatelessWidget {
  final DailyTaskEntry entry;

  const DetailPage({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixes: [FHeaderAction.back(onPress: Navigator.of(context).pop)],
        title: Text("${entry.date.day}/${entry.date.month}/${entry.date.year}"),
      ),
      child: AnalysisDetailsPage(entry: entry),
    );
  }
}
