import 'package:flutter/material.dart';

import '../button/button_widget.dart';

class ClassCardWidget extends StatelessWidget {
  const ClassCardWidget({
    super.key,
    this.courseCode = 'CS 101',
    this.courseName = 'Intro to Computer Science',
    this.time = 'MWF 10:00 AM',
    this.friendSources =
        'https://i.pravatar.cc/150?u=1,https://i.pravatar.cc/150?u=2,https://i.pravatar.cc/150?u=3',
    this.onViewAll,
  });

  final String courseCode;
  final String courseName;
  final String time;
  final String friendSources;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final friends = friendSources
        .split(',')
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty)
        .toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: colors.outlineVariant,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseCode,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      Text(
                        courseName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colors.onSurface,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    time,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.onPrimaryContainer,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Divider(
              height: 16,
              thickness: 0.5,
              color: colors.outlineVariant,
            ),

            const SizedBox(height: 16),

            Text(
              'Friends in this class',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _FriendAvatars(imageUrls: friends),
                ButtonWidget(
                  content: 'View All',
                  variant: 'ghost',
                  size: 'small',
                  fullWidth: false,
                  onPressed: onViewAll,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FriendAvatars extends StatelessWidget {
  const _FriendAvatars({required this.imageUrls});

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    final shown = imageUrls.take(3).toList();

    if (shown.isEmpty) {
      return Text(
        'No friends yet',
        style: Theme.of(context).textTheme.bodySmall,
      );
    }

    return SizedBox(
      width: 24.0 + (shown.length - 1) * 18.0,
      height: 32,
      child: Stack(
        children: [
          for (int i = 0; i < shown.length; i++)
            Positioned(
              left: i * 18,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(shown[i]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}