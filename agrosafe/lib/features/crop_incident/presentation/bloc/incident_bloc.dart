import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_incident_usecase.dart';
import '../../domain/usecases/delete_incident_usecase.dart';
import '../../domain/usecases/get_incidents_usecase.dart';
import '../../domain/usecases/update_incident_usecase.dart';
import 'incident_event.dart';
import 'incident_state.dart';

class IncidentBloc extends Bloc<IncidentEvent, IncidentState> {
  final GetIncidentsUseCase getIncidentsUseCase;
  final CreateIncidentUseCase createIncidentUseCase;
  final UpdateIncidentUseCase updateIncidentUseCase;
  final DeleteIncidentUseCase deleteIncidentUseCase;

  IncidentBloc({
    required this.getIncidentsUseCase,
    required this.createIncidentUseCase,
    required this.updateIncidentUseCase,
    required this.deleteIncidentUseCase,
  }) : super(IncidentInitial()) {
    on<LoadIncidentsEvent>(_onLoadIncidents);
    on<CreateIncidentEvent>(_onCreateIncident);
    on<UpdateIncidentEvent>(_onUpdateIncident);
    on<DeleteIncidentEvent>(_onDeleteIncident);
  }

  Future<void> _onLoadIncidents(
    LoadIncidentsEvent event,
    Emitter<IncidentState> emit,
  ) async {
    emit(IncidentLoading());
    final result = await getIncidentsUseCase(event.userId);
    result.fold(
      (failure) => emit(IncidentError(failure.message)),
      (incidents) => emit(IncidentLoaded(incidents)),
    );
  }

  Future<void> _onCreateIncident(
    CreateIncidentEvent event,
    Emitter<IncidentState> emit,
  ) async {
    emit(IncidentLoading());
    final result = await createIncidentUseCase(event.incident);
    await result.fold((failure) async => emit(IncidentError(failure.message)), (
      _,
    ) async {
      final reloaded = await getIncidentsUseCase(event.incident.userId);
      reloaded.fold(
        (failure) => emit(IncidentError(failure.message)),
        (incidents) => emit(
          IncidentActionSuccess(
            message: 'Incident reported successfully!',
            incidents: incidents,
          ),
        ),
      );
    });
  }

  Future<void> _onUpdateIncident(
    UpdateIncidentEvent event,
    Emitter<IncidentState> emit,
  ) async {
    emit(IncidentLoading());
    final result = await updateIncidentUseCase(event.incident);
    await result.fold((failure) async => emit(IncidentError(failure.message)), (
      _,
    ) async {
      final reloaded = await getIncidentsUseCase(event.incident.userId);
      reloaded.fold(
        (failure) => emit(IncidentError(failure.message)),
        (incidents) => emit(
          IncidentActionSuccess(
            message: 'Incident updated successfully!',
            incidents: incidents,
          ),
        ),
      );
    });
  }

  Future<void> _onDeleteIncident(
    DeleteIncidentEvent event,
    Emitter<IncidentState> emit,
  ) async {
    emit(IncidentLoading());
    final result = await deleteIncidentUseCase(
      DeleteIncidentParams(incidentId: event.incidentId, userId: event.userId),
    );
    await result.fold((failure) async => emit(IncidentError(failure.message)), (
      _,
    ) async {
      final reloaded = await getIncidentsUseCase(event.userId);
      reloaded.fold(
        (failure) => emit(IncidentError(failure.message)),
        (incidents) => emit(
          IncidentActionSuccess(
            message: 'Incident record removed.',
            incidents: incidents,
          ),
        ),
      );
    });
  }
}
