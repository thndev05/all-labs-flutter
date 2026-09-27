import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_8_ball/main.dart';

void main() {
  testWidgets('changes the Magic 8 Ball answer', (tester) async {
    await tester.pumpWidget(MaterialApp(home: BallPage(random: Random(42))));

    expect(find.byKey(const Key('magic-ball')), findsOneWidget);
    expect(find.byKey(const Key('ask-button')), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    final firstImage = tester.widget<Image>(find.byType(Image));
    await tester.tap(find.byKey(const Key('ask-button')));
    await tester.pump();
    final secondImage = tester.widget<Image>(find.byType(Image));

    expect(secondImage.image, isNot(equals(firstImage.image)));
  });
}
