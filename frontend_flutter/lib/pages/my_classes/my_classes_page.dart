import 'package:flutter/material.dart';

import '../../components/button/button_widget.dart';
import '../../components/class_card/class_card_widget.dart';
import '../../components/text_field/text_field_widget.dart';

import '../friends/friends_page.dart';
import '../import_export/import_export_page.dart';
import '../main_discovery/main_discovery_page.dart';
import '../profile_settings/profile_settings_page.dart';

class MyClassesPage extends StatefulWidget {
  const MyClassesPage({super.key});

  @override
  State<MyClassesPage> createState() => _MyClassesPageState();
}

class _MyClassesPageState extends State<MyClassesPage> {
  String search = '';

  final classes = [
    {
      'code': 'CIS 1300',
      'name': 'Programming',
      'time': 'MWF 10:00 AM',
      'friends': '',
    },
    {
      'code': 'MATH 1200',
      'name': 'Linear Algebra',
      'time': 'TTh 1:30 PM',
      'friends': '',
    },
    {
      'code': 'HIST 1050',
      'name': 'World History II',
      'time': 'MWF 2:00 PM',
      'friends': '',
    },
    {
      'code': 'PHYS 3010',
      'name': 'Quantum Mechanics',
      'time': 'TTh 9:00 AM',
      'friends': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final filteredClasses = classes.where((course) {
      final query = search.toLowerCase();

      return course['code']!
              .toLowerCase()
              .contains(query) ||
          course['name']!
              .toLowerCase()
              .contains(query);
    }).toList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,

        body: Column(
          children: [
            SafeArea(
              bottom: false,
              child: Container(
                color: colors.surface,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        24,
                        16,
                        24,
                        16,
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const MainDiscoveryPage(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  color: colors.onSurface,
                                ),
                              ),

                              const SizedBox(width: 16),

                              Text(
                                'My Classes',
                                style: theme.textTheme.titleLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),

                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ImportExportPage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.add_circle_outline_rounded,
                              color: colors.primary,
                              size: 28,
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

                    ...filteredClasses.map(
                      (course) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: 16),
                        child: ClassCardWidget(
                          courseCode: course['code']!,
                          courseName: course['name']!,
                          time: course['time']!,
                          friendSources:
                              course['friends']!,
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

            SafeArea(
              top: false,
              child: Container(
                color: colors.surface,
                child: Column(
                  children: [
                    Divider(
                      height: 1,
                      color: colors.outlineVariant,
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        24,
                        16,
                        24,
                        16,
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const MainDiscoveryPage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.explore_rounded,
                              color: colors.onSurfaceVariant,
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const FriendsPage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.group_rounded,
                              color: colors.onSurfaceVariant,
                            ),
                          ),

                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.school_rounded,
                              color: colors.primary,
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ProfileSettingsPage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.person_rounded,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
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