import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/app_route/app_route.dart';
import 'package:flutter_template/core/utils/extension/context_extension.dart';
import 'package:flutter_template/core/widget/auth_input_field.dart';
import 'package:flutter_template/core/widget/custom_button.dart';
import 'package:flutter_template/core/widget/custom_toast.dart';
import 'package:flutter_template/feature/auth/domain/model/register_request.dart';
import 'package:flutter_template/feature/auth/ui/provider/auth_notifier.dart';
import 'package:flutter_template/gen/assets.gen.dart';

@RoutePage()
class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final registerRequest = RegisterRequest(
      email: email,
      fullName: fullName,
      password: password,
    );

    final res = await ref.read(authProvider.notifier).register(registerRequest);

    if (!mounted) return;
    if (res.status) {
      context.router.pushPath(AppRouter.login);
    } else {
      CustomToast.error(msg: res.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final theme = context.theme;
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.2,
                  child: Center(
                    child: Assets.logo.launcherIcon.image(
                      width: size.width * 0.8,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .3),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(22, 16, 0, 16),
                            child: Text(
                              'Registration',
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontSize: 32,
                              ),
                            ),
                          ),
                        ),
                        AuthInputField(
                          controller: _fullNameController,
                          labelText: 'Full Name',
                          hintText: 'Your full name',
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Full name is required!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AuthInputField(
                          controller: _emailController,
                          labelText: 'Email',
                          hintText: 'Your email id',
                          keyboardType: TextInputType.emailAddress,
                          validator: (textValue) {
                            if (textValue != null && textValue.isNotEmpty) {
                              if (!RegExp(
                                r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}",
                              ).hasMatch(textValue)) {
                                return 'Enter a valid email';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AuthInputField(
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: 'Your password',
                          obscureText: true,
                          suffixIcon: true,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Password is required!';
                            }
                            if (textValue.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: CustomButton(
                            label: 'Create Account',
                            isLoading: isLoading,
                            onPressed: submit,
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account? ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    context.router.pushPath(AppRouter.login),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
