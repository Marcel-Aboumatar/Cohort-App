import 'package:flutter/material.dart';

import '../../pages/friend_requests/friend_requests_page.dart';
import '../../pages/friends/friends_page.dart';
import '../../pages/import_export/import_export_page.dart';
import '../../pages/main_discovery/main_discovery_page.dart';
import '../../pages/my_classes/my_classes_page.dart';
import '../../pages/profile_settings/profile_settings_page.dart';
import '../../pages/schedule/schedule_page.dart';

import '../nav_item/nav_item_widget.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  void navigate(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget page = const MainDiscoveryPage();

    switch (index) {
      case 0:
        page = const MainDiscoveryPage();
        break;

      case 1:
        page = const FriendsPage();
        break;

      case 2:
        page = const MyClassesPage();
        break;

      case 3:
        page = const SchedulePage();
        break;

      case 4:
        page = const ImportExportPage();
        break;

      case 5:
        page = const ProfileSettingsPage();
        break;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
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
                      Text(
                        'cohort',
                        style:
                            theme.textTheme.headlineSmall?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w900,
                          height: 1.3,
                        ),
                      ),

                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const FriendRequestsPage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.notifications_outlined,
                              color: colors.onSurfaceVariant,
                            ),
                          ),

                          const SizedBox(width: 8),

                          GestureDetector(
                            onTap: () {
                              navigate(context, 5);
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
                                style:
                                    theme.textTheme.labelMedium?.copyWith(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      NavItemWidget(
                        icon: const Icon(
                          Icons.explore_rounded,
                        ),
                        active: currentIndex == 0,
                        label: 'Discover',
                        onTap: () => navigate(context, 0),
                      ),

                      const SizedBox(width: 16),

                      NavItemWidget(
                        icon: const Icon(
                          Icons.group_rounded,
                        ),
                        active: currentIndex == 1,
                        label: 'Friends',
                        onTap: () => navigate(context, 1),
                      ),

                      const SizedBox(width: 16),

                      NavItemWidget(
                        icon: const Icon(
                          Icons.auto_stories_rounded,
                        ),
                        active: currentIndex == 2,
                        label: 'My Classes',
                        onTap: () => navigate(context, 2),
                      ),

                      const SizedBox(width: 16),

                      NavItemWidget(
                        icon: const Icon(
                          Icons.calendar_month_rounded,
                        ),
                        active: currentIndex == 3,
                        label: 'Calendar',
                        onTap: () => navigate(context, 3),
                      ),

                      const SizedBox(width: 16),

                      NavItemWidget(
                        icon: const Icon(
                          Icons.cloud_upload_rounded,
                        ),
                        active: currentIndex == 4,
                        label: 'Import',
                        onTap: () => navigate(context, 4),
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
      ],
    );
  }
}