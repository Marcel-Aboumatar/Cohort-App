import 'package:flutter/material.dart';

import '../../components/button/button_widget.dart';
import '../../components/friend_card/friend_card_widget.dart';
import '../../components/tab_group/tab_group_widget.dart';
import '../../components/text_field/text_field_widget.dart';
import '../main_discovery/main_discovery_page.dart';
import '../profile_settings/profile_settings_page.dart';
import '../../components/top_nav_bar/top_nav_bar_widget.dart';
import '../friend_requests/friend_requests_page.dart';
import '../../backend/backend_service.dart';
import '../../backend/session_manager.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({
    super.key,
    this.courseFilter,
  });

  final String? courseFilter;

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  void openProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileSettingsPage(),
      ),
    );
  }

  String search = '';
  List<Map<String, String>> friends = [];
  String userId = '';

  @override
  void initState() {
    super.initState();
    loadFriends();
  }
  
  Future<void> loadFriends() async {
    String email = await SessionManager.getEmail();
    if (email == '') return;
    final users =
        await BackendService.getAllFriends(
      userId: email,
    );

    setState(() {
      friends = users;
      userId = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final filteredFriends = friends.where((user) {
      return user['name']!
          .toLowerCase()
          .contains(search.toLowerCase());
    }).toList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TopNavBar(
              currentIndex: 1,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                16,
                24,
                0,
              ),
              child: TabGroupWidget(
                labels: const ['My Friends', 'Friend Requests'],
                initialIndex: 0,
                onTabChanged: (index) {
                  if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FriendRequestsPage(),
                      ),
                    );
                  }
                },
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
                      hint: 'Search your friends...',
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

                    const SizedBox(height: 20),

                    Text(
                      widget.courseFilter == null
                          ? 'Your Connections'
                          : 'Friends in ${widget.courseFilter}',
                    ),

                    const SizedBox(height: 16),

                    ...filteredFriends.map(
                      (friend) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: FutureBuilder<
                            List<Map<String, dynamic>>>(
                          future: BackendService.getSharedClasses(
                            userId: userId,
                            otherId: friend['email'] ?? '',
                          ),
                          builder: (context, snapshot) {
                            final sharedClasses =
                                snapshot.data ?? [];

                            return FriendCardWidget(
                              name: friend['name']!,
                              email: friend['email']!,
                              classes: sharedClasses
                                  .map(
                                    (c) => c['code'].toString(),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: colors.primaryContainer
                            .withOpacity(0.3),
                        borderRadius:
                            BorderRadius.circular(24),
                        border: Border.all(
                          color: colors.primaryContainer,
                        ),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text(
                            'Looking for more classmates?',
                            textAlign: TextAlign.center,
                            style:
                                theme.textTheme.bodyMedium?.copyWith(
                              color: colors.primary,
                              height: 1.6,
                            ),
                          ),

                          const SizedBox(height: 8),

                          ButtonWidget(
                            content: 'Discover People',
                            icon: Icon(
                              Icons.explore_rounded,
                              color: colors.onPrimary,
                              size: 16,
                            ),
                            iconPresent: true,
                            variant: 'primary',
                            size: 'medium',
                            fullWidth: false,
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const MainDiscoveryPage(),
                                ),
                              );
                            },
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