// --- Pubspec Dependencies ---
// This file requires the following dependencies in your pubspec.yaml:
//
// dependencies:
//   flutter:
//     sdk: flutter
//   genui: ^0.5.0
//   genui_firebase_ai: ^0.5.0
//   firebase_core: ^3.0.0
//   json_schema_builder: ^0.5.0
//
// (You must also follow the Firebase setup steps from the genui docs)
// ---

import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:genui_firebase_ai/genui_firebase_ai.dart';
import 'package:json_schema_builder/json_schema_builder.dart';
import 'package:firebase_core/firebase_core.dart';
// Note: You would need to add your own firebase_options.dart
// import 'firebase_options.dart';

// ---
// Step 1: Define the Schema for our Custom Widget
// This tells the AI what data the 'TaskAnalysisCard' widget needs.
// ---
final _taskAnalysisSchema = S.object(
  properties: {
    'wordCount': S.integer(
      description: "The total number of words in the user's text.",
    ),
    'avgLettersPerWord': S.number(
      description:
          "The average number of letters per word, calculated as total letters divided by word count.",
    ),
    'aiFeedback': S.string(
      description:
          "The AI's qualitative feedback, focusing on vocabulary, confidence, and sentence structure, referencing Moath's thesis.",
    ),
    'keyVocabulary': S.list(
      items: S.string(),
      description:
          "A list of 3-5 of the most advanced or 'quality' words the user wrote.",
    ),
  },
  required: ['wordCount', 'avgLettersPerWord', 'aiFeedback', 'keyVocabulary'],
);

// ---
// Step 2: Define the Custom Widget 'CatalogItem'
// This links the schema (TaskAnalysisCard) to a Flutter widget builder.
// We are essentially re-using the UI from our old 'DetailPage'.
// ---
final taskAnalysisCard = CatalogItem(
  name: 'TaskAnalysisCard',
  dataSchema: _taskAnalysisSchema,
  widgetBuilder: ({data, id, buildChild, dispatchEvent, context, dataContext}) {
    // Parse the data from the AI
    final json = data as Map<String, Object?>;
    final wordCount = json['wordCount'] as int;
    final avgLetters = json['avgLettersPerWord'] as double;
    final feedback = json['aiFeedback'] as String;
    final vocab = (json['keyVocabulary'] as List).cast<String>();

    // Build the widget (This UI is taken from our previous 'EntryDetailView')
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailCard(
            context,
            title: "AI Analysis",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetricDisplay(
                  context,
                  label: "Word Count",
                  value: wordCount.toString(),
                  color: Colors.green,
                ),
                _buildMetricDisplay(
                  context,
                  label: "Avg. Letters / Word",
                  value: avgLetters.toStringAsFixed(1),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          _buildDetailCard(
            context,
            title: "Qualitative Feedback",
            child: Text(
              feedback,
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
          _buildDetailCard(
            context,
            title: "Key Vocabulary",
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: vocab
                  .map(
                    (word) => Chip(
                      label: Text(word),
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  },
);

// --- Helper Widgets (copied from our previous version) ---

Widget _buildDetailCard(
  BuildContext context, {
  required String title,
  required Widget child,
}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(height: 24),
        child,
      ],
    ),
  );
}

Widget _buildMetricDisplay(
  BuildContext context, {
  required String label,
  required String value,
  required Color color,
}) {
  return Column(
    children: [
      Text(
        value,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
      ),
    ],
  );
}
// --- End Helper Widgets ---

void main() async {
  // main() must be async and initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // You must have a 'firebase_options.dart' file for this to work
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // For this example, we'll run without Firebase initialization
  runApp(const DailyTaskApp());
}

class DailyTaskApp extends StatelessWidget {
  const DailyTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenUI Task Evaluator',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ).copyWith(secondary: Colors.amber),
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ---
// Step 3: Refactor the HomePage to be a Conversational UI
// We remove all the old layout logic (mobile/desktop) and replace it
// with the standard genui chat interface.
// ---
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final GenUiManager _genUiManager;
  late final GenUiConversation _genUiConversation;

  final _textController = TextEditingController();
  final _surfaceIds = <String>[];

  @override
  void initState() {
    super.initState();

    // ---
    // Step 4: Configure the GenUiManager
    // We give it our custom 'taskAnalysisCard' widget.
    // ---
    _genUiManager = GenUiManager(
      catalog: CoreCatalogItems.asCatalog().copyWith([taskAnalysisCard]),
    );

    // ---
    // Step 5: Configure the ContentGenerator (the AI)
    // This is the "prompt" for our AI evaluator.
    // ---
    final contentGenerator = FirebaseAiContentGenerator(
      // This is the most important part!
      systemInstruction: '''
        You are an AI writing coach for a Daily Task app. Your persona is based on the research of Moath Altamimi.
        Your core principle is that **writing improvement is about QUALITY (vocabulary, confidence, message clarity) not just QUANTITY (word count)**.
        
        Your user will provide their daily task text. You MUST respond by doing the following:
        1.  Analyze the user's text.
        2.  Calculate the `wordCount`.
        3.  Calculate the `avgLettersPerWord` (vocabulary quality metric).
        4.  Identify 3-5 `keyVocabulary` words.
        5.  Write a brief `aiFeedback` paragraph, praising their word choice and message clarity.
        6.  You MUST return this analysis by generating a `TaskAnalysisCard` widget.
        
        Start the conversation by introducing yourself and asking the user to submit their daily task.
        ''',
      tools: _genUiManager.getTools(),
      // In a real app, you would pass a real Firebase model here:
      // model: FirebaseVertexAI.instance.generativeModel(model: 'gemini-1.5-flash'),
    );

    // ---
    // Step 6: Configure the GenUiConversation
    // This orchestrates the manager and the generator.
    // ---
    _genUiConversation = GenUiConversation(
      genUiManager: _genUiManager,
      contentGenerator: contentGenerator,
      onSurfaceAdded: _onSurfaceAdded,
      onSurfaceDeleted: _onSurfaceDeleted,
    );

    // Bonus: Send a "start" message to get a greeting from the AI
    _genUiConversation.sendRequest(UserMessage.text("Hello"));
  }

  @override
  void dispose() {
    _textController.dispose();
    _genUiConversation.dispose();
    super.dispose();
  }

  // Send a message containing the user's text to the agent.
  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    _genUiConversation.sendRequest(UserMessage.text(text));
  }

  // A callback invoked by the [GenUiConversation] when a new UI surface is generated.
  void _onSurfaceAdded(SurfaceAdded update) {
    setState(() {
      _surfaceIds.add(update.surfaceId);
    });
  }

  // A callback invoked by GenUiConversation when a UI surface is removed.
  void _onSurfaceDeleted(SurfaceRemoved update) {
    setState(() {
      _surfaceIds.remove(update.surfaceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Task Evaluator')),
      body: Column(
        children: [
          // ---
          // Step 7: Render the AI-generated surfaces
          // This ListView builds a GenUiSurface for each ID we track.
          // This will render the AI's text responses and our 'TaskAnalysisCard' widgets.
          // ---
          Expanded(
            child: ListView.builder(
              itemCount: _surfaceIds.length,
              itemBuilder: (context, index) {
                // For each surface, create a GenUiSurface to display it.
                final id = _surfaceIds[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GenUiSurface(
                    host: _genUiConversation.host,
                    surfaceId: id,
                  ),
                );
              },
            ),
          ),
          // ---
          // Step 8: Render the Chat Input Box
          // This replaces the "AddEntryPage" from our old app.
          // ---
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Paste your daily task here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                      ),
                      onSubmitted: (value) {
                        _sendMessage(_textController.text);
                        _textController.clear();
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Send the user's text to the agent.
                      _sendMessage(_textController.text);
                      _textController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
