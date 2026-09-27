import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:destini/main.dart';

void main() {
  testWidgets('updates the story after selecting a choice', (tester) async {
    await tester.pumpWidget(const DestiniApp());

    final firstStory =
        tester.widget<Text>(find.byKey(const Key('story-text'))).data;
    await tester.tap(find.byKey(const Key('choice-2')));
    await tester.pump();
    final nextStory =
        tester.widget<Text>(find.byKey(const Key('story-text'))).data;

    expect(nextStory, isNot(firstStory));
    expect(find.byKey(const Key('choice-2')), findsOneWidget);
  });
}
