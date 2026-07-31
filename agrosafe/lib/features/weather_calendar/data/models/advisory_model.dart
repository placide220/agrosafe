import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/advisory_entity.dart';

class AdvisoryModel extends AdvisoryEntity {
  const AdvisoryModel({
    required super.id,
    required super.title,
    required super.category,
    required super.recommendation,
    required super.riskLevel,
    required super.validUntil,
  });

  factory AdvisoryModel.fromMap(Map<String, dynamic> map, String id) {
    DateTime parseDate(dynamic val) {
      if (val is Timestamp) return val.toDate();
      if (val is String) return DateTime.tryParse(val) ?? DateTime.now();
      return DateTime.now();
    }

    return AdvisoryModel(
      id: id,
      title: map['title'] as String? ?? 'Safety Advisory',
      category: map['category'] as String? ?? 'Pesticide Safety',
      recommendation: map['recommendation'] as String? ?? '',
      riskLevel: map['riskLevel'] as String? ?? 'Moderate',
      validUntil: parseDate(map['validUntil']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'recommendation': recommendation,
      'riskLevel': riskLevel,
      'validUntil': validUntil.toIso8601String(),
    };
  }
}
