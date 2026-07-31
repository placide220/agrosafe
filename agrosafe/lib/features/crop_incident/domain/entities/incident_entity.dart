import 'package:equatable/equatable.dart';

class IncidentEntity extends Equatable {
  final String id;
  final String userId;
  final String cropName;
  final String
  issueType; // e.g. 'Pest Attack', 'Fungal Blight', 'Nutrient Deficiency'
  final String severity; // 'Low', 'Medium', 'High', 'Critical'
  final String location;
  final String description;
  final String status; // 'Reported', 'Under Review', 'Action Taken', 'Resolved'
  final DateTime reportedAt;

  const IncidentEntity({
    required this.id,
    required this.userId,
    required this.cropName,
    required this.issueType,
    required this.severity,
    required this.location,
    required this.description,
    required this.status,
    required this.reportedAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    cropName,
    issueType,
    severity,
    location,
    description,
    status,
    reportedAt,
  ];
}
