import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../constants/app_palette.dart';
import '../l10n/app_localizations.dart';
import '../models/daily_task_entry.dart';
import '../pages/add_entry_page.dart';
import '../pages/detail_page.dart';
import '../services/daily_task_entry_repository.dart';
import '../widgets/entry_card.dart';
import '../widgets/entry_detail_view.dart';
import '../widgets/metric_chart_card.dart';

class HomePage extends StatefulWidget {
  final void Function(Locale) onLocaleChange;
  
  const HomePage({super.key, required this.onLocaleChange});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DailyTaskEntry> _entries = [];
  DailyTaskEntry? _selectedEntry;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              final newLocale = currentLocale.languageCode == 'en' 
                ? const Locale('ar') 
                : const Locale('en');
              widget.onLocaleChange(newLocale);
            },
            tooltip: currentLocale.languageCode == 'en' ? 'العربية' : 'English',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppPalette.pageGradient),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < AppConstants.desktopBreakpoint) {
              return _buildMobileLayout();
            } else {
              return _buildDesktopLayout();
            }
          },
        ),
      ),
      floatingActionButton: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < AppConstants.desktopBreakpoint) {
            return FloatingActionButton(
              onPressed: _addEntry,
              tooltip: l10n.addNewTask,
              child: const Icon(Icons.add),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _addEntry() async {
    final newEntry = await Navigator.push<DailyTaskEntry>(
      context,
      MaterialPageRoute(builder: (context) => const AddEntryPage()),
    );

    if (newEntry != null) {
      await dailyTaskEntryRepository.add(newEntry);
      final fresh = await dailyTaskEntryRepository.getAll();
      setState(() {
        _entries = fresh;
        _selectedEntry = newEntry;
      });
    }
  }

  Widget _buildDesktopLayout() {
    final l10n = AppLocalizations.of(context)!;
    
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final hasEntries = _entries.isNotEmpty;
    final first = hasEntries ? _entries.first : null;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Pane (Metrics)
          Container(
            width: 270,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: AppPalette.surface.withOpacity(0.85),
              borderRadius: BorderRadius.circular(26.0),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
              boxShadow: [AppPalette.glow(AppPalette.primary)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.progress,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!hasEntries) ...[
                  const SizedBox(height: 18),
                  Text(
                    l10n.noEntriesYet,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppPalette.textMuted,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.addFirstTaskPrompt,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppPalette.textMuted,
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 18),
                  MetricChartCard(
                    title: l10n.vocabularyQuality,
                    value: first!.avgLettersPerWord.toStringAsFixed(1),
                    unit: l10n.avgLettersPerWord,
                    icon: Icons.auto_fix_high,
                    color: AppPalette.primary,
                    isDesktop: true,
                  ),
                  const SizedBox(height: 16),
                  MetricChartCard(
                    title: l10n.wordCount,
                    value: "${first.wordCount}",
                    unit: l10n.wordsPerEntry,
                    icon: Icons.keyboard,
                    color: AppPalette.secondary,
                    isDesktop: true,
                  ),
                  const SizedBox(height: 16),
                  MetricChartCard(
                    title: l10n.totalEntries,
                    value: "${_entries.length}",
                    unit: l10n.tasksLogged,
                    icon: Icons.event_note,
                    color: AppPalette.accent,
                    isDesktop: true,
                  ),
                ],
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _addEntry,
                    icon: const Icon(Icons.add),
                    label: Text(l10n.newTask),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Middle Pane (Entries List)
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: AppPalette.surfaceHigh.withOpacity(0.8),
                borderRadius: BorderRadius.circular(26.0),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.recentEntries,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _entries.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.note_add_outlined,
                                  size: 64,
                                  color: AppPalette.textMuted,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  l10n.noEntriesYetTitle,
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(color: AppPalette.textMuted),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  l10n.useNewTaskButton,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: AppPalette.textMuted),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            itemCount: _entries.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final entry = _entries[index];
                              return EntryCard(
                                entry: entry,
                                isSelected: _selectedEntry?.id == entry.id,
                                onTap: () {
                                  setState(() {
                                    _selectedEntry = entry;
                                  });
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 20),

          // Right Pane (Detail View)
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: AppPalette.surfaceHigh.withOpacity(0.9),
                borderRadius: BorderRadius.circular(26.0),
                border: Border.all(color: Colors.white.withOpacity(0.04)),
              ),
              child: _selectedEntry == null
                  ? Center(
                      child: Text(
                        l10n.selectEntryDetails,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  : EntryDetailView(entry: _selectedEntry!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    final l10n = AppLocalizations.of(context)!;
    
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final hasEntries = _entries.isNotEmpty;
    final first = hasEntries ? _entries.first : null;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.yourWritingProgress,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.trackQualityQuantity,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppPalette.textMuted),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: hasEntries ? 210 : 0,
            child: hasEntries
                ? Builder(
                    builder: (context) {
                      final metrics = [
                        (
                          title: l10n.vocabularyQuality,
                          value: first!.avgLettersPerWord.toStringAsFixed(1),
                          unit: l10n.avgLettersPerWord,
                          icon: Icons.auto_fix_high,
                          color: AppPalette.primary,
                        ),
                        (
                          title: l10n.wordCount,
                          value: "${first.wordCount}",
                          unit: l10n.wordsPerEntrySlash,
                          icon: Icons.keyboard,
                          color: AppPalette.secondary,
                        ),
                        (
                          title: l10n.totalEntries,
                          value: "${_entries.length}",
                          unit: l10n.tasksLogged,
                          icon: Icons.event_note,
                          color: AppPalette.accent,
                        ),
                      ];

                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        itemBuilder: (context, index) {
                          final metric = metrics[index];
                          return MetricChartCard(
                            title: metric.title,
                            value: metric.value,
                            unit: metric.unit,
                            icon: metric.icon,
                            color: metric.color,
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemCount: metrics.length,
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 8.0),
            child: Text(
              l10n.recentEntries,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          sliver: _entries.isEmpty
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.note_add_outlined,
                          size: 64,
                          color: AppPalette.textMuted,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.noEntriesYetTitle,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: AppPalette.textMuted),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.tapPlusButton,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppPalette.textMuted),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final entry = _entries[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: EntryCard(
                        entry: entry,
                        isSelected: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(entry: entry),
                            ),
                          );
                        },
                      ),
                    );
                  }, childCount: _entries.length),
                ),
        ),
      ],
    );
  }

  Future<void> _loadEntries() async {
    final items = await dailyTaskEntryRepository.getAll();
    setState(() {
      _entries = items;
      _selectedEntry = _entries.isNotEmpty ? _entries.first : null;
      _isLoading = false;
    });
  }
}

