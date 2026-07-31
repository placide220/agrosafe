import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/i18n_strings.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';
import '../main_navigation/main_navigation_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthLoginSubmitted(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  void _guestLogin() {
    context.read<AuthBloc>().add(AuthGuestLoginSubmitted());
  }

  Future<void> _showForgotPasswordDialog() async {
    final resetController = TextEditingController(
      text: _emailController.text.trim(),
    );
    final dialogFormKey = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Reset password'),
          content: Form(
            key: dialogFormKey,
            child: TextFormField(
              controller: resetController,
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Email address',
                prefixIcon: Icon(Icons.email_outlined),
                helperText: 'We will email you a secure reset link.',
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please enter your email';
                }
                if (!val.contains('@')) return 'Enter a valid email format';
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (dialogFormKey.currentState!.validate()) {
                  context.read<AuthBloc>().add(
                    AuthPasswordResetRequested(
                      email: resetController.text.trim(),
                    ),
                  );
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text('Send link'),
            ),
          ],
        );
      },
    );
    resetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.watch<SettingsCubit>().state.settings.languageCode;

    return Scaffold(
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
          } else if (state is AuthPasswordResetSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Password reset link sent to ${state.email}. Check your inbox.',
                ),
                backgroundColor: const Color(0xFF1E5620),
              ),
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
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      size: 64,
                      color: Color(0xFF1E5620),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      I18nStrings.get('welcome_title', langCode),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E5620),
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      I18nStrings.get('welcome_subtitle', langCode),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 36),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: I18nStrings.get('email', langCode),
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Please enter an email address';
                              }
                              if (!val.contains('@')) {
                                return 'Enter a valid email format';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: I18nStrings.get('password', langCode),
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (val.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: state is AuthLoading
                                  ? null
                                  : _showForgotPasswordDialog,
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(color: Color(0xFF1E5620)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (state is AuthLoading)
                            const CircularProgressIndicator()
                          else ...[
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _submitLogin,
                                child: Text(
                                  I18nStrings.get('login_btn', langCode),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            OutlinedButton(
                              onPressed: _guestLogin,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                side: const BorderSide(
                                  color: Color(0xFF1E5620),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                I18nStrings.get('guest_btn', langCode),
                                style: const TextStyle(
                                  color: Color(0xFF1E5620),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            I18nStrings.get('register', langCode),
                            style: const TextStyle(
                              color: Color(0xFF1E5620),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
