import 'package:flutter/material.dart';

import '../../components/button/button_widget.dart';
import '../../components/text_field/text_field_widget.dart';
import '../../components/top_nav_bar/top_nav_bar_widget.dart';
import '../../components/tab_group/tab_group_widget.dart';
import '../friends/friends_page.dart';
import '../../backend/backend_service.dart';
import '../../backend/session_manager.dart';

class FriendRequestsPage extends StatefulWidget {
  const FriendRequestsPage({super.key});

  @override
  State<FriendRequestsPage> createState() => _FriendRequestsPageState();
}

class _FriendRequestsPageState extends State<FriendRequestsPage> {
  String email = '';
  String? message;
  List<Map<String, String>> incomingRequests = [];
  String userId = '';

  @override
  void initState() {
    super.initState();
    loadRequests();
  }
  
  Future<void> loadRequests() async {
    email = await SessionManager.getEmail();
    if (email == '') return;
    final requests =
        await BackendService.getIncomingFriendRequests(
      userId: email,
    );

    setState(() {
      incomingRequests = requests;
      userId = email;
    });
  }

  Future<void> sendRequest() async {
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      setState(() {
        message = 'Please enter a valid email';
      });
      return;
    }

    if (await BackendService.sendFriendRequest(
      fromUserId: 'userId',
      toEmail: email,
    )) {
      setState(() {
        message = 'Friend request sent to $email';
      });
    } else {
      setState(() {
        message = 'Failed to send friend request';
      });
    }
  }

  Future<void> acceptRequest(int index) async {
    String requestId = incomingRequests[index]['email'] ?? 'requestId';
    if (await BackendService.acceptFriendRequest(requestId: requestId)) {
      setState(() {
        message = 'Friend request accepted';
        incomingRequests.removeAt(index);
      });
    } else {
      setState(() {
        message = 'Failed to accept friend request';
      });
    }
  }

  Future<void> declineRequest(int index) async {
    String requestId = incomingRequests[index]['email'] ?? 'requestId';
    if (await BackendService.declineFriendRequest(requestId: requestId)) {
      setState(() {
        message = 'Friend request declined';
        incomingRequests.removeAt(index);
      });
    } else {
      setState(() {
        message = 'Failed to decline friend request';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
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
                initialIndex: 1,
                onTabChanged: (index) {
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FriendsPage(),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Send Friend Request',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextFieldWidget(
                    label: 'Friend Email',
                    labelPresent: true,
                    hint: 'name@university.edu',
                    leadingIcon: const Icon(Icons.mail_outline_rounded),
                    variant: 'outlined',
                    onChanged: (value) {
                      email = value;
                    },
                  ),

                  const SizedBox(height: 12),

                  ButtonWidget(
                    content: 'Send Request',
                    variant: 'primary',
                    size: 'medium',
                    fullWidth: true,
                    onPressed: sendRequest,
                  ),

                  if (message != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      message!,
                      style: TextStyle(color: colors.primary),
                    ),
                  ],

                  const SizedBox(height: 32),

                  Text(
                    'Incoming Requests',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (incomingRequests.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: colors.outlineVariant),
                      ),
                      child: Text(
                        'No incoming friend requests',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: colors.onSurfaceVariant),
                      ),
                    ),

                  for (int i = incomingRequests.length - 1; i >= 0; i--)
                    _RequestCard(
                      name: incomingRequests[i]['name']!,
                      email: incomingRequests[i]['email']!,
                      onAccept: () => acceptRequest(i),
                      onDecline: () => declineRequest(i),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.name,
    required this.email,
    required this.onAccept,
    required this.onDecline,
  });

  final String name;
  final String email;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colors.primaryContainer,
            child: Text(
              name.substring(0, 1),
              style: TextStyle(color: colors.onPrimaryContainer),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(color: colors.onSurfaceVariant),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onDecline,
            icon: Icon(Icons.close_rounded, color: colors.error),
          ),

          IconButton(
            onPressed: onAccept,
            icon: Icon(Icons.check_rounded, color: colors.primary),
          ),
        ],
      ),
    );
  }
}