# Student Learning App — Complete Viva Preparation Guide

This document covers **every single file** in the app, line by line, in plain simple language. Read this and you'll be able to explain any part of your app in the viva.

---

## Table of Contents

1. [Big Picture — What Does This App Do?](#1-big-picture)
2. [How the App is Organized (Folder Structure)](#2-folder-structure)
3. [How Screens Connect (Navigation Flow)](#3-navigation-flow)
4. [File 1: pubspec.yaml — The App's Config File](#4-pubspecyaml)
5. [File 2: main.dart — The Starting Point](#5-maindart)
6. [File 3: learning_data.dart — All the Data](#6-learning_datadart)
7. [File 4: home_screen.dart — The Home Page](#7-home_screendart)
8. [File 5: chapter_list_screen.dart — Chapter List Page](#8-chapter_list_screendart)
9. [File 6: study_material_screen.dart — Study Notes Page](#9-study_material_screendart)
10. [File 7: quiz_screen.dart — Quiz Page](#10-quiz_screendart)
11. [Key Flutter Concepts Used](#11-key-concepts)
12. [Common Viva Questions and Answers](#12-viva-qa)

---

## 1. Big Picture

This is a **Student Learning App** built with Flutter. Think of it like a mini offline learning platform.

**What it does:**
- Shows a list of **subjects** (Computer Networks, Operating Systems, Data Structures, Database Management)
- Each subject has **chapters** inside it
- Each chapter has **study notes** (summary + key points)
- Each chapter also has an **MCQ quiz** at the end
- The quiz shows your score, gives explanations for answers, and lets you review

**No internet needed.** All the data (subjects, chapters, questions) is hardcoded right inside the app itself. There's no backend, no API, no database. Everything lives inside one Dart file called `learning_data.dart`.

**The user flow is simple:**
```
Home Screen -> Pick a Subject -> See its Chapters -> Read Study Notes -> Take Quiz -> See Score
```

---

## 2. Folder Structure

```
student_learning_app/
  assets/
    avatar.jpg              <-- Profile picture shown in the side drawer
  lib/
    main.dart               <-- App starts here
    models/
      learning_data.dart    <-- All subjects, chapters, questions data
    screens/
      home_screen.dart         <-- First screen you see (subject grid)
      chapter_list_screen.dart <-- List of chapters for a subject
      study_material_screen.dart <-- Study notes for one chapter
      quiz_screen.dart         <-- MCQ quiz for one chapter
  pubspec.yaml              <-- App configuration (name, assets, dependencies)
```

**Why this structure?**
- `models/` holds the data classes — the shape/structure of our data
- `screens/` holds the UI pages — what the user actually sees
- `assets/` holds non-code files like images
- `main.dart` is always the entry point of any Flutter app

---

## 3. Navigation Flow

Here's how the user moves through the app, screen by screen:

```
+---------------------+
|     HomeScreen       |  <-- User lands here first
|  (Grid of subjects) |
+---------+-----------+
          | User taps a subject card
          v
+-------------------------+
|   ChapterListScreen     |  <-- Shows all chapters for that subject
|  (List of chapters)     |
+---------+---------------+
          | User taps a chapter
          v
+--------------------------+
|   StudyMaterialScreen    |  <-- Summary + key points for that chapter
|  (Notes + "Take Quiz")  |
+---------+----------------+
          | User taps "Take Quiz"
          v
+---------------------+
|     QuizScreen      |  <-- MCQ quiz, submit, see score, review answers
+---------------------+
```

**How does navigation actually work in code?**
We use `Navigator.push()`. Think of it like stacking cards on top of each other:
- Each new screen is a card placed on top
- The back button removes the top card and shows the one below
- `Navigator.push(context, MaterialPageRoute(...))` adds a new screen
- `Navigator.pop(context)` goes back to the previous screen

---

## 4. pubspec.yaml

This is the **configuration file** for the entire Flutter project. It's not Dart code — it's written in YAML format (a simple key-value format).

```yaml
name: student_learning_app
```
This is the **name of your project**. Flutter uses this internally. It must be lowercase with underscores.

```yaml
description: "A new Flutter project."
```
A short text description of what the app is. Just metadata.

```yaml
publish_to: 'none'
```
This tells Dart "do NOT publish this package to pub.dev" (pub.dev is the public Dart package registry). Since this is a personal project, we keep it private.

```yaml
version: 1.0.0+1
```
The app version. `1.0.0` is the version name users see. `+1` is the internal build number.

```yaml
environment:
  sdk: ^3.12.2
```
This says "this app needs Dart SDK version 3.12.2 or higher". The `^` means "compatible with".

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
```
**Dependencies** are packages (libraries) your app needs.
- `flutter` itself is a dependency (the framework)
- `cupertino_icons` gives us iOS-style icons (like the Apple-design icons). We don't heavily use it, but Flutter projects include it by default.

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```
**Dev dependencies** are only used during development, not in the final app.
- `flutter_test` lets us write tests
- `flutter_lints` gives code quality warnings/suggestions

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/avatar.jpg
```
The `flutter:` section configures Flutter-specific settings:
- `uses-material-design: true` — enables Material Design icons (the `Icons.` family)
- `assets:` — lists files that should be bundled into the app. Without listing `assets/avatar.jpg` here, the app wouldn't be able to load that image.

---

## 5. main.dart — The Starting Point

This is where Flutter starts running. Every Flutter app must have a `main()` function.

### Full Code

```dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const StudentLearningApp());
}

class StudentLearningApp extends StatelessWidget {
  const StudentLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Learning App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E293B),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0F172A),
          elevation: 0,
          scrolledUnderElevation: 1,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
```

### Line-by-Line Breakdown

**Line 1:** `import 'package:flutter/material.dart';`
This brings in Flutter's Material Design library. It gives us access to all the widgets — Scaffold, AppBar, Text, Container, Column, Row, Card, everything. Without this import, we can't build any UI.

**Line 2:** `import 'screens/home_screen.dart';`
This imports our own HomeScreen widget from the screens folder. We need it because that's the first screen we want to show.

**Line 4-6:** `void main() { runApp(const StudentLearningApp()); }`
- `void main()` — This is THE entry point. When you run the app, Dart looks for this function first and runs whatever is inside it.
- `runApp(...)` — This is a Flutter function that takes a widget and makes it the root of the entire app. It basically says "take this widget and put it on the screen, full screen."
- `const StudentLearningApp()` — This creates an instance of our app widget. The `const` keyword means "this object won't change at build time" which helps Flutter optimize performance.

**Line 8:** `class StudentLearningApp extends StatelessWidget`
We're creating a new widget called StudentLearningApp. It extends StatelessWidget because this root widget itself doesn't change or hold any data that changes over time. It just sets up the app once.

**Line 9:** `const StudentLearningApp({super.key});`
This is the constructor. `super.key` passes the key parameter up to the parent class (StatelessWidget). Keys help Flutter identify which widget is which when rebuilding the UI.

**Line 11-12:** `@override Widget build(BuildContext context)`
- `@override` tells Dart "I'm overriding a method from the parent class."
- The `build` method returns what should be drawn on screen. Flutter calls this method whenever the widget needs to be rendered.
- `context` holds information about where this widget sits in the widget tree.

**Line 13:** `MaterialApp(...)`
This is the top-level wrapper widget for any Material Design app. It handles setting up navigation, applying the theme (colors, fonts), and managing routes.

**Line 14:** `debugShowCheckedModeBanner: false`
Hides the red "DEBUG" banner that appears in the top-right corner during development.

**Line 15:** `title: 'Student Learning App'`
The title shown in the OS task switcher (like when you alt-tab on desktop or see recent apps on mobile).

**Lines 16-28:** `theme: ThemeData(...)`
This sets the visual style for the entire app. Every screen automatically inherits these settings.
- `useMaterial3: true` — Uses the latest Material Design 3 style (more rounded, modern look).
- `scaffoldBackgroundColor: Color(0xFFF8FAFC)` — The background color of every screen. 0xFFF8FAFC is a very light grayish-white. The `0xFF` prefix means "fully opaque" (no transparency).
- `ColorScheme.fromSeed(seedColor: Color(0xFF1E293B))` — Flutter generates a complete color palette (primary, secondary, error colors, etc.) from this one "seed" color. 0xFF1E293B is a dark slate/navy blue.
- `brightness: Brightness.light` — Tells Flutter this is a light theme (not dark mode).
- `AppBarTheme` — Customizes the top bar on every screen:
  - `backgroundColor: Colors.white` — white top bar
  - `foregroundColor: Color(0xFF0F172A)` — dark text/icons on the bar
  - `elevation: 0` — no shadow under the bar (flat look)
  - `scrolledUnderElevation: 1` — slight shadow when you scroll content under it

**Line 30:** `home: const HomeScreen()`
This tells MaterialApp which screen to show first when the app opens. It's our HomeScreen widget.

---

## 6. learning_data.dart — All the Data

This file holds **three data classes** and one **big list** of sample data. Think of it as our "fake database."

### Full Code

```dart
import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });
}

class Chapter {
  final String id;
  final int chapterNumber;
  final String title;
  final String duration;
  final String summary;
  final List<String> keyPoints;
  final List<Question> quiz;

  const Chapter({
    required this.id,
    required this.chapterNumber,
    required this.title,
    required this.duration,
    required this.summary,
    required this.keyPoints,
    required this.quiz,
  });
}

class Subject {
  final String id;
  final String title;
  final String code;
  final IconData icon;
  final Color color;
  final List<Chapter> chapters;

  const Subject({
    required this.id,
    required this.title,
    required this.code,
    required this.icon,
    required this.color,
    required this.chapters,
  });
}

final List<Subject> sampleSubjects = [
  // ... (4 subjects with their chapters and questions)
];
```

### Breakdown

#### Question Class

This defines what a quiz question looks like. Every Question object has:
- **`questionText`** — The actual question ("Which OSI layer is responsible for...?")
- **`options`** — A list of 4 answer choices, stored as strings
- **`correctOptionIndex`** — Which option is correct (0 = first, 1 = second, 2 = third, 3 = fourth)
- **`explanation`** — Why that answer is correct (shown after quiz submission)

`final` means once a value is set, it can never be changed.
`required` means you MUST provide this value when creating a Question object.
`const` on the constructor means the object can be created at compile time for better performance.

#### Chapter Class

A Chapter represents one study module inside a subject:
- **`id`** — A unique string identifier like `'cn_ch1'`
- **`chapterNumber`** — The number displayed (1, 2, 3...)
- **`title`** — The chapter name ("Network Models & OSI Reference")
- **`duration`** — Estimated reading time ("25 mins")
- **`summary`** — A paragraph explaining the chapter topic
- **`keyPoints`** — A list of bullet points — the key study notes
- **`quiz`** — A list of Question objects for the chapter quiz

Notice how `quiz` is `List<Question>` — a chapter CONTAINS questions. This is called **composition** — one class holds objects of another class.

#### Subject Class

A Subject represents one course:
- **`id`** — Unique identifier like `'ccn'`
- **`title`** — Display name ("Computer Networks")
- **`code`** — Course code ("CS-501")
- **`icon`** — The Material icon to show (e.g., Icons.hub_outlined)
- **`color`** — The accent color for this subject (blue, teal, purple, orange)
- **`chapters`** — A list of Chapter objects inside this subject

`IconData` is Flutter's type for icon references. `Color` is Flutter's type for colors.

### The Data Hierarchy

```
Subject (e.g., Computer Networks)
  +-- Chapter (e.g., Network Models & OSI)
        +-- Question (e.g., "Which OSI layer...?")
```

A Subject **contains** Chapters. A Chapter **contains** Questions. This is a tree/hierarchy structure.

### The Sample Data

`sampleSubjects` is a global variable — any file that imports `learning_data.dart` can directly access it. It's the single source of all content in the app.

There are 4 subjects total:

| Subject | Code | Color | Chapters |
|---|---|---|---|
| Computer Networks | CS-501 | Blue | 4 chapters |
| Operating Systems | CS-502 | Teal | 1 chapter |
| Data Structures | CS-503 | Purple | 1 chapter |
| Database Management | CS-504 | Orange | 1 chapter |

---

## 7. home_screen.dart — The Home Page

This is the first screen the user sees. It shows a welcome banner, a subject grid, and has a side drawer.

### Full Code

```dart
import 'package:flutter/material.dart';
import '../models/learning_data.dart';
import 'chapter_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Learning App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: const Text('About Learning App'),
                    content: const Text(
                      'Mini-Project: Student Learning App\n'
                      'Focus: Computer Networks & CS Core\n'
                      'Built with vanilla Flutter (No external APIs).',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
              accountName: Text(
                'Manthan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF0F172A),
                ),
              ),
              accountEmail: Text(
                '2024.manthanb@isu.ac.in',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xFFE2E8F0),
                backgroundImage: AssetImage('assets/avatar.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text('Enrolled Subjects'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.quiz_outlined),
              title: const Text('Practice Quizzes'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Select any subject below to practice quizzes!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            const Divider(),
            const ListTile(
              title: Text('Semester V'),
              subtitle: Text('B.Tech 2025-2026'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, Manthan',
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Select a subject below to explore chapters, study notes, and quizzes.',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Subjects & Syllabus',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: sampleSubjects.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  final subject = sampleSubjects[index];
                  return Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChapterListScreen(subject: subject),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: subject.color.withAlpha(25),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                subject.icon,
                                color: subject.color,
                                size: 28,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              subject.code,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: subject.color,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subject.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${subject.chapters.length} ${subject.chapters.length == 1 ? "Chapter" : "Chapters"}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Breakdown

**Imports:**
- `material.dart` — gives us all Flutter widgets
- `learning_data.dart` — gives us access to `sampleSubjects` (the data)
- `chapter_list_screen.dart` — we need this because tapping a subject navigates to ChapterListScreen

**`StatelessWidget`** — The home screen doesn't have any internal state that changes. The grid of subjects is always the same (it reads from `sampleSubjects` which doesn't change). So StatelessWidget is the right choice.

**The AppBar:**
- `title:` — The text "Student Learning App" in bold
- `centerTitle: true` — Centers the title text
- `actions:` — Widgets placed on the right side of the AppBar
  - There's one `IconButton` with an info icon (Icons.info_outline)
  - When pressed, it calls `showDialog()` which pops up an **AlertDialog** — a modal popup box
  - The dialog shows basic info about the app
  - The "OK" button calls `Navigator.pop(context)` to close the dialog

**The Drawer (Side Menu):**
- `Drawer` — A side panel that slides in from the left when you tap the hamburger menu icon (three horizontal lines). Flutter automatically adds the hamburger icon to the AppBar when you set a `drawer`.
- `UserAccountsDrawerHeader` — A ready-made widget for showing user profile info at the top of a drawer:
  - `accountName` — shows "Manthan"
  - `accountEmail` — shows the email
  - `currentAccountPicture` — shows a CircleAvatar with the profile picture loaded from `assets/avatar.jpg` using AssetImage
- `ListTile` — A pre-built widget for showing a row with an icon and text. Perfect for menu items.
  - The first one ("Enrolled Subjects") just closes the drawer with Navigator.pop(context)
  - The second one ("Practice Quizzes") closes the drawer AND shows a **SnackBar** — a small notification banner at the bottom of the screen
- `ScaffoldMessenger.of(context).showSnackBar(...)` — This is how you show a SnackBar in Flutter. ScaffoldMessenger finds the nearest Scaffold and shows the SnackBar on it.
- `Divider()` — Draws a horizontal line separator.

**The Welcome Banner:**
- `Container` — The most flexible widget. Think of it as a div in HTML. It can have padding, margin, color, borders, size — anything.
  - `width: double.infinity` — Take up the full width available
  - `padding: EdgeInsets.all(16.0)` — 16 pixels of inner spacing on all sides
  - `decoration: BoxDecoration(...)` — White background, rounded corners (12px radius), light gray border
- `Column` — Arranges children vertically (top to bottom). `crossAxisAlignment: CrossAxisAlignment.start` aligns children to the left.
- `SizedBox(height: 4)` — An invisible box that just adds 4 pixels of vertical space. Simplest way to add gaps.

**The Subject Grid:**
- `Expanded` — Tells the widget to take up ALL remaining vertical space. Without it, the GridView wouldn't know how tall to be.
- `GridView.builder` — Creates a scrollable grid. The `.builder` creates items on demand (only builds visible cards for better performance).
  - `itemCount: sampleSubjects.length` — 4 items
  - `crossAxisCount: 2` — 2 columns
  - `crossAxisSpacing: 14` — 14px gap between columns
  - `mainAxisSpacing: 14` — 14px gap between rows
  - `childAspectRatio: 0.95` — slightly taller than wide
- `Card` — A material design card. `elevation: 0` means no shadow (flat look).
- `InkWell` — Makes any widget tappable with a ripple animation effect. `onTap:` navigates to ChapterListScreen, passing the subject.
- Inside each card:
  1. **Icon badge** — A colored rounded square with the subject icon. `subject.color.withAlpha(25)` makes a very faint background.
  2. **Spacer()** — Pushes content below to the bottom of the card.
  3. **Subject code** (like "CS-501") in the subject's color
  4. **Subject title** — `maxLines: 2` limits to 2 lines, `TextOverflow.ellipsis` adds "..." if too long
  5. **Chapter count** — Uses string interpolation and ternary for "Chapter" vs "Chapters"

---

## 8. chapter_list_screen.dart — Chapter List Page

This screen shows all chapters for the subject the user tapped.

### Full Code

```dart
import 'package:flutter/material.dart';
import '../models/learning_data.dart';
import 'study_material_screen.dart';

class ChapterListScreen extends StatelessWidget {
  final Subject subject;

  const ChapterListScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          subject.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject.code,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: subject.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subject.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${subject.chapters.length} Modules & Quizzes',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Course Curriculum',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: subject.chapters.length,
              itemBuilder: (context, index) {
                final chapter = subject.chapters[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    leading: Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${chapter.chapterNumber}',
                        style: const TextStyle(
                          color: Color(0xFF1E293B),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    title: Text(
                      chapter.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        '${chapter.duration}  *  ${chapter.quiz.length} MCQs',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudyMaterialScreen(
                            subject: subject,
                            chapter: chapter,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

### Breakdown

**This screen receives a Subject object.** When the user taps "Computer Networks" on the home screen, the ChapterListScreen is created with that subject passed in. This is how data flows from one screen to another in Flutter — through constructor parameters.

**The Subject Header Card:**
A header card at the top showing the subject code, full title, and how many chapters it has. Same flat white card style with border.
- `margin: EdgeInsets.all(16.0)` — space OUTSIDE the container (pushes it away from screen edges)
- `padding: EdgeInsets.all(16.0)` — space INSIDE the container (pushes content away from edges)

**The Chapter List:**
- `ListView.builder` — Like GridView.builder but makes a vertical scrollable list instead of a grid. Builds items lazily.
- Each chapter is displayed as a ListTile:
  - `leading:` — The widget on the left side: a small rounded square showing the chapter number
  - `title:` — The chapter title
  - `subtitle:` — Duration and number of MCQs ("25 mins * 3 MCQs")
  - `onTap:` — Navigates to StudyMaterialScreen, passing BOTH the subject and chapter
- `EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)` — 16px padding on left/right, 8px on top/bottom. "Symmetric" means equal on opposite sides.

---

## 9. study_material_screen.dart — Study Notes Page

This screen shows the study content for a specific chapter. It's a **StatefulWidget** because it has a checkbox that changes state.

### Full Code

```dart
import 'package:flutter/material.dart';
import '../models/learning_data.dart';
import 'quiz_screen.dart';

class StudyMaterialScreen extends StatefulWidget {
  final Subject subject;
  final Chapter chapter;

  const StudyMaterialScreen({
    super.key,
    required this.subject,
    required this.chapter,
  });

  @override
  State<StudyMaterialScreen> createState() => _StudyMaterialScreenState();
}

class _StudyMaterialScreenState extends State<StudyMaterialScreen> {
  bool _isMarkedAsRead = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chapter ${widget.chapter.chapterNumber}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chapter.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Chip(
                  label: Text(widget.subject.code),
                  backgroundColor: widget.subject.color.withAlpha(20),
                  labelStyle: TextStyle(
                    color: widget.subject.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 8),
                Text(
                  'Reading time: ${widget.chapter.duration}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Summary Card
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Chapter Overview',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.chapter.summary,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF334155),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Key Points Card
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Key Concepts & Definitions',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...widget.chapter.keyPoints.map(
                      (point) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '* ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                point,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF334155),
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Checkbox Card
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: CheckboxListTile(
                value: _isMarkedAsRead,
                title: const Text(
                  'Mark module as completed',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                subtitle: const Text(
                  'Track your progress through this chapter',
                  style: TextStyle(fontSize: 11),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? value) {
                  setState(() {
                    _isMarkedAsRead = value ?? false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _isMarkedAsRead
                            ? 'Chapter marked as completed!'
                            : 'Chapter progress unmarked.',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // Take Quiz Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF1E293B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(
                        subject: widget.subject,
                        chapter: widget.chapter,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Take Chapter Quiz (${widget.chapter.quiz.length} Questions)',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Breakdown

**StatefulWidget vs StatelessWidget:**
- `StudyMaterialScreen` is the widget class — holds the configuration (subject, chapter)
- `_StudyMaterialScreenState` is the state class — holds data that can change (`_isMarkedAsRead`)
- `createState()` creates the state object
- Access widget properties using `widget.subject`, `widget.chapter`

Why StatefulWidget? Because this screen has a "Mark module as completed" checkbox. When the user checks/unchecks it, the UI needs to update. StatelessWidget can't do that.

**`bool _isMarkedAsRead = false;`** — A boolean tracking whether the checkbox is checked. The underscore `_` means it's private.

**SingleChildScrollView** — Wraps the Column to make the entire page scrollable. Without it, if the content is taller than the screen, it would overflow and cause an error.

**The Chapter Header:**
- `Chip` — A small rounded label widget, used here to show the subject code (like "CS-501") with a colored background.
- `Row` — Arranges children horizontally. Here it puts the chip and reading time side by side.

**The Summary Card:**
A flat card showing the chapter summary text. `height: 1.5` in the TextStyle sets line height (spacing between lines of text).

**The Key Points Card:**
- `...widget.chapter.keyPoints.map(...)` — The **spread operator** (`...`):
  1. `widget.chapter.keyPoints` is a List of strings
  2. `.map(...)` transforms each string into a widget (a Row with bullet and text)
  3. `...` spreads those widgets into the parent's children list
- `Expanded` makes the text take up the remaining width so it wraps properly.

**The Checkbox:**
- `CheckboxListTile` — A ListTile with a built-in checkbox.
  - `value: _isMarkedAsRead` — whether checked or not (bound to our state variable)
  - `controlAffinity: ListTileControlAffinity.leading` — checkbox on the left side
  - `onChanged:` — when tapped:
    - **`setState(() { ... })`** — THIS IS THE KEY CONCEPT. Tells Flutter "I've changed some data, please rebuild the UI." Without setState, the screen won't visually update.
    - `value ?? false` — the `??` operator means "if value is null, use false instead"
    - Also shows a SnackBar confirming the action

**The Take Quiz Button:**
- `ElevatedButton` — A filled button. `onPressed:` navigates to QuizScreen, passing subject and chapter.

---

## 10. quiz_screen.dart — Quiz Page

This is the most complex screen. It's a StatefulWidget because quiz state constantly changes.

### Full Code

```dart
import 'package:flutter/material.dart';
import '../models/learning_data.dart';

class QuizScreen extends StatefulWidget {
  final Subject subject;
  final Chapter chapter;

  const QuizScreen({
    super.key,
    required this.subject,
    required this.chapter,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final Map<int, int> _selectedAnswers = {};
  bool _isSubmitted = false;

  void _selectOption(int optionIndex) {
    if (_isSubmitted) return;
    setState(() {
      _selectedAnswers[_currentQuestionIndex] = optionIndex;
    });
  }

  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < widget.chapter.quiz.length; i++) {
      if (_selectedAnswers[i] == widget.chapter.quiz[i].correctOptionIndex) {
        score++;
      }
    }
    return score;
  }

  void _submitQuiz() {
    final score = _calculateScore();
    final total = widget.chapter.quiz.length;

    setState(() {
      _isSubmitted = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Row(
          children: [
            Icon(Icons.emoji_events_outlined, color: Colors.amber, size: 28),
            SizedBox(width: 8),
            Text('Quiz Completed!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Score: $score / $total',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              score == total
                  ? 'Excellent work! You mastered this chapter.'
                  : score >= total / 2
                      ? 'Good effort! Review the explanations to reinforce concepts.'
                      : 'Keep practicing! Review the study notes and try again.',
              style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Review Answers'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E293B),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = widget.chapter.quiz;
    final currentQuestion = quiz[_currentQuestionIndex];
    final selectedOption = _selectedAnswers[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz: Ch ${widget.chapter.chapterNumber}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${_currentQuestionIndex + 1} of ${quiz.length}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF64748B),
                  ),
                ),
                Text(
                  '${_selectedAnswers.length}/${quiz.length} Answered',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / quiz.length,
              backgroundColor: const Color(0xFFE2E8F0),
              color: const Color(0xFF1E293B),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 18),
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentQuestion.questionText,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RadioGroup<int>(
                groupValue: selectedOption,
                onChanged: (int? value) {
                  if (!_isSubmitted && value != null) {
                    _selectOption(value);
                  }
                },
                child: ListView.builder(
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, optIndex) {
                    final optionText = currentQuestion.options[optIndex];
                    final isSelected = selectedOption == optIndex;

                    Color tileBorderColor = const Color(0xFFE2E8F0);
                    Color tileBgColor = Colors.white;

                    if (_isSubmitted) {
                      if (optIndex == currentQuestion.correctOptionIndex) {
                        tileBorderColor = Colors.green;
                        tileBgColor = Colors.green.withAlpha(25);
                      } else if (isSelected) {
                        tileBorderColor = Colors.red;
                        tileBgColor = Colors.red.withAlpha(25);
                      }
                    } else if (isSelected) {
                      tileBorderColor = const Color(0xFF1E293B);
                      tileBgColor = const Color(0xFFF1F5F9);
                    }

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      color: tileBgColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: tileBorderColor, width: 1.2),
                      ),
                      child: RadioListTile<int>(
                        value: optIndex,
                        activeColor: const Color(0xFF1E293B),
                        title: Text(
                          optionText,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (_isSubmitted) ...[
              Card(
                color: const Color(0xFFF8FAFC),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline, size: 18, color: Color(0xFF475569)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Explanation: ${currentQuestion.explanation}',
                          style: const TextStyle(fontSize: 12, color: Color(0xFF334155)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            Row(
              children: [
                if (_currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _currentQuestionIndex--;
                        });
                      },
                      child: const Text('Previous'),
                    ),
                  ),
                if (_currentQuestionIndex > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFF1E293B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_currentQuestionIndex < quiz.length - 1) {
                        setState(() {
                          _currentQuestionIndex++;
                        });
                      } else if (!_isSubmitted) {
                        _submitQuiz();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      _currentQuestionIndex < quiz.length - 1
                          ? 'Next'
                          : (_isSubmitted ? 'Done Reviewing' : 'Submit Quiz'),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### Breakdown

**State Variables:**
- `_currentQuestionIndex` — Which question is currently displayed (0 = first, 1 = second...)
- `_selectedAnswers` — A Map (dictionary) that stores which option the user picked for each question. Example: `{0: 2, 1: 1}` means "for question 0, picked option 2; for question 1, picked option 1"
- `_isSubmitted` — Whether the quiz has been submitted

**_selectOption method:**
When user taps an option:
- If quiz already submitted, do nothing (`return`)
- Otherwise, save the selected option index for the current question
- `setState` triggers a UI rebuild so the selected option looks visually different

**_calculateScore method:**
Loops through every question. For each one, compares the user's answer (`_selectedAnswers[i]`) with the correct answer (`quiz[i].correctOptionIndex`). If they match, add 1 to the score.

**_submitQuiz method:**
1. Calculate the score
2. Set `_isSubmitted = true` so options can't be changed anymore
3. Show an AlertDialog with:
   - A trophy icon and "Quiz Completed!" title
   - The score ("Your Score: 2 / 3")
   - A feedback message based on performance (uses nested ternary operators)
4. Two buttons:
   - "Review Answers" — closes the dialog but stays on the quiz screen to see which were right/wrong
   - "Finish" — calls Navigator.pop TWICE: once to close the dialog, once to go back to the previous screen
- `barrierDismissible: false` — Prevents closing the dialog by tapping outside it.

**The Progress Indicator:**
- `LinearProgressIndicator` — A horizontal progress bar.
  - `value:` — a number between 0.0 and 1.0. Example: question 2 of 3 = 2/3 = 0.67 = 67% filled.

**The Options List with Radio Buttons:**
- `RadioGroup<int>` — Groups radio buttons together so only one can be selected at a time.
- `RadioListTile<int>` — A ListTile with a radio button built in.
  - `value: optIndex` — this radio button's value (0, 1, 2, or 3)
  - `groupValue: selectedOption` — which value is currently selected. The radio whose value matches this gets filled.

**Color Logic (the if/else chain):**
- After submission:
  - Correct answer -> green border + green tint background
  - Wrong answer that user picked -> red border + red tint background
  - Everything else -> default gray
- Before submission:
  - Selected option -> dark border + light gray background
  - Everything else -> default gray

**The Explanation Card:**
- `if (_isSubmitted) ...[...]` — This is a conditional list spread. Only includes these widgets if the quiz has been submitted.

**Navigation Buttons:**
- **Previous button** — Only shows if we're not on the first question. Decrements the index.
- **Next/Submit button** — Changes behavior based on context:
  - If there are more questions -> "Next" (increments index)
  - If on last question and not submitted -> "Submit Quiz" (calls _submitQuiz())
  - If already submitted -> "Done Reviewing" (goes back with Navigator.pop)

---

## 11. Key Flutter Concepts Used

| Concept | Where It's Used | What It Does |
|---|---|---|
| StatelessWidget | HomeScreen, ChapterListScreen | Widget that never changes internally |
| StatefulWidget | StudyMaterialScreen, QuizScreen | Widget that holds changeable data |
| setState() | Checkbox, quiz option selection | Tells Flutter to rebuild the UI |
| Navigator.push() | Every screen transition | Adds a new screen on top |
| Navigator.pop() | Back button, dialog close | Removes the current screen |
| MaterialApp | main.dart | Root wrapper with theme and nav |
| Scaffold | Every screen | Basic page structure (AppBar + body) |
| AppBar | Every screen | Top navigation bar |
| GridView.builder | HomeScreen | Lazy-loaded grid layout |
| ListView.builder | ChapterListScreen, QuizScreen | Lazy-loaded scrollable list |
| Container | Everywhere | Flexible box with styling |
| Column | Everywhere | Vertical layout |
| Row | Many places | Horizontal layout |
| Card | Subject cards, content sections | Rounded container with border |
| Drawer | HomeScreen | Side navigation panel |
| AlertDialog | Info button, quiz result | Popup dialog box |
| SnackBar | Drawer item, checkbox | Bottom notification banner |
| CheckboxListTile | StudyMaterialScreen | Checkbox with label |
| RadioListTile | QuizScreen | Radio button with label |
| ElevatedButton | Quiz, study material | Filled action button |
| OutlinedButton | Quiz "Previous" | Button with just border |
| TextButton | Dialog buttons | Flat text-only button |
| LinearProgressIndicator | QuizScreen | Horizontal progress bar |
| InkWell | Subject cards | Adds tap + ripple effect |
| Chip | StudyMaterialScreen | Small rounded label |
| ListTile | Drawer menu, chapter list | Standard row widget |
| CircleAvatar | Drawer | Circular profile picture |
| AssetImage | Drawer avatar | Loads image from assets |
| SingleChildScrollView | StudyMaterialScreen | Makes content scrollable |
| Expanded | Grid, list, text | Takes remaining space |
| Spacer | Subject card layout | Pushes content apart |
| SizedBox | Everywhere | Adds fixed spacing |
| Divider | Drawer | Horizontal line |

---

## 12. Common Viva Questions and Answers

**Q: What is the difference between StatelessWidget and StatefulWidget?**
A: StatelessWidget is for screens/widgets that don't change after being built. Like our HomeScreen — the subject grid is always the same. StatefulWidget is for screens that need to update — like the QuizScreen where selected answers and scores change. StatefulWidget has a separate State class that holds the changeable data, and you call setState() to tell Flutter to rebuild the UI.

**Q: What does setState() do?**
A: It tells Flutter "hey, I've changed some data, please redraw this widget." Without calling setState(), even if you change a variable's value, the screen won't visually update. Flutter only rebuilds what's needed, not the entire app.

**Q: How does navigation work in your app?**
A: We use Navigator.push() to go to a new screen and Navigator.pop() to go back. Think of it as a stack of cards — push adds a card on top, pop removes the top card. When going from HomeScreen to ChapterListScreen, we call Navigator.push(context, MaterialPageRoute(builder: (context) => ChapterListScreen(subject: subject))). We pass data (like the subject) through the constructor.

**Q: What is BuildContext?**
A: Context is like a "location marker" — it tells a widget where it sits in the widget tree. We need it for things like navigation (Navigator.of(context)) and showing snackbars (ScaffoldMessenger.of(context)) because these need to know where in the widget tree to look for the Navigator or Scaffold.

**Q: Why did you use GridView.builder instead of GridView?**
A: .builder creates items lazily — it only builds the widgets that are currently visible on screen. If we had 100 subjects, it wouldn't create all 100 cards at once. This is better for performance and memory. Regular GridView with children: [...] creates everything upfront.

**Q: How does data flow between screens?**
A: Through constructor parameters. When we navigate to ChapterListScreen, we pass subject: subject in its constructor. That screen stores it as final Subject subject and uses it to display the right data. Same thing for StudyMaterialScreen which receives both subject and chapter.

**Q: What is the final keyword?**
A: final means a variable can only be set once and never changed after that. All our data class properties are final — once a Question is created with its text and options, those values can never be modified. This makes the data predictable and safe.

**Q: What is const and how is it different from final?**
A: Both prevent reassignment, but const is stricter — the value must be known at compile time (before the app even runs). final can be set at runtime. We use const for things like EdgeInsets.all(16.0) or fixed Text widgets because their values never change. const lets Flutter reuse the same object in memory instead of creating new ones.

**Q: What does the required keyword do in constructors?**
A: It means you MUST provide that parameter when creating an object. If you try to create a Question() without providing questionText, Dart will give you an error. It prevents bugs from forgetting to pass important values.

**Q: What is a Scaffold?**
A: Scaffold is the basic structure of a screen. It gives you slots for an AppBar (top bar), body (main content area), drawer (side menu), bottomNavigationBar, and floatingActionButton. Almost every screen in a Flutter app uses a Scaffold.

**Q: How does the Drawer work?**
A: When you set drawer: on a Scaffold, Flutter automatically adds a hamburger menu icon to the AppBar. Tapping it slides the Drawer in from the left. The Drawer is just a panel with a ListView of menu items. Navigator.pop(context) closes it.

**Q: What does the spread operator (...) do?**
A: It takes items from a list and "spreads" them into another list. For example, ...keyPoints.map((p) => Text(p)) converts each string in keyPoints into a Text widget and adds them all as individual children of the parent Column. Without spread, you'd have a List inside a List, which doesn't work.

**Q: How are colors represented in the code?**
A: Colors use hex format: Color(0xFF1E293B). The 0x means hexadecimal. FF is the opacity (FF = fully opaque, 00 = fully transparent). 1E293B is the actual color in RGB hex. You can look up any hex color online to see what it looks like.

**Q: What is ThemeData and why do you set it in main.dart?**
A: ThemeData defines the visual style (colors, fonts, shapes) for the entire app. Setting it in MaterialApp means every screen automatically gets these styles. For example, appBarTheme sets the look of every AppBar, so we don't have to style each one individually.

**Q: What widgets from the rubric are demonstrated?**
A: The app demonstrates: GridView (subject grid), ListView (chapter list), Drawer (side menu), AlertDialog (info popup and quiz results), Radio buttons (quiz options), CheckboxListTile (mark as completed), SnackBar (notifications), Card (content sections), AppBar, and many more standard Flutter widgets.

**Q: What is MaterialPageRoute?**
A: It's the object that defines how to transition to a new screen. The builder parameter is a function that returns the widget for the new screen. MaterialPageRoute gives you the standard slide-in animation on Android and slide-from-right on iOS.

**Q: Where is the data stored? Is there a database?**
A: No database. All data is hardcoded in learning_data.dart as a Dart list called sampleSubjects. When the app starts, this data is loaded into memory. It's a simple approach since our data doesn't change — it's like having a textbook built into the app.
