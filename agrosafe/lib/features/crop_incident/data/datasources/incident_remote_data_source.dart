import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/app_constants.dart';
import '../models/incident_model.dart';

abstract class IncidentRemoteDataSource {
  Stream<List<IncidentModel>> getIncidentsStream(String userId);
  Future<List<IncidentModel>> getIncidents(String userId);
  Future<IncidentModel> createIncident(IncidentModel incident);
  Future<IncidentModel> updateIncident(IncidentModel incident);
  Future<void> deleteIncident(String incidentId, String userId);
}

class IncidentRemoteDataSourceImpl implements IncidentRemoteDataSource {
  final FirebaseFirestore? firestore;

  static final List<IncidentModel> _mockIncidents = [
    IncidentModel(
      id: 'inc_101',
      userId: 'user_001',
      cropName: 'Beans',
      issueType: 'Fungal Blight',
      severity: 'High',
      location: 'Musanze District, Sector 4',
      description:
          'Yellowing of lower leaves spreading to stalks following heavy morning dew.',
      status: 'Reported',
      reportedAt: DateTime.now().subtract(const Duration(hours: 14)),
    ),
    IncidentModel(
      id: 'inc_102',
      userId: 'user_001',
      cropName: 'Maize',
      issueType: 'Pest Attack',
      severity: 'Critical',
      location: 'Nyabihu District, Sector 2',
      description:
          'Fall armyworm caterpillars feeding inside central whorls across 0.5 hectares.',
      status: 'Action Taken',
      reportedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    IncidentModel(
      id: 'inc_103',
      userId: 'user_001',
      cropName: 'Irish Potatoes',
      issueType: 'Nutrient Deficiency',
      severity: 'Low',
      location: 'Burera District, Sector 1',
      description: 'Stunted stem growth and mild chlorosis on outer foliage.',
      status: 'Resolved',
      reportedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  IncidentRemoteDataSourceImpl({this.firestore});

  bool get _isFirebaseAvailable {
    try {
      return firestore != null;
    } catch (_) {
      return false;
    }
  }

  @override
  Stream<List<IncidentModel>> getIncidentsStream(String userId) {
    if (_isFirebaseAvailable) {
      return firestore!
          .collection(AppConstants.incidentsCollection)
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => IncidentModel.fromMap(doc.data(), doc.id))
                .toList(),
          );
    }
    return Stream.value(_mockIncidents);
  }

  @override
  Future<List<IncidentModel>> getIncidents(String userId) async {
    if (_isFirebaseAvailable) {
      try {
        final snapshot = await firestore!
            .collection(AppConstants.incidentsCollection)
            .where('userId', isEqualTo: userId)
            .get();
        return snapshot.docs
            .map((doc) => IncidentModel.fromMap(doc.data(), doc.id))
            .toList();
      } catch (e) {
        throw ServerException(e.toString());
      }
    }
    return List.from(_mockIncidents);
  }

  @override
  Future<IncidentModel> createIncident(IncidentModel incident) async {
    if (_isFirebaseAvailable) {
      try {
        final docRef = await firestore!
            .collection(AppConstants.incidentsCollection)
            .add(incident.toMap());
        return IncidentModel(
          id: docRef.id,
          userId: incident.userId,
          cropName: incident.cropName,
          issueType: incident.issueType,
          severity: incident.severity,
          location: incident.location,
          description: incident.description,
          status: incident.status,
          reportedAt: incident.reportedAt,
        );
      } catch (e) {
        throw ServerException(e.toString());
      }
    }
    final created = IncidentModel(
      id: 'inc_${DateTime.now().millisecondsSinceEpoch}',
      userId: incident.userId,
      cropName: incident.cropName,
      issueType: incident.issueType,
      severity: incident.severity,
      location: incident.location,
      description: incident.description,
      status: incident.status,
      reportedAt: incident.reportedAt,
    );
    _mockIncidents.insert(0, created);
    return created;
  }

  @override
  Future<IncidentModel> updateIncident(IncidentModel incident) async {
    if (_isFirebaseAvailable) {
      try {
        await firestore!
            .collection(AppConstants.incidentsCollection)
            .doc(incident.id)
            .update(incident.toMap());
        return incident;
      } catch (e) {
        throw ServerException(e.toString());
      }
    }
    final index = _mockIncidents.indexWhere((item) => item.id == incident.id);
    if (index != -1) {
      _mockIncidents[index] = incident;
    }
    return incident;
  }

  @override
  Future<void> deleteIncident(String incidentId, String userId) async {
    if (_isFirebaseAvailable) {
      try {
        await firestore!
            .collection(AppConstants.incidentsCollection)
            .doc(incidentId)
            .delete();
        return;
      } catch (e) {
        throw ServerException(e.toString());
      }
    }
    _mockIncidents.removeWhere((item) => item.id == incidentId);
  }
}
