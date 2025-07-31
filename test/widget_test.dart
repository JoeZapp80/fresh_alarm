import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fresh_alarm/main.dart';

void main() {
  testWidgets('App shows title and can add an alarm', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const FreshAlarmApp());

    // Check the app bar title
    expect(find.text('Fresh Alarm'), findsOneWidget);

    // Tap the add alarm button (FloatingActionButton)
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter time and label in dialog text fields
    await tester.enterText(find.byType(TextField).at(0), '07:30 AM');
    await tester.enterText(find.byType(TextField).at(1), 'Morning Alarm');

    // Tap the Save button
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify new alarm appears in the list
    expect(find.text('07:30 AM'), findsOneWidget);
    expect(find.text('Morning Alarm'), findsOneWidget);
  });
}
