# Student Learning App (Mini Project)

A clean, beginner-friendly Flutter application developed for the 20-mark mini-project requirement under the **Education** track with a core focus on **Computer Networks** (alongside Operating Systems, Data Structures, and DBMS).

Built strictly using vanilla Flutter with local Dart dummy data — no external state management packages, no Firebase, and no REST APIs.

---

## Screen Architecture & Flow

```
[Screen 1: Home Screen]
  ├── Welcome Banner & Profile Drawer
  └── GridView of Enrolled Subjects (Computer Networks, OS, DSA, DBMS)
        │
        ▼ (Tap Subject)
[Screen 2: Chapter List Screen]
  ├── Subject Header Details
  └── ListView.builder of Chapters (Ch 1: OSI, Ch 2: IP, Ch 3: Routing, Ch 4: Security)
        │
        ▼ (Tap Chapter)
[Screen 3: Study Material Screen]
  ├── Chapter Overview & Key Definitions
  ├── Checkbox: "Mark module as completed" (tracks progress via setState)
  └── ElevatedButton: "Take Chapter Quiz"
        │
        ▼ (Tap Take Quiz)
[Screen 4: Interactive Quiz Screen]
  ├── Linear progress indicator & question counter
  ├── RadioListTile options for MCQs
  ├── Previous / Next / Submit navigation
  └── AlertDialog scorecard with performance feedback & answer explanations
```

---

## Rubric Widget Checklist

| Required Widget | File & Line | Function in App |
| :--- | :--- | :--- |
| `Scaffold` | All screens | Base screen layout structure |
| `AppBar` | All screens | Header with title and back navigation |
| `Container` | All screens | Custom styling, padding, and borders |
| `Column` | All screens | Vertical widget layouts |
| `Row` | All screens | Horizontal stats, icons, and buttons |
| `Card` | All screens | Content containers for subjects, chapters, notes, and quiz options |
| `GridView` | `home_screen.dart` | 2-column grid of enrolled subjects |
| `ListView` / `ListView.builder` | `chapter_list_screen.dart`, `quiz_screen.dart` | Dynamic scrollable lists for chapters and quiz choices |
| `Text` | All screens | Headings, body notes, question text |
| `Icon` | All screens | Visual glyphs for subjects, timers, questions, and status |
| `ElevatedButton` | `study_material_screen.dart`, `quiz_screen.dart` | "Take Chapter Quiz", "Submit Quiz", "Finish" |
| `TextButton` | `home_screen.dart`, `quiz_screen.dart` | Dialog actions ("OK", "Review Answers") |
| `IconButton` | `home_screen.dart` | Top info button |
| `Radio` / `RadioGroup` | `quiz_screen.dart` | Single-choice selection for MCQ answers |
| `Checkbox` | `study_material_screen.dart` | "Mark module as completed" state toggle |
| `AlertDialog` | `quiz_screen.dart`, `home_screen.dart` | Quiz scorecard dialog and About modal |
| `Drawer` | `home_screen.dart` | Side navigation drawer with student profile details |
| `SnackBar` | `study_material_screen.dart`, `home_screen.dart` | Action confirmation feedback |

---

## How to Run & Test

```bash
cd /Users/manthan/Desktop/Flutter/student_learning_app

# Run on macOS desktop
flutter run -d macos

# Run on Chrome
flutter run -d chrome

# Run static analysis (0 warnings)
flutter analyze

# Run automated tests (all passed)
flutter test
```
