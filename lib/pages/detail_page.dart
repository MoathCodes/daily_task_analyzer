import 'package:flutter/material.dart';

import '../constants/app_palette.dart';
import '../models/daily_task_entry.dart';
import '../widgets/entry_detail_view.dart';

class DetailPage extends StatelessWidget {
  final DailyTaskEntry entry;

  const DetailPage({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${entry.date.day}/${entry.date.month}/${entry.date.year}"),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppPalette.pageGradient),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: EntryDetailView(entry: entry),
        ),
      ),
      extendBodyBehindAppBar: false,
    );
  }
}
