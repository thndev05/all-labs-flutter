import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dicee/main.dart';

void main() {
  testWidgets('displays and rolls two dice', (tester) async {
    await tester.pumpWidget(MaterialApp(home: DicePage(random: Random(42))));

    expect(find.byKey(const Key('left-dice')), findsOneWidget);
    expect(find.byKey(const Key('right-dice')), findsOneWidget);
    expect(find.byKey(const Key('roll-button')), findsOneWidget);
    expect(find.textContaining('Tổng điểm:'), findsOneWidget);

    await tester.tap(find.byKey(const Key('roll-button')));
    await tester.pump();
    expect(find.byType(Image), findsNWidgets(2));
  });
}
