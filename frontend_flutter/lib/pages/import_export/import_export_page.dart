import 'package:flutter/material.dart';

import '../../components/tool_card/tool_card_widget.dart';
import '../../components/top_nav_bar/top_nav_bar_widget.dart';
import '../../backend/backend_service.dart';
import '../../backend/session_manager.dart';

class ImportExportPage extends StatefulWidget {
  const ImportExportPage({super.key});

  @override
  State<ImportExportPage> createState() => _ImportExportPageState();
}

class _ImportExportPageState extends State<ImportExportPage> {
  String userId = '';

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final email = await SessionManager.getEmail();
    if (email == '') return;

    setState(() {
      userId = email;
    });
  }

  Future<void> importSchedule() async {
    await BackendService.importSchedule();
  }

  Future<void> exportGoogle() async {
    await BackendService.exportScheduleGoogle(
      fromUserId: userId,
      toEmail: userId,
    );
  }

  Future<void> exportOutlook() async {
    await BackendService.exportScheduleOutlook(
      fromUserId: userId,
      toEmail: userId,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TopNavBar(
                currentIndex: 4,
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sync Your Schedule',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Connect your academic data and keep your calendar updated across all platforms.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _SectionHeader(
                  icon: Icons.download_rounded,
                  title: 'Import Schedule',
                  color: colors.primary,
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ToolCardWidget(
                  iconBg: colors.primaryContainer,
                  icon: Icon(
                    Icons.school_rounded,
                    color: colors.onPrimaryContainer,
                    size: 24,
                  ),
                  iconColor: colors.onPrimaryContainer,
                  title: 'WebAdvisor',
                  subtitle:
                      'Fetch your current semester courses and classmates automatically.',
                  buttonText: 'Connect WebAdvisor',
                  variant: 'primary',
                  buttonIcon: 'login_rounded',
                  onPressed: importSchedule,
                ),
              ),

              const SizedBox(height: 24),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: _SectionHeader(
                  icon: Icons.upload_rounded,
                  title: 'Export to Calendar',
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ToolCardWidget(
                  icon: const Icon(Icons.event_available_rounded, size: 24),
                  title: 'Google Calendar',
                  subtitle:
                      'Add your class times and study sessions to your Google account.',
                  buttonText: 'Export to Google',
                  variant: 'outline',
                  buttonIcon: 'open_in_new_rounded',
                  onPressed: exportGoogle,
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ToolCardWidget(
                  icon: const Icon(Icons.calendar_month_rounded, size: 24),
                  title: 'Outlook Calendar',
                  subtitle:
                      'Sync with your Microsoft 365 or Outlook.com school account.',
                  buttonText: 'Export to Outlook',
                  variant: 'outline',
                  buttonIcon: 'open_in_new_rounded',
                  onPressed: exportOutlook,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: colors.outlineVariant),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lock_outline_rounded,
                            color: colors.onSurfaceVariant,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Your login credentials are never stored. We only access your course schedule data.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onSurfaceVariant,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.color,
  });

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}