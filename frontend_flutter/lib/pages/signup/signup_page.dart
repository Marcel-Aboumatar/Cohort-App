import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/button/button_widget.dart';
import '../../components/text_field/text_field_widget.dart';
import '../login/login_page.dart';
import '../main_discovery/main_discovery_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final majorController = TextEditingController();
  final ageController = TextEditingController();

  bool showPassword = false;
  bool discoverable = true;

  String? error;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    majorController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void createAccount() {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final major = majorController.text.trim();
    final age = ageController.text.trim();

    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        major.isEmpty ||
        age.isEmpty) {
      setState(() {
        error = 'All fields are required';
      });
      return;
    }

    setState(() {
      error = null;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MainDiscoveryPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: colors.onSurface,
                    ),
                  ),

                  Text(
                    'cohort',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w900,
                      height: 1.3,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Account',
                    style:
                        theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Join your classmates and start collaborating',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.6,
                    ),
                  ),
                ],
              ),

              // const SizedBox(height: 32),

              // Column(
              //   children: [
              //     Stack(
              //       children: [
              //         Container(
              //           width: 120,
              //           height: 120,
              //           decoration: BoxDecoration(
              //             borderRadius:
              //                 BorderRadius.circular(9999),
              //             border: Border.all(
              //               color: colors.primaryContainer,
              //               width: 2,
              //             ),
              //           ),
              //           child: ClipRRect(
              //             borderRadius:
              //                 BorderRadius.circular(9999),
              //             child: Image.network(
              //               'https://dimg.dreamflow.cloud/v1/image/minimalist%20student%20avatar%20profile%20placeholder',
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),

              //         Positioned(
              //           bottom: 0,
              //           right: 0,
              //           child: Container(
              //             width: 36,
              //             height: 36,
              //             decoration: BoxDecoration(
              //               color: colors.primary,
              //               shape: BoxShape.circle,
              //               border: Border.all(
              //                 color: colors.surface,
              //                 width: 2,
              //               ),
              //             ),
              //             alignment: Alignment.center,
              //             child: Icon(
              //               Icons.add_a_photo_rounded,
              //               color: colors.onPrimary,
              //               size: 18,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),

              //     const SizedBox(height: 16),

              //     Text(
              //       'Upload profile picture',
              //       style: theme.textTheme.labelMedium?.copyWith(
              //         color: colors.primary,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ],
              // ),

              const SizedBox(height: 32),

              Column(
                children: [
                  TextFieldWidget(
                    label: 'Full Name',
                    labelPresent: true,
                    hint: 'Enter your name',
                    leadingIcon: const Icon(Icons.person_outline_rounded),
                    variant: 'outlined',
                    onChanged: (value) {
                      fullNameController.text = value;
                    },
                  ),

                  const SizedBox(height: 24),

                  TextFieldWidget(
                    label: 'Age',
                    labelPresent: true,
                    hint: 'Enter your age',
                    leadingIcon: const Icon(Icons.cake_rounded),
                    variant: 'outlined',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      ageController.text = value;
                    },
                  ),

                  const SizedBox(height: 24),

                  TextFieldWidget(
                    label: 'Major',
                    labelPresent: true,
                    hint: 'Enter your major (e.g. Computer Science)',
                    leadingIcon: const Icon(Icons.person_outline_rounded),
                    variant: 'outlined',
                    onChanged: (value) {
                      majorController.text = value;
                    },
                  ),

                  const SizedBox(height: 24),

                  TextFieldWidget(
                    label: 'Student Email',
                    labelPresent: true,
                    hint: 'name@university.edu',
                    leadingIcon: const Icon(Icons.mail_outline_rounded),
                    variant: 'outlined',
                    onChanged: (value) {
                      emailController.text = value;
                    },
                  ),

                  const SizedBox(height: 24),

                  TextFieldWidget(
                    label: 'Password',
                    labelPresent: true,
                    hint: 'Create a strong password',
                    leadingIcon: const Icon(Icons.lock_outline_rounded),
                    trailingIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(
                        showPassword
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        size: 20,
                      ),
                    ),
                    trailingIconPresent: true,
                    variant: 'outlined',
                    obscureText: !showPassword,
                    onChanged: (value) {
                      passwordController.text = value;
                    },
                  ),

                  if (error != null) ...[
                    const SizedBox(height: 24),

                    Text(
                      error!,
                      style:
                          theme.textTheme.bodyMedium?.copyWith(
                        color: colors.error,
                        height: 1.6,
                      ),
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 32),

              CheckboxListTile(
                value: discoverable,
                onChanged: (value) {
                  setState(() {
                    discoverable = value ?? false;
                  });
                },
                title: const Text('I would like to be discoverable by my classmates'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

              Column(
                children: [
                  ButtonWidget(
                    content: 'Create Account',
                    variant: 'primary',
                    size: 'large',
                    fullWidth: true,
                    onPressed: createAccount,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(width: 4),

                  ButtonWidget(
                    content: 'Log In',
                    variant: 'ghost',
                    size: 'small',
                    fullWidth: false,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}