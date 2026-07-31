import 'package:agrosafe/features/crop_incident/domain/entities/incident_entity.dart';
import 'package:agrosafe/features/crop_incident/presentation/widgets/incident_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tIncident = IncidentEntity(
    id: 'inc_101',
    userId: 'user_001',
    cropName: 'Beans',
    issueType: 'Fungal Blight',
    severity: 'High',
    location: 'Musanze District',
    description: 'Yellowing of lower leaves',
    status: 'Reported',
    reportedAt: DateTime(2026, 1, 1),
  );

  testWidgets('IncidentCard renders crop name, issue type, and severity tag', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: IncidentCard(
            incident: tIncident,
            onTap: () {},
            onDelete: () {},
          ),
        ),
      ),
    );

    expect(find.text('Beans'), findsOneWidget);
    expect(find.text('Fungal Blight'), findsOneWidget);
    expect(find.text('HIGH'), findsOneWidget);
    expect(find.text('Musanze District'), findsOneWidget);
  });
}
