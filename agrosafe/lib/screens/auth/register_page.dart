import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/i18n_strings.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';
import '../main_navigation/main_navigation_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submitRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthRegisterSubmitted(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          fullName: _nameController.text.trim(),
          farmLocation: _locationController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.watch<SettingsCubit>().state.settings.languageCode;

    return Scaffold(
      appBar: AppBar(title: Text(I18nStrings.get('register', langCode))),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Direct navigation into the main application hub
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => MainNavigationPage(user: state.user),
              ),
              (route) => false,
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red.shade700,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Join AgroSafe Network',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E5620),
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Register to manage crop health, receive instant advisories, and protect yields.',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: I18nStrings.get('full_name', langCode),
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Full name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: I18nStrings.get('email', langCode),
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Email is required';
                        }
                        if (!val.contains('@')) return 'Invalid email format';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: I18nStrings.get('password', langCode),
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                      validator: (val) {
                        if (val == null || val.length < 6) {
                          return 'Minimum 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: I18nStrings.get('farm_location', langCode),
                        prefixIcon: const Icon(Icons.location_city_outlined),
                        hintText: 'e.g. Musanze District, Northern Province',
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Location is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    if (state is AuthLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      ElevatedButton(
                        onPressed: _submitRegister,
                        child: Text(I18nStrings.get('register_btn', langCode)),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
