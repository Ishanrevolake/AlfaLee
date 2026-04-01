import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alfa_fitness/main.dart';

void main() {
  testWidgets('Dashboard smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AlfaFitnessApp());

    // Verify that the dashboard header is present.
    expect(find.text('Trainer Command'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);

    // Verify that bottom navigation items are present.
    expect(find.byIcon(Icons.book), findsOneWidget);
    expect(find.byIcon(Icons.bar_chart), findsOneWidget);
    expect(find.byIcon(Icons.fitness_center), findsOneWidget);
    expect(find.byIcon(Icons.restaurant), findsOneWidget);
  });
}
