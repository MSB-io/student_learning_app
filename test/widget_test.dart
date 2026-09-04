import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:student_learning_app/main.dart';

void main() {
  testWidgets('Student Learning App complete navigation and widget test', (
    WidgetTester tester,
  ) async {
    // 1. Launch App on Home Screen
    await tester.pumpWidget(const StudentLearningApp());

    // Verify Home Screen widgets
    expect(find.text('Student Learning App'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('Computer Networks'), findsOneWidget);
    expect(find.text('Operating Systems'), findsOneWidget);

    // 2. Open Subject: Tap 'Computer Networks'
    final subjectFinder = find.text('Computer Networks');
    await tester.ensureVisible(subjectFinder);
    await tester.pumpAndSettle();
    await tester.tap(subjectFinder);
    await tester.pumpAndSettle();

    // Verify Chapter List Screen loaded
    expect(find.text('Course Curriculum'), findsOneWidget);
    expect(find.text('Network Models & OSI Reference'), findsOneWidget);
    expect(find.text('IP Addressing & Subnetting'), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);

    // 3. Open Chapter 1: Tap 'Network Models & OSI Reference'
    await tester.tap(find.text('Network Models & OSI Reference'));
    await tester.pumpAndSettle();

    // Verify Study Material Screen loaded
    expect(find.text('Chapter Overview'), findsOneWidget);
    expect(find.text('Key Concepts & Definitions'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.textContaining('Take Chapter Quiz'), findsOneWidget);

    // 4. Start Quiz
    final quizButtonFinder = find.textContaining('Take Chapter Quiz');
    await tester.ensureVisible(quizButtonFinder);
    await tester.pumpAndSettle();
    await tester.tap(quizButtonFinder);
    await tester.pumpAndSettle();

    // Verify Quiz Screen loaded
    expect(find.text('Question 1 of 3'), findsOneWidget);
    expect(find.byType(RadioListTile<int>), findsNWidgets(4));
    expect(find.text('Next'), findsOneWidget);

    // Select an option (e.g. Network Layer, index 1)
    await tester.tap(find.text('Network Layer'));
    await tester.pumpAndSettle();

    // Tap Next
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Question 2 of 3'), findsOneWidget);
  });
}
