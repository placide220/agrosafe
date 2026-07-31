import 'package:equatable/equatable.dart';
import '../../domain/entities/settings_entity.dart';

class SettingsState extends Equatable {
  final SettingsEntity settings;

  const SettingsState(this.settings);

  @override
  List<Object?> get props => [settings];
}
