import 'package:agrosafe/core/error/failures.dart';
import 'package:agrosafe/features/crop_incident/domain/entities/incident_entity.dart';
import 'package:agrosafe/features/crop_incident/domain/usecases/create_incident_usecase.dart';
import 'package:agrosafe/features/crop_incident/domain/usecases/delete_incident_usecase.dart';
import 'package:agrosafe/features/crop_incident/domain/usecases/get_incidents_usecase.dart';
import 'package:agrosafe/features/crop_incident/domain/usecases/update_incident_usecase.dart';
import 'package:agrosafe/features/crop_incident/presentation/bloc/incident_bloc.dart';
import 'package:agrosafe/features/crop_incident/presentation/bloc/incident_event.dart';
import 'package:agrosafe/features/crop_incident/presentation/bloc/incident_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetIncidentsUseCase extends Mock implements GetIncidentsUseCase {}

class MockCreateIncidentUseCase extends Mock implements CreateIncidentUseCase {}

class MockUpdateIncidentUseCase extends Mock implements UpdateIncidentUseCase {}

class MockDeleteIncidentUseCase extends Mock implements DeleteIncidentUseCase {}

void main() {
  late IncidentBloc bloc;
  late MockGetIncidentsUseCase mockGetIncidentsUseCase;
  late MockCreateIncidentUseCase mockCreateIncidentUseCase;
  late MockUpdateIncidentUseCase mockUpdateIncidentUseCase;
  late MockDeleteIncidentUseCase mockDeleteIncidentUseCase;

  setUp(() {
    mockGetIncidentsUseCase = MockGetIncidentsUseCase();
    mockCreateIncidentUseCase = MockCreateIncidentUseCase();
    mockUpdateIncidentUseCase = MockUpdateIncidentUseCase();
    mockDeleteIncidentUseCase = MockDeleteIncidentUseCase();

    bloc = IncidentBloc(
      getIncidentsUseCase: mockGetIncidentsUseCase,
      createIncidentUseCase: mockCreateIncidentUseCase,
      updateIncidentUseCase: mockUpdateIncidentUseCase,
      deleteIncidentUseCase: mockDeleteIncidentUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  final tIncident = IncidentEntity(
    id: 'inc_101',
    userId: 'user_001',
    cropName: 'Beans',
    issueType: 'Fungal Blight',
    severity: 'High',
    location: 'Musanze District',
    description: 'Yellowing leaves',
    status: 'Reported',
    reportedAt: DateTime(2026, 1, 1),
  );

  final tIncidentList = [tIncident];

  test('initial state is IncidentInitial', () {
    expect(bloc.state, isA<IncidentInitial>());
  });

  test(
    'emits [IncidentLoading, IncidentLoaded] when LoadIncidentsEvent succeeds',
    () async {
      when(
        () => mockGetIncidentsUseCase('user_001'),
      ).thenAnswer((_) async => Right(tIncidentList));

      final expected = [isA<IncidentLoading>(), isA<IncidentLoaded>()];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const LoadIncidentsEvent('user_001'));
    },
  );

  test(
    'emits [IncidentLoading, IncidentError] when LoadIncidentsEvent fails',
    () async {
      when(
        () => mockGetIncidentsUseCase('user_001'),
      ).thenAnswer((_) async => const Left(ServerFailure('Database error')));

      final expected = [isA<IncidentLoading>(), isA<IncidentError>()];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const LoadIncidentsEvent('user_001'));
    },
  );
}
