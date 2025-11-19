import '../models/daily_task_entry.dart';

// Mock database of entries, based on the report's findings
// Notice the avgLettersPerWord is improving over time.
final List<DailyTaskEntry> mockEntries = [
  DailyTaskEntry(
    id: 1,
    date: DateTime(2025, 9, 21),
    text: "I like going to university. I hate hot days. It is very hot.",
    wordCount: 12,
    avgLettersPerWord: 3.1,
    aiFeedback:
        "This entry establishes a good baseline. The sentences are clear and direct.",
    keyVocabulary: ["university", "hot", "days"],
    keyMetric:
        "Average word length of 3.1 letters shows simple vocabulary. Clarity score of 2 indicates basic expression.",
    avgWordLength: 3.1,
    clarityScore: 2,
  ),
  DailyTaskEntry(
    id: 2,
    date: DateTime(2025, 10, 5),
    text:
        "Today the class was good. We learned about new things. I am trying to write more.",
    wordCount: 16,
    avgLettersPerWord: 3.8,
    aiFeedback:
        "Good consistency. The vocabulary is still simple but shows a desire to expand.",
    keyVocabulary: ["class", "learned", "write"],
    keyMetric:
        "Average word length of 3.8 letters shows slight improvement. Clarity score of 3 indicates understandable but simple expression.",
    avgWordLength: 3.8,
    clarityScore: 3,
  ),
  DailyTaskEntry(
    id: 3,
    date: DateTime(2025, 10, 26),
    text:
        "Flutter is a cross-platform app development framework made by Google.",
    wordCount: 12,
    avgLettersPerWord: 6.2,
    aiFeedback:
        "Excellent improvement! Your use of specific, technical terms like 'cross-platform' and 'framework' is a clear sign of vocabulary growth. This sentence is information-dense and precise.",
    keyVocabulary: ["Flutter", "cross-platform", "development", "framework"],
    keyMetric:
        "Average word length of 6.2 letters demonstrates strong use of descriptive vocabulary. Clarity score of 5 shows clear and specific message delivery.",
    avgWordLength: 6.2,
    clarityScore: 5,
  ),
  DailyTaskEntry(
    id: 4,
    date: DateTime(2025, 11, 11),
    text:
        "Such different environments result in online learning having much more cheating rate due to the students feeling anonymous.",
    wordCount: 22,
    avgLettersPerWord: 6.0,
    aiFeedback:
        "Strong analytical sentence. Your vocabulary ('environments', 'anonymous') accurately delivers a complex message, showing a 50%+ improvement in word quality from your early entries.",
    keyVocabulary: ["environments", "anonymous", "online learning", "cheating"],
    keyMetric:
        "Average word length of 6.0 letters demonstrates advanced vocabulary usage. Clarity score of 5 indicates precise analytical writing.",
    avgWordLength: 6.0,
    clarityScore: 5,
  ),
].reversed.toList(); // Show newest first
