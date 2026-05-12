import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/app_route/app_route.dart';
import 'package:flutter_template/core/utils/extension/context_extension.dart';
import 'package:flutter_template/core/widget/auth_input_field.dart';
import 'package:flutter_template/core/widget/custom_button.dart';
import 'package:flutter_template/core/widget/custom_toast.dart';
import 'package:flutter_template/feature/auth/ui/provider/auth_notifier.dart';
import 'package:flutter_template/gen/assets.gen.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController(text: 'password');
  final _phoneController = TextEditingController(text: '1234567898');

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void submit() async {
    FocusScope.of(context).unfocus();

    if (!(_loginFormKey.currentState?.validate() ?? false)) return;
    final usePhone = _tabController.index == 1;
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();
    final result = await ref.read(authProvider.notifier).login(
          email: usePhone ? '' : email,
          password: password,
          phone: usePhone ? phone : '',
        );

    if (mounted) {
      if (result.status) {
        CustomToast.success(
          msg: result.message.isNotEmpty
              ? result.message
              : 'Logged in successfully',
        );
      } else {
        CustomToast.error(msg: result.error);
      }
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
      backgroundColor: colorScheme.primary,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.3,
                  child: Center(
                    child: Assets.logo.launcherIcon.image(
                      width: size.width * 0.8,
                      color: Colors.white,
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
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(22, 16, 0, 16),
                            child: Text(
                              'Log-In',
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: .06),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: TabBar(
                              onTap: (value) {
                                setState(() {});
                              },
                              controller: _tabController,
                              indicator: BoxDecoration(
                                color: Colors.white.withValues(alpha: .3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.white70,
                              dividerHeight: 0,
                              tabs: const [
                                Tab(text: 'Email'),
                                Tab(text: 'Phone'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _tabController.index == 0
                            ? AuthInputField(
                                key: ValueKey('email_input'),
                                controller: _emailController,
                                labelText: 'Email',
                                hintText: 'Your email id',
                                keyboardType: TextInputType.emailAddress,
                                validator: (textValue) {
                                  if (textValue == null || textValue.isEmpty) {
                                    return 'Email is required!';
                                  }
                                  // basic email check
                                  if (!RegExp(
                                    r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}",
                                  ).hasMatch(textValue)) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              )
                            :
                            // Phone input
                            AuthInputField(
                                key: ValueKey('phone_input'),
                                controller: _phoneController,
                                labelText: 'Phone',
                                hintText: 'Your phone number',
                                keyboardType: TextInputType.phone,
                                validator: (textValue) {
                                  if (textValue == null || textValue.isEmpty) {
                                    return 'Phone is required!';
                                  }
                                  // basic phone check, accept digits and +
                                  if (!RegExp(
                                    r"^[+0-9]{6,15}",
                                  ).hasMatch(textValue)) {
                                    return 'Enter a valid phone number';
                                  }
                                  return null;
                                },
                              ),
                        const SizedBox(height: 4),
                        // Password field
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
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: size.width * 0.80,
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => context.router.pushPath(
                              AppRouter.resetPassword,
                            ),
                            child: const Text(
                              'Forget password?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: CustomButton(
                            label: 'Login',
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
                                'Don\'t have an account ? ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context.router.pushPath(
                                  AppRouter.registration,
                                ),
                                child: const Text(
                                  'Sign-up',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
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
