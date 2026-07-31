import 'package:agrosafe/features/crop_incident/data/models/incident_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

/// Unit tests for IncidentModel serialization — in particular that `reportedAt`
/// is written as a Firestore Timestamp and read back losslessly (Area 3), while
/// still tolerating legacy ISO-8601 string values.
void main() {
  final reportedAt = DateTime(2026, 1, 15, 9, 30);

  IncidentModel buildModel() => IncidentModel(
    id: 'inc_test',
    userId: 'user_001',
    cropName: 'Beans',
    issueType: 'Fungal Blight',
    severity: 'High',
    location: 'Musanze District',
    description: 'Yellowing leaves',
    status: 'Reported',
    reportedAt: reportedAt,
  );

  test('toMap stores reportedAt as a Firestore Timestamp', () {
    final map = buildModel().toMap();
    expect(map['reportedAt'], isA<Timestamp>());
    expect((map['reportedAt'] as Timestamp).toDate(), reportedAt);
    expect(map['userId'], 'user_001');
  });

  test('fromMap reads a Timestamp back into a DateTime', () {
    final map = buildModel().toMap();
    final restored = IncidentModel.fromMap(map, 'inc_test');
    expect(restored.reportedAt, reportedAt);
    expect(restored.cropName, 'Beans');
    expect(restored.severity, 'High');
  });

  test('fromMap still tolerates a legacy ISO-8601 string reportedAt', () {
    final legacy = {
      'userId': 'user_001',
      'cropName': 'Maize',
      'issueType': 'Pest Attack',
      'severity': 'Critical',
      'location': 'Nyabihu',
      'description': 'Armyworm',
      'status': 'Reported',
      'reportedAt': reportedAt.toIso8601String(),
    };
    final restored = IncidentModel.fromMap(legacy, 'inc_legacy');
    expect(restored.reportedAt, reportedAt);
  });
}
