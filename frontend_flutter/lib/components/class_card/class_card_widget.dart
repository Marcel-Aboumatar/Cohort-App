import 'package:flutter/material.dart';

import '../button/button_widget.dart';

class ClassCardWidget extends StatelessWidget {
  const ClassCardWidget({
    super.key,
    this.courseCode = 'CS 101',
    this.courseName = 'Intro to Computer Science',
    this.time = 'M, W, F: 10:00 AM - 11:00 AM',
    this.friends = const [],
    this.onViewAll,
  });

  final List<String> friends;
  final String courseCode;
  final String courseName;
  final String time;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

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

            Text(
              friends.join(', '),
              style: theme.textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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