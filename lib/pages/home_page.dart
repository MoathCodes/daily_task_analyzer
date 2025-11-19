import 'package:daily_task_analyzer/data/mock_data.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return FScaffold(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < AppConstants.desktopBreakpoint) {
            return _buildMobileLayout();
          } else {
            return _buildDesktopLayout();
          }
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
    final currentLocale = Localizations.localeOf(context);
    final theme = context.theme;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final hasEntries = _entries.isNotEmpty;
    final first = hasEntries ? _entries.first : null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Pane (Metrics)
        Expanded(
          child: FSidebar(
            width: 280,
            style: (style) => style.copyWith(
              footerPadding: EdgeInsets.all(12),
              contentPadding: EdgeInsets.all(12),
            ),
            footer: SizedBox(
              width: double.infinity,
              child: FButton(
                onPress: _addEntry,
                prefix: const Icon(Icons.add),
                child: Text(l10n.newTask),
              ),
            ),
            // padding: const EdgeInsets.all(20.0),
            // decoration: BoxDecoration(
            //   color: AppPalette.surface.withOpacity(0.85),
            //   borderRadius: BorderRadius.circular(26.0),
            //   border: Border.all(color: Colors.white.withOpacity(0.05)),
            //   boxShadow: [AppPalette.glow(AppPalette.primary)],
            // ),
            header: Row(
              children: [
                Text(
                  l10n.progress,
                  style: theme.typography.lg.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            children: [
              if (!hasEntries) ...[
                const SizedBox(height: 18),
                Text(
                  l10n.noEntriesYet,
                  style: theme.typography.base.copyWith(
                    color: AppPalette.textMuted,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.addFirstTaskPrompt,
                  style: theme.typography.sm.copyWith(
                    color: AppPalette.textMuted,
                  ),
                ),
                const SizedBox(height: 16),
                FButton(
                  onPress: () async {
                    for (final entry in mockEntries) {
                      await dailyTaskEntryRepository.add(entry);
                    }
                    _loadEntries();
                  },
                  child: Text("Populate Database"),
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
            ],
          ),
        ),

        // Middle Pane (Entries List)
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border.all(color: theme.colors.border),
              color: theme.cardStyle.decoration.color,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.recentEntries,
                  style: theme.typography.lg.copyWith(
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
                                style: theme.typography.xl.copyWith(
                                  color: AppPalette.textMuted,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                l10n.useNewTaskButton,
                                textAlign: TextAlign.center,
                                style: theme.typography.base.copyWith(
                                  color: AppPalette.textMuted,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          itemCount: _entries.length,
                          separatorBuilder: (context, index) =>
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

        // Right Pane (Detail View)
        Expanded(
          flex: 2,
          child: Container(
            padding: theme.cardStyle.contentStyle.padding,
            decoration: theme.cardStyle.decoration.copyWith(
              borderRadius: .zero,
            ),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                FHeader(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.analysisDetails,
                        style: theme.typography.lg.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ?(_selectedEntry != null
                          ? Text(
                              "${_selectedEntry!.date.day}/${_selectedEntry!.date.month}/${_selectedEntry!.date.year}",
                              style: theme.typography.xs.copyWith(
                                color: theme.colors.mutedForeground,
                              ),
                            )
                          : null),
                    ],
                  ),
                  suffixes: [
                    if (_selectedEntry != null)
                      FTooltip(
                        tipBuilder: (context, controller) =>
                            Text("Delete Entry"),
                        child: FButton.icon(
                          onPress: _deleteEntry,
                          style: FButtonStyle.destructive(),
                          child: Icon(FIcons.trash),
                        ),
                      ),
                    FTooltip(
                      tipBuilder: (context, controller) =>
                          currentLocale.languageCode == 'en'
                          ? const Text('العربية')
                          : const Text('English'),
                      child: FButton.icon(
                        onPress: () {
                          final newLocale = currentLocale.languageCode == 'en'
                              ? const Locale('ar')
                              : const Locale('en');
                          widget.onLocaleChange(newLocale);
                        },
                        child: const Icon(Icons.language),
                      ),
                    ),
                    FTooltip(
                      tipBuilder: (context, controller) =>
                          Text('View on GitHub'),
                      child: FButton.icon(
                        child: const Icon(Icons.code),
                        onPress: () => launchUrl(
                          Uri.parse(
                            'https://github.com/MoathCodes/daily_task_analyzer',
                          ),
                        ),
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth <
                            AppConstants.desktopBreakpoint) {
                          return FButton(
                            onPress: _addEntry,
                            prefix: const Icon(Icons.add),
                            child: Text(l10n.addNewTask),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
                FDivider(style: (style) => style.copyWith(padding: .all(4))),
                Expanded(
                  child: _selectedEntry == null
                      ? Center(
                          child: Text(
                            l10n.selectEntryDetails,
                            style: theme.typography.lg,
                          ),
                        )
                      : AnalysisDetailsPage(entry: _selectedEntry!),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context);
    final theme = context.theme;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final hasEntries = _entries.isNotEmpty;
    final first = hasEntries ? _entries.first : null;

    return CustomScrollView(
      slivers: [
        // Header with actions (language toggle, add, repo)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: FHeader(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.yourWritingProgress,
                    style: theme.typography.xl.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.trackQualityQuantity,
                    style: theme.typography.sm.copyWith(
                      color: AppPalette.textMuted,
                    ),
                  ),
                ],
              ),
              suffixes: [
                FTooltip(
                  tipBuilder: (context, controller) =>
                      currentLocale.languageCode == 'en'
                      ? const Text('العربية')
                      : const Text('English'),
                  child: FButton.icon(
                    onPress: () {
                      final newLocale = currentLocale.languageCode == 'en'
                          ? const Locale('ar')
                          : const Locale('en');
                      widget.onLocaleChange(newLocale);
                    },
                    child: const Icon(Icons.language),
                  ),
                ),
                FTooltip(
                  tipBuilder: (context, controller) => const Text('GitHub'),
                  child: FButton.icon(
                    onPress: () => launchUrl(
                      Uri.parse(
                        'https://github.com/MoathCodes/daily_task_analyzer',
                      ),
                    ),
                    child: const Icon(Icons.code),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: const SizedBox(height: 8)),
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

                      return SizedBox(
                        height: 180,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 16),
                          itemCount: metrics.length,
                        ),
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 8.0),
            child: Row(
              children: [
                Text(
                  l10n.recentEntries,
                  style: theme.typography.xl.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                FButton.icon(
                  onPress: _addEntry,
                  child: const Icon(Icons.add),
                  // child: Text(l10n.newTask),
                ),
              ],
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
                          style: theme.typography.xl.copyWith(
                            color: AppPalette.textMuted,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.tapPlusButton,
                          textAlign: TextAlign.center,
                          style: theme.typography.base.copyWith(
                            color: AppPalette.textMuted,
                          ),
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

  void _deleteEntry() async {
    final bool? confirmed = await showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        style: style.call,
        animation: animation,
        direction: Axis.horizontal,
        title: const Text('Are you absolutely sure?'),
        body: const Text(
          'This action cannot be undone. This will permanently delete this daily task.',
        ),
        actions: [
          FButton(
            style: FButtonStyle.outline(),
            onPress: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FButton(
            style: FButtonStyle.destructive(),
            onPress: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (_selectedEntry != null && confirmed == true) {
      await dailyTaskEntryRepository.delete(_selectedEntry!.id!);
      setState(() {
        _selectedEntry = null;
        _loadEntries();
      });
    }
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
