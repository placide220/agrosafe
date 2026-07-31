import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/i18n_strings.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import '../../features/crop_incident/domain/entities/incident_entity.dart';
import '../../features/crop_incident/presentation/bloc/incident_bloc.dart';
import '../../features/crop_incident/presentation/bloc/incident_event.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';

class AddEditIncidentPage extends StatefulWidget {
  final UserEntity user;
  final IncidentEntity? incident;

  const AddEditIncidentPage({
    super.key,
    this.user = const UserEntity(
      uid: '1',
      email: 'farmer@agrosafe.rw',
      fullName: 'Claudine Uwase',
      farmLocation: 'Musanze',
    ),
    this.incident,
  });

  @override
  State<AddEditIncidentPage> createState() => _AddEditIncidentPageState();
}

class _AddEditIncidentPageState extends State<AddEditIncidentPage> {
  final _formKey = GlobalKey<FormState>();
  late String _cropName;
  late String _issueType;
  late String _severity;
  late String _location;
  late String _description;

  final List<String> _severities = ['Low', 'Medium', 'High', 'Critical'];

  @override
  void initState() {
    super.initState();
    _cropName = widget.incident?.cropName ?? '';
    _issueType = widget.incident?.issueType ?? '';
    _severity = widget.incident?.severity ?? 'Medium';
    _location = widget.incident?.location ?? widget.user.farmLocation;
    _description = widget.incident?.description ?? '';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final incident = IncidentEntity(
        id:
            widget.incident?.id ??
            'inc_${DateTime.now().millisecondsSinceEpoch}',
        userId: widget.user.uid,
        cropName: _cropName,
        issueType: _issueType,
        severity: _severity,
        location: _location,
        description: _description,
        status: widget.incident?.status ?? 'Reported',
        reportedAt: widget.incident?.reportedAt ?? DateTime.now(),
      );

      if (widget.incident == null) {
        context.read<IncidentBloc>().add(CreateIncidentEvent(incident));
      } else {
        context.read<IncidentBloc>().add(UpdateIncidentEvent(incident));
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.watch<SettingsCubit>().state.settings.languageCode;
    final isEditing = widget.incident != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? 'Edit Incident'
              : I18nStrings.get('add_incident', langCode),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  initialValue: _cropName,
                  decoration: InputDecoration(
                    labelText: I18nStrings.get('crop_name', langCode),
                    prefixIcon: const Icon(Icons.eco_outlined),
                  ),
                  validator: (val) =>
                      val == null || val.trim().isEmpty ? 'Required' : null,
                  onSaved: (val) => _cropName = val!.trim(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _issueType,
                  decoration: const InputDecoration(
                    labelText: 'Pest Attack / Disease Type',
                    prefixIcon: Icon(Icons.bug_report_outlined),
                    hintText: 'e.g. Fall Armyworm, Late Blight',
                  ),
                  validator: (val) =>
                      val == null || val.trim().isEmpty ? 'Required' : null,
                  onSaved: (val) => _issueType = val!.trim(),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  initialValue: _severity,
                  decoration: InputDecoration(
                    labelText: I18nStrings.get('severity', langCode),
                    prefixIcon: const Icon(Icons.warning_amber_rounded),
                  ),
                  items: _severities
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _severity = val);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _location,
                  decoration: InputDecoration(
                    labelText: I18nStrings.get('farm_location', langCode),
                    prefixIcon: const Icon(Icons.location_on_outlined),
                  ),
                  validator: (val) =>
                      val == null || val.trim().isEmpty ? 'Required' : null,
                  onSaved: (val) => _location = val!.trim(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _description,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: I18nStrings.get('description', langCode),
                    alignLabelWithHint: true,
                  ),
                  validator: (val) =>
                      val == null || val.trim().isEmpty ? 'Required' : null,
                  onSaved: (val) => _description = val!.trim(),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(I18nStrings.get('save', langCode)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
