import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/incident_entity.dart';

class IncidentModel extends IncidentEntity {
  const IncidentModel({
    required super.id,
    required super.userId,
    required super.cropName,
    required super.issueType,
    required super.severity,
    required super.location,
    required super.description,
    required super.status,
    required super.reportedAt,
  });

  factory IncidentModel.fromMap(Map<String, dynamic> map, String id) {
    DateTime parseDate(dynamic val) {
      if (val is Timestamp) return val.toDate();
      if (val is String) return DateTime.tryParse(val) ?? DateTime.now();
      return DateTime.now();
    }

    return IncidentModel(
      id: id,
      userId: map['userId'] as String? ?? '',
      cropName: map['cropName'] as String? ?? '',
      issueType: map['issueType'] as String? ?? '',
      severity: map['severity'] as String? ?? 'Medium',
      location: map['location'] as String? ?? '',
      description: map['description'] as String? ?? '',
      status: map['status'] as String? ?? 'Reported',
      reportedAt: parseDate(map['reportedAt']),
    );
  }

  factory IncidentModel.fromEntity(IncidentEntity entity) {
    return IncidentModel(
      id: entity.id,
      userId: entity.userId,
      cropName: entity.cropName,
      issueType: entity.issueType,
      severity: entity.severity,
      location: entity.location,
      description: entity.description,
      status: entity.status,
      reportedAt: entity.reportedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'cropName': cropName,
      'issueType': issueType,
      'severity': severity,
      'location': location,
      'description': description,
      'status': status,
      // Stored as a native Firestore Timestamp (matches the ERD) so it can be
      // range-queried and sorted server-side by the composite indexes.
      'reportedAt': Timestamp.fromDate(reportedAt),
    };
  }
}
