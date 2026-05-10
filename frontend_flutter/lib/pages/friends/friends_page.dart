import 'package:flutter/material.dart';

import '../../components/button/button_widget.dart';
import '../../components/friend_card/friend_card_widget.dart';
import '../../components/tab_group/tab_group_widget.dart';
import '../../components/text_field/text_field_widget.dart';
import '../main_discovery/main_discovery_page.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  String search = '';

  final users = [
    {
      'name': 'Alex Rivera',
      'email': 'alex.rivera@example.com'
    },
    {
      'name': 'Sarah Chen',
      'email': 'sarah.chen@example.com'
    },
    {
      'name': 'Jordan Smith',
      'email': 'jordan.smith@example.com'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final filteredUsers = users.where((user) {
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
                              fontWeight: FontWeight.w800,
                              height: 1.3,
                            ),
                          ),

                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.search_rounded,
                                  color: colors.onSurfaceVariant,
                                ),
                              ),

                              const SizedBox(width: 8),

                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.person_outline_rounded,
                                  color: colors.onSurfaceVariant,
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

            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                16,
                24,
                0,
              ),
              child: TabGroupWidget(
                label1: 'My Friends',
                label2: 'Requests',
                label2Present: true,
                label3: 'Add New',
                label3Present: true,
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
                      'Your Connections',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 16),

                    ...filteredUsers.map(
                      (user) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: 16),
                        child: FriendCardWidget(
                          name: user['name']!,
                          classes: [
                            'Data Structures',
                            'Web Development',
                            'Mobile Development'
                          ],
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