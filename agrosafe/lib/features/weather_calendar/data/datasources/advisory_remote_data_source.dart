import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/app_constants.dart';
import '../models/advisory_model.dart';

abstract class AdvisoryRemoteDataSource {
  Future<List<AdvisoryModel>> getAdvisories();
}

class AdvisoryRemoteDataSourceImpl implements AdvisoryRemoteDataSource {
  final FirebaseFirestore? firestore;

  static final List<AdvisoryModel> _mockAdvisories = [
    AdvisoryModel(
      id: 'adv_201',
      title: 'Heavy Rainfall & Fungicide Warning',
      category: 'Weather Warning',
      recommendation:
          'Delay copper fungicide spraying on Irish potato fields for 48 hours to prevent chemical wash-off and soil leaching.',
      riskLevel: 'Severe',
      validUntil: DateTime.now().add(const Duration(days: 2)),
    ),
    AdvisoryModel(
      id: 'adv_202',
      title: 'Optimal Pest Control Spray Window',
      category: 'Pesticide Safety',
      recommendation:
          'Calm winds expected between 06:00 AM - 09:00 AM tomorrow. Ideal for targeted bio-pesticide spray with PPE gear.',
      riskLevel: 'Moderate',
      validUntil: DateTime.now().add(const Duration(days: 1)),
    ),
    AdvisoryModel(
      id: 'adv_203',
      title: 'Fall Armyworm Early Warning',
      category: 'Crop Disease',
      recommendation:
          'Inspect maize fields twice weekly. Apply recommendedEmamectin benzoate at first sign of whorl damage.',
      riskLevel: 'High',
      validUntil: DateTime.now().add(const Duration(days: 5)),
    ),
  ];

  AdvisoryRemoteDataSourceImpl({this.firestore});

  bool get _isFirebaseAvailable {
    try {
      return firestore != null;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<AdvisoryModel>> getAdvisories() async {
    if (_isFirebaseAvailable) {
      try {
        final query = await firestore!
            .collection(AppConstants.advisoriesCollection)
            .get();
        if (query.docs.isNotEmpty) {
          return query.docs
              .map((doc) => AdvisoryModel.fromMap(doc.data(), doc.id))
              .toList();
        }
      } catch (e) {
        throw ServerException(e.toString());
      }
    }
    return List.from(_mockAdvisories);
  }
}
