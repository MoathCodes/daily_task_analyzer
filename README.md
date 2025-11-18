# Daily Task Analyzer

Daily Task Analyzer is a Flutter app that helps students practice short, high‑pressure writing and get instant feedback on the **quality** of their writing, not just the **quantity**.

Students write a quick "daily task" entry, and the app:

- Stores entries locally using `Hive`.
- Sends the text to Firebase AI (Gemini) to get structured feedback.
- Tracks metrics like word count and average word length.
- Visualizes progress with simple metrics cards and a detailed view.
- Supports **English** and **Arabic** UI/localized feedback.

This README is written for sharing the project with classmates, so it focuses on how to understand, run, and extend the app.

---

## Features

- **Daily writing entries**: Add a new entry with a short timed writing task.
- **AI‑powered analysis** (`lib/services/ai_analysis_service.dart`):
	- Uses `firebase_ai` with the `gemini-2.5-flash` model.
	- Returns JSON with feedback, key vocabulary, average word length, and a clarity score.
	- Falls back to local heuristics if AI fails.
- **Progress dashboard** (`lib/pages/home_page.dart`):
	- Desktop layout with three panes: metrics, entry list, and detail view.
	- Mobile layout with horizontally scrollable metric cards and a list of entries.
- **Local persistence**:
	- Uses `hivez_flutter` + generated adapters (`lib/hive/hive_adapters.dart`).
	- Model: `DailyTaskEntry` in `lib/models/daily_task_entry.dart`.
- **Internationalization (i18n)**:
	- Localizations generated from ARB files in `lib/l10n`.
	- Supports `en` and `ar` (see `AppLocalizations`).
- **Theming**:
	- Dark theme defined in `lib/theme/app_theme.dart` and `lib/constants/app_palette.dart`.

---

## Project Structure (high level)

- `lib/main.dart` – App entry point; initializes Hive and Firebase, sets up theming and localization.
- `lib/models/` – Data models (e.g., `DailyTaskEntry`, `AnalysisResult`).
- `lib/services/` – Core services:
	- `ai_analysis_service.dart` – wraps Firebase AI / Gemini.
	- `daily_task_entry_repository.dart` – CRUD operations for entries.
- `lib/pages/` – Screens (`HomePage`, `AddEntryPage`, `DetailPage`).
- `lib/widgets/` – Reusable UI widgets (entry cards, metric cards, detail view).
- `lib/l10n/` – Generated localization files and ARB configs.
- `web/` – Web build artifacts (for Flutter Web deployment).

---

## Prerequisites

Before running the project you will need:

- Flutter SDK (3.10+ recommended) installed and configured.
- A Google account with access to **Firebase Console**.
- **Firebase CLI** installed.
- **FlutterFire CLI** (which is installed via Dart `pub` / Flutter as a global tool).

### Install Flutter

Follow the official guide for your platform:

- https://docs.flutter.dev/get-started/install

Verify Flutter is working:

```bash
flutter --version
flutter doctor
```

### Install Firebase CLI

Install the Firebase CLI (pick the method that fits your OS). For most setups with Node.js:

```bash
npm install -g firebase-tools
```

Then log in:

```bash
firebase login
```

Reference: https://firebase.google.com/docs/cli

### Install FlutterFire CLI

Install the FlutterFire CLI as a global Dart/Flutter executable:

```bash
dart pub global activate flutterfire_cli
```

Make sure the global executables directory is on your `PATH` (the command above will print a hint if it is not).

Check that it works:

```bash
flutterfire --version
```

Reference: https://firebase.flutter.dev/docs/cli

---

## Firebase & FlutterFire Setup

If you already have a configured `firebase_options.dart` (this project includes one), you can usually **skip** to [Running the App](#running-the-app). This section explains how to recreate the setup from scratch if you fork or rebuild the project.

### 1. Create a Firebase project

1. Go to https://console.firebase.google.com.
2. Click **Add project** and follow the wizard.
3. Make sure **Google Analytics** is enabled if you want analytics (not required for this app).

Keep the project ID handy (e.g., `daily-task-analyzer-demo`).

### 2. Initialize Firebase in your local repo

From the project root (`daily_task_analyzer`):

```bash
firebase login             # if you haven't already
firebase init              # optional: for Hosting/Firestore/etc.
```

During `firebase init`, you can skip features you don’t need. For a minimal setup used by this app, you mainly need:

- **Firestore or Realtime Database** – not strictly required here (Hive stores entries locally), but you can add them later.
- **Hosting** – only if you want to deploy the Flutter web build.

This step will create or update the `firebase.json` file (already present in this repo).

### 3. Register your app platforms with FlutterFire

From the project root, run:

```bash
flutterfire configure
```

When prompted:

1. Select the Firebase project you just created.
2. Choose the platforms you want to support (e.g., Android, iOS, Web, Linux).
3. Accept the default app IDs or customize them as needed.

The command will generate or update:

- `lib/firebase_options.dart` – contains `DefaultFirebaseOptions.currentPlatform` used in `main.dart`.
- Various platform config files (e.g., `google-services.json`, `GoogleService-Info.plist`, `firebase_app_id_file.json`).

If you ever change your Firebase project or add new platforms, rerun:

```bash
flutterfire configure
```

### 4. Enable Firebase AI / Vertex AI (Gemini)

This project uses the `firebase_ai` package and expects access to the Gemini model `gemini-2.5-flash`:

1. In Firebase Console, go to **Build → Extensions / AI / Vertex AI** depending on Firebase’s current UI.
2. Ensure **Firebase AI** (or Gemini) is enabled for your project.
3. Verify your project has the correct billing plan and region for AI usage (Gemini typically requires a billing‑enabled project).

The code in `lib/services/ai_analysis_service.dart` uses:

```dart
_model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');
```

If you use a different model ID (e.g., `gemini-1.5-flash`), update it there accordingly.

---

## Running the App

From the project root:

1. Fetch dependencies:

	 ```bash
	 flutter pub get
	 ```

2. (Optional) Regenerate Hive adapters if you change models:

	 ```bash
	 flutter pub run build_runner build --delete-conflicting-outputs
	 ```

3. Run on your desired platform:

	 - For web:

		 ```bash
		 flutter run -d chrome
		 ```

	 - For Android (emulator or device):

		 ```bash
		 flutter run -d android
		 ```

	 - For Linux desktop:

		 ```bash
		 flutter run -d linux
		 ```

Make sure your selected device/platform is also configured with Firebase (via `flutterfire configure`).

---

## How the AI Analysis Works (high‑level)

When a user submits a daily task entry:

1. The app calculates basic metrics locally (word count, letters per word).
2. It builds a language‑aware prompt (English or Arabic) explaining the teaching goal.
3. It sends the prompt and text to the Gemini model using `firebase_ai`.
4. The response is expected to be JSON with fields like `feedback`, `strongWords`, `avgWordLength`, and `clarityScore`.
5. The JSON is parsed in `AiAnalysisService._parseAiResponse` and stored in an `AnalysisResult`.
6. Metrics and feedback are visualized on `HomePage` via widgets such as `MetricChartCard` and `EntryDetailView`.

If parsing fails or the API call throws, the app falls back to a simple heuristic based on average word length and returns generic but encouraging feedback.

---

## Presenting / Teaching Ideas

When sharing this project with the class, you might highlight:

- Why **word count** is a flawed metric for learning, and how this app focuses on **vocabulary quality** and **clarity** instead.
- How you integrated **Flutter**, **Firebase**, **Firebase AI (Gemini)**, and **Hive** together.
- How localization is handled with ARB files and generated localization code.
- Potential extensions:
	- Syncing entries to Firestore for backup.
	- Adding charts over time (e.g., clarity score vs. date).
	- Allowing teachers to view anonymized student progress.

---

## Troubleshooting

- **`firebase_options.dart` missing**: Rerun `flutterfire configure` and ensure the generated file is under `lib/`.
- **Firebase AI errors**: Check your Firebase project has AI/Gemini enabled and that your billing plan supports it.
- **Localization issues**: If you modify ARB files in `lib/l10n`, run `flutter gen-l10n` (or rely on Flutter’s automatic build step) and rebuild the app.
- **Hive adapter errors**: If you change any model with `@HiveType`, rerun the build runner command mentioned above.

If you run into setup problems that aren’t covered here, the official docs for Flutter, Firebase, and FlutterFire are the best next stop.

