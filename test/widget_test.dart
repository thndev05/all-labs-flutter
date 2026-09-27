import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzler/main.dart';

void main() {
  testWidgets('moves to the next question and records the answer',
      (tester) async {
    const questions = [
      QuizQuestion('Question one?', true),
      QuizQuestion('Question two?', false),
    ];
    await tester
        .pumpWidget(const MaterialApp(home: QuizPage(questions: questions)));

    expect(find.text('Question one?'), findsOneWidget);
    await tester.tap(find.byKey(const Key('true-button')));
    await tester.pump();
    expect(find.text('Question two?'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
  });
}
