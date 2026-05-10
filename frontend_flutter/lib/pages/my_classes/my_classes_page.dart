import 'package:flutter/material.dart';

import '../../components/button/button_widget.dart';
import '../../components/class_card/class_card_widget.dart';
import '../../components/text_field/text_field_widget.dart';

import '../../components/top_nav_bar/top_nav_bar_widget.dart';
import '../friends/friends_page.dart';
import '../import_export/import_export_page.dart';

import '../../backend/backend_service.dart';
import '../../backend/session_manager.dart';

class MyClassesPage extends StatefulWidget {
  const MyClassesPage({super.key});

  @override
  State<MyClassesPage> createState() => _MyClassesPageState();
}

class _MyClassesPageState extends State<MyClassesPage> {
  String search = '';
  List<Map<String, dynamic>> classes = [];
  String userId = '';

  @override
  void initState() {
    super.initState();
    loadClasses();
  }
  
  Future<void> loadClasses() async {
    String email = await SessionManager.getEmail();
    if (email == '') return;
    final classesCheck =
        await BackendService.getAllClasses(
      userId: email,
    );

    setState(() {
      classes = classesCheck;
      userId = email;
    });
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
            const TopNavBar(
              currentIndex: 2,
            ),

          Divider(
            height: 1,
            color: colors.outlineVariant,
          ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                  children: [
                    TextFieldWidget(
                      hint: 'Search your courses...',
                      leadingIcon: Icon(
                        Icons.search_rounded,
                        color: colors.onSurface,
                        size: 16,
                      ),
                      leadingIconPresent: true,
                      variant: 'filled',
                      onChanged: (value) {
                        setState(() {
                          search = value;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    ...classes.map(
                      (course) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: 16),
                        child: FutureBuilder<List<Map<String, String>>>(
                          future: BackendService.getFriendsInClass(
                            userId: userId,
                            courseCode: course['code'] as String,
                          ),
                          builder: (context, snapshot) {
                            final friendData =
                                snapshot.data ?? [];

                            final friendNames = friendData
                                .map((f) => f['name'] ?? '')
                                .toList();

                            return ClassCardWidget(
                              courseCode: course['code'] as String,
                              courseName: course['name'] as String,
                              time:
                                  '${(course['days'] as List).join(', ')}: ${course['startTime']} - ${course['endTime']}',

                              friends: friendNames,

                              onViewAll: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FriendsPage(
                                      courseFilter:
                                          course['code'] as String,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius:
                              BorderRadius.circular(24),
                          border: Border.all(
                            color: colors.outlineVariant,
                          ),
                        ),
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(
                              Icons.import_export_rounded,
                              color: colors.onSurfaceVariant,
                              size: 40,
                            ),

                            const SizedBox(height: 16),

                            Text(
                              'Missing a class?',
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              'Import your schedule directly from WebAdvisor to sync with friends.',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(
                                color: colors.onSurfaceVariant,
                                height: 1.5,
                              ),
                            ),

                            const SizedBox(height: 16),

                            ButtonWidget(
                              content: 'Import Schedule',
                              variant: 'outline',
                              size: 'medium',
                              fullWidth: false,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const ImportExportPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
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