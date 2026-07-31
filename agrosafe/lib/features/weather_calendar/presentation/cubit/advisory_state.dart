import 'package:equatable/equatable.dart';
import '../../domain/entities/advisory_entity.dart';

abstract class AdvisoryState extends Equatable {
  const AdvisoryState();

  @override
  List<Object?> get props => [];
}

class AdvisoryInitial extends AdvisoryState {}

class AdvisoryLoading extends AdvisoryState {}

class AdvisoryLoaded extends AdvisoryState {
  final List<AdvisoryEntity> advisories;
  final String selectedCategory;

  const AdvisoryLoaded(this.advisories, {this.selectedCategory = 'All'});

  List<AdvisoryEntity> get filteredAdvisories {
    if (selectedCategory == 'All') return advisories;
    return advisories.where((a) => a.category == selectedCategory).toList();
  }

  @override
  List<Object?> get props => [advisories, selectedCategory];
}

class AdvisoryError extends AdvisoryState {
  final String message;

  const AdvisoryError(this.message);

  @override
  List<Object?> get props => [message];
}
