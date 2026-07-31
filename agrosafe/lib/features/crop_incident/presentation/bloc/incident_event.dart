import 'package:equatable/equatable.dart';
import '../../domain/entities/incident_entity.dart';

abstract class IncidentEvent extends Equatable {
  const IncidentEvent();

  @override
  List<Object?> get props => [];
}

class LoadIncidentsEvent extends IncidentEvent {
  final String userId;

  const LoadIncidentsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class CreateIncidentEvent extends IncidentEvent {
  final IncidentEntity incident;

  const CreateIncidentEvent(this.incident);

  @override
  List<Object?> get props => [incident];
}

class UpdateIncidentEvent extends IncidentEvent {
  final IncidentEntity incident;

  const UpdateIncidentEvent(this.incident);

  @override
  List<Object?> get props => [incident];
}

class DeleteIncidentEvent extends IncidentEvent {
  final String incidentId;
  final String userId;

  const DeleteIncidentEvent({required this.incidentId, required this.userId});

  @override
  List<Object?> get props => [incidentId, userId];
}
