import 'package:flutter/material.dart';

import '../../components/button/button_widget.dart';
import '../../components/profile_option/profile_option_widget.dart';
import '../../components/switch_component/switch_component_widget.dart';
import '../../components/text_field/text_field_widget.dart';
import '../login/login_page.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() =>
      _ProfileSettingsPageState();
}

class _ProfileSettingsPageState
    extends State<ProfileSettingsPage> {
  String fullName = 'John Doe';
  String email = 'johndoe@uoguelph.ca';
  String bio = 'Computer Science student';

  bool discoveryActive = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                bottom: false,
                child: Container(
                  color: colors.surface,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: colors.onSurface,
                              ),
                            ),

                            Text(
                              'Profile Settings',
                              style:
                                  theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                height: 1.4,
                              ),
                            ),

                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.check_rounded,
                                color: colors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        height: 1,
                        color: colors.outlineVariant,
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  32,
                  24,
                  32,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(50),
                          child: Image.network(
                            'https://dimg.dreamflow.cloud/v1/image/student%20profile%20photo',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: colors.surface,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colors.background,
                                width: 2,
                              ),
                            ),
                            padding:
                                const EdgeInsets.all(4),
                            child: Icon(
                              Icons.edit_rounded,
                              size: 16,
                              color: colors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Text(
                      fullName,
                      style:
                          theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '@johndoe_24',
                      style:
                          theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Container(
                      height: 34,
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primaryContainer,
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Computer Science',
                        style:
                            theme.textTheme.labelMedium?.copyWith(
                          color: colors.onPrimaryContainer,
                          fontSize: 14,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Personal Information',
                      style:
                          theme.textTheme.labelLarge?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextFieldWidget(
                      label: 'Full Name',
                      labelPresent: true,
                      hint: 'Type here...',
                      value: fullName,
                      leadingIcon:
                          const Icon(Icons.person_outline_rounded),
                      leadingIconPresent: true,
                      variant: 'outlined',
                      onChanged: (value) {
                        setState(() {
                          fullName = value;
                        });
                      },
                    ),

                    const SizedBox(height: 8),

                    TextFieldWidget(
                      label: 'University Email',
                      labelPresent: true,
                      hint: 'Type here...',
                      value: email,
                      leadingIcon:
                          const Icon(Icons.mail_outline_rounded),
                      leadingIconPresent: true,
                      variant: 'outlined',
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),

                    const SizedBox(height: 8),

                    TextFieldWidget(
                      label: 'Bio',
                      labelPresent: true,
                      hint: 'Type here...',
                      value: bio,
                      leadingIcon:
                          const Icon(Icons.notes_rounded),
                      leadingIconPresent: true,
                      variant: 'outlined',
                      onChanged: (value) {
                        setState(() {
                          bio = value;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Account & Privacy',
                      style:
                          theme.textTheme.labelLarge?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 8),

                    ProfileOptionWidget(
                      icon: Icon(
                        Icons.notifications_none_rounded,
                        color: colors.onPrimaryContainer,
                      ),
                      title: 'Notifications',
                      subtitle:
                          'Manage alerts and updates',
                    ),

                    const SizedBox(height: 8),

                    ProfileOptionWidget(
                      icon: Icon(
                        Icons.lock_outline_rounded,
                        color: colors.onPrimaryContainer,
                      ),
                      title: 'Privacy',
                      subtitle:
                          'Control who sees your profile',
                    ),

                    const SizedBox(height: 8),

                    ProfileOptionWidget(
                      icon: Icon(
                        Icons.visibility_rounded,
                        color: colors.onPrimaryContainer,
                      ),
                      title: 'Discovery Status',
                      subtitle:
                          'Appear in classmate searches',
                    ),

                    const SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius:
                            BorderRadius.circular(24),
                        border: Border.all(
                          color: colors.outlineVariant,
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: SwitchComponentWidget(
                        label: 'Active Discovery',
                        labelPresent: true,
                        variant: 'Android',
                        active: discoveryActive,
                        onChanged: (value) {
                          setState(() {
                            discoveryActive = value;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    ButtonWidget(
                      content: 'Sign Out',
                      icon: Icon(
                        Icons.logout_rounded,
                        color: colors.onSurface,
                        size: 16,
                      ),
                      iconPresent: true,
                      variant: 'outline',
                      size: 'medium',
                      fullWidth: true,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const LoginPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    ButtonWidget(
                      content: 'Delete Account',
                      variant: 'destructive',
                      size: 'small',
                      fullWidth: false,
                      onPressed: () {},
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}