import 'package:flutter/material.dart';

import '../../components/button/button_widget.dart';
import '../../components/discovery_card/discovery_card_widget.dart';
import '../../components/top_nav_bar/top_nav_bar_widget.dart';
import '../../backend/backend_service.dart';
import '../../backend/session_manager.dart';

class MainDiscoveryPage extends StatefulWidget {
  const MainDiscoveryPage({super.key});

  @override
  State<MainDiscoveryPage> createState() => _MainDiscoveryPageState();
}

class _MainDiscoveryPageState extends State<MainDiscoveryPage> {
  List<Map<String, dynamic>> discoveryItems = [];
  String userId = '';

  @override
  void initState() {
    super.initState();
    loadRandomShared();
  }

  Future<void> loadRandomShared() async {
    final email = await SessionManager.getEmail();

    if (email.isEmpty) return;

    final users = await BackendService.getRandomShared(
      userId: email,
    );

    setState(() {
      discoveryItems = users;
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
            const TopNavBar(currentIndex: 0),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Finding cohorts in your classes',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),

                    for (int i = discoveryItems.length - 1; i >= 0; i--) ...[
                      const SizedBox(height: 24),
                      DiscoveryCardWidget(
                        name: discoveryItems[i]['name'] ?? '',
                        age: discoveryItems[i]['age'] ?? '',
                        major: discoveryItems[i]['major'] ?? '',

                        onRequest: () async {
                          await BackendService.sendFriendRequest(
                            fromUserId: userId,
                            toEmail: discoveryItems[i]['email'] ?? '',
                          );
                        },

                        classes: discoveryItems[i]['shared'] != null
                            ? List<String>.from(discoveryItems[i]['shared'])
                            : [],
                      ),
                    ],

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
                            onPressed: loadRandomShared,
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