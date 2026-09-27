import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xylophone/main.dart';

void main() {
  testWidgets('plays a note when a key is tapped', (tester) async {
    int? playedNote;
    await tester.pumpWidget(MaterialApp(
      home: XylophonePage(onPlayNote: (note) => playedNote = note),
    ));

    await tester.tap(find.byKey(const Key('note-4')));
    await tester.pump();
    expect(find.byKey(const Key('note-4')), findsOneWidget);
    expect(playedNote, 4);
  });
}
