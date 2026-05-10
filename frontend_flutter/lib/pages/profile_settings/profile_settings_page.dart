import 'package:flutter/material.dart';

import '../../components/button/button_widget.dart';
import '../../components/switch_component/switch_component_widget.dart';
import '../../components/text_field/text_field_widget.dart';
import '../login/login_page.dart';
import '../../components/top_nav_bar/top_nav_bar_widget.dart';
import '../../backend/backend_service.dart';
import '../../backend/session_manager.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() =>
      _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {

  String userId = '';
  String fullName = '';
  String bio = '';
  String major = '';
  String email = '';
  bool discoveryActive = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }


  Future<void> loadUser() async {
    final checkEmail = await SessionManager.getEmail();
    if (checkEmail == '') return;
    final userInfo = await BackendService.getUserProfile(userId: checkEmail);

    setState(() {
      userId = checkEmail;
      fullName = userInfo['name'] ?? '';
      bio = userInfo['bio'] ?? '';
      major = userInfo['major'] ?? '';
      email = userInfo['email'] ?? '';
      discoveryActive = userInfo['discoverable'] ?? true;
    });
  }

  submitChanges() async {
    if (await BackendService.updateProfile(
      userId: userId,
      name: fullName,
      bio: bio,
      major: major,
      discoverable: discoveryActive,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Changes submitted!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit changes'),
        ),
      );
    }
  }

  deleteAccount() async{
    if (await BackendService.deleteProfile(userId: userId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account deleted!'),
        ),
      );

      Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete account'),
        ),
      );
    }
  }

  signOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
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
        body: Column(
          children: [
            const TopNavBar(currentIndex: 5),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: colors.outlineVariant),
                      ),
                      child: Column(
                        children: [
                          Text(
                            fullName.isEmpty ? 'Your Name' : fullName,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            major.isEmpty ? 'Your Major' : major,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    const _SectionTitle(title: 'Personal Information'),

                    const SizedBox(height: 12),

                    TextFieldWidget(
                      label: 'Full Name',
                      labelPresent: true,
                      hint: 'Type here...',
                      value: fullName,
                      leadingIcon: const Icon(Icons.person_outline_rounded),
                      variant: 'outlined',
                      onChanged: (value) => setState(() => fullName = value),
                    ),

                    const SizedBox(height: 16),

                    TextFieldWidget(
                      label: 'University Email',
                      labelPresent: true,
                      hint: 'Email goes here...',
                      value: email,
                      enabled: false,
                      leadingIcon: const Icon(Icons.mail_outline_rounded),
                      variant: 'outlined',
                    ),

                    const SizedBox(height: 16),

                    TextFieldWidget(
                      label: 'Major',
                      labelPresent: true,
                      hint: 'Type here...',
                      value: major,
                      leadingIcon: const Icon(Icons.school_rounded),
                      variant: 'outlined',
                      onChanged: (value) => setState(() => major = value),
                    ),

                    const SizedBox(height: 16),

                    TextFieldWidget(
                      label: 'Bio',
                      labelPresent: true,
                      hint: 'Tell people about yourself...',
                      value: bio,
                      leadingIcon: const Icon(Icons.notes_rounded),
                      variant: 'outlined',
                      onChanged: (value) => setState(() => bio = value),
                    ),

                    const SizedBox(height: 24),

                    const _SectionTitle(title: 'Account & Privacy'),

                    const SizedBox(height: 12),

                    Container(
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: colors.outlineVariant),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: SwitchComponentWidget(
                        label: 'Discoverable on Discovery Page',
                        labelPresent: true,
                        variant: 'Android',
                        active: discoveryActive,
                        onChanged: (value) {
                          setState(() => discoveryActive = value);
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    ButtonWidget(
                      content: 'Submit Changes',
                      variant: 'primary',
                      size: 'medium',
                      fullWidth: true,
                      onPressed: submitChanges,
                    ),

                    const SizedBox(height: 12),

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
                      onPressed: signOut,
                    ),

                    const SizedBox(height: 12),

                    ButtonWidget(
                      content: 'Delete Account',
                      variant: 'destructive',
                      size: 'medium',
                      fullWidth: true,
                      onPressed: deleteAccount,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}