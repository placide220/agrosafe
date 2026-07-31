import 'package:equatable/equatable.dart';

class ScamAlertEntity extends Equatable {
  final String id;
  final String productName;
  final String fakeManufacturer;
  final String district;
  final String riskDescription;
  final String
  verificationStatus; // 'Verified Fake', 'Under Investigation', 'Safe Certified'
  final DateTime reportedAt;

  const ScamAlertEntity({
    required this.id,
    required this.productName,
    required this.fakeManufacturer,
    required this.district,
    required this.riskDescription,
    required this.verificationStatus,
    required this.reportedAt,
  });

  @override
  List<Object?> get props => [
    id,
    productName,
    fakeManufacturer,
    district,
    riskDescription,
    verificationStatus,
    reportedAt,
  ];
}
