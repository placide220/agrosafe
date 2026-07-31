import 'package:equatable/equatable.dart';

class AdvisoryEntity extends Equatable {
  final String id;
  final String title;
  final String
  category; // 'Weather Warning', 'Pesticide Safety', 'Crop Disease'
  final String recommendation;
  final String riskLevel; // 'Low', 'Moderate', 'High', 'Severe'
  final DateTime validUntil;

  const AdvisoryEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.recommendation,
    required this.riskLevel,
    required this.validUntil,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    category,
    recommendation,
    riskLevel,
    validUntil,
  ];
}
