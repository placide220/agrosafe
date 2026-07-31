import 'package:equatable/equatable.dart';
import '../../domain/entities/incident_entity.dart';

abstract class IncidentState extends Equatable {
  const IncidentState();

  @override
  List<Object?> get props => [];
}

class IncidentInitial extends IncidentState {}

class IncidentLoading extends IncidentState {}

class IncidentLoaded extends IncidentState {
  final List<IncidentEntity> incidents;

  const IncidentLoaded(this.incidents);

  @override
  List<Object?> get props => [incidents];
}

class IncidentActionSuccess extends IncidentState {
  final String message;
  final List<IncidentEntity> incidents;

  const IncidentActionSuccess({required this.message, required this.incidents});

  @override
  List<Object?> get props => [message, incidents];
}

class IncidentError extends IncidentState {
  final String message;

  const IncidentError(this.message);

  @override
  List<Object?> get props => [message];
}
