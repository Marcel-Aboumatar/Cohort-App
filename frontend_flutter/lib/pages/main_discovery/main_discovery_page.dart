import 'package:flutter/material.dart';

import '../../components/button/button_widget.dart';
import '../../components/discovery_card/discovery_card_widget.dart';
import '../../components/nav_item/nav_item_widget.dart';
import '../friends/friends_page.dart';
import '../my_classes/my_classes_page.dart';
import '../profile_settings/profile_settings_page.dart';
import '../import_export/import_export_page.dart';

class MainDiscoveryPage extends StatelessWidget {
  const MainDiscoveryPage({super.key});

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
            SafeArea(
              bottom: false,
              child: Container(
                color: colors.surface,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'cohort',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: colors.primary,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                            ),
                          ),

                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.notifications_outlined,
                                  color: colors.onSurfaceVariant,
                                ),
                              ),

                              const SizedBox(width: 8),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ProfileSettingsPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: colors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'JS',
                                    style: theme.textTheme.labelMedium?.copyWith(
                                      color: colors.onPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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

            Container(
              color: colors.surface,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          NavItemWidget(
                            icon: const Icon(Icons.explore_rounded),
                            active: true,
                            label: 'Discover',
                            onTap: () {},
                          ),

                          const SizedBox(width: 16),

                          NavItemWidget(
                            icon: const Icon(Icons.group_rounded),
                            active: false,
                            label: 'Friends',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FriendsPage(),
                                ),
                              );
                            },
                          ),

                          const SizedBox(width: 16),

                          NavItemWidget(
                            icon: const Icon(Icons.auto_stories_rounded),
                            active: false,
                            label: 'My Classes',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MyClassesPage(),
                                ),
                              );
                            },
                          ),

                          const SizedBox(width: 16),

                          NavItemWidget(
                            icon: const Icon(Icons.cloud_upload_rounded),
                            active: false,
                            label: 'Import',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ImportExportPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  Divider(
                    height: 1,
                    color: colors.outlineVariant,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Finding cohorts in your classes',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    DiscoveryCardWidget(
                      name: 'Alex Rivera',
                      age: '20',
                      major: 'Computer Science',
                      classes: const ['Data Structures', 'Linear Algebra'],
                    ),

                    const SizedBox(height: 24),

                    DiscoveryCardWidget(
                      name: 'Sarah Chen',
                      age: '21',
                      major: 'Digital Design',
                      classes: const ['UI/UX Design', 'Art History'],
                    ),

                    const SizedBox(height: 24),

                    DiscoveryCardWidget(
                      name: 'Jordan Smith',
                      age: '19',
                      major: 'Software Eng',
                      classes: const ['Data Structures', 'Web Dev', 'Mobile Dev'],
                    ),

                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Icon(
                            Icons.auto_awesome_rounded,
                            size: 32,
                            color: colors.onSurface,
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'No more students in these classes',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                              height: 1.6,
                            ),
                          ),

                          const SizedBox(height: 8),

                          ButtonWidget(
                            content: 'Refresh Feed',
                            variant: 'ghost',
                            size: 'small',
                            fullWidth: false,
                            onPressed: () {},
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