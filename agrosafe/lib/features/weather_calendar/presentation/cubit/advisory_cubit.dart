import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_advisories_usecase.dart';
import 'advisory_state.dart';

class AdvisoryCubit extends Cubit<AdvisoryState> {
  final GetAdvisoriesUseCase getAdvisoriesUseCase;

  AdvisoryCubit({required this.getAdvisoriesUseCase})
    : super(AdvisoryInitial());

  Future<void> loadAdvisories() async {
    emit(AdvisoryLoading());
    final result = await getAdvisoriesUseCase(NoParams());
    result.fold(
      (failure) => emit(AdvisoryError(failure.message)),
      (advisories) => emit(AdvisoryLoaded(advisories)),
    );
  }

  void filterByCategory(String category) {
    if (state is AdvisoryLoaded) {
      final current = state as AdvisoryLoaded;
      emit(AdvisoryLoaded(current.advisories, selectedCategory: category));
    }
  }
}
