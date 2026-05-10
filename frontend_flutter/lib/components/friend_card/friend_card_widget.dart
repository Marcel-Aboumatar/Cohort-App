import 'package:flutter/material.dart';

import '../button/button_widget.dart';

class FriendCardWidget extends StatelessWidget {
  const FriendCardWidget({
    super.key,
    this.name = '',
    this.classes = const ['Data Structures', 'Linear Algebra'],
    this.onMessage,
    this.onCompareSchedules,
  });

  final String name;
  final List<String> classes;

  final VoidCallback? onMessage;
  final VoidCallback? onCompareSchedules;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: colors.outlineVariant,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(16),
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
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Row(
                        children: [
                          Icon(
                            Icons.school_rounded,
                            size: 14,
                            color: colors.onSurfaceVariant,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            '${classes.length} classes shared',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colors.onSurfaceVariant,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: onMessage,
                  icon: Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: colors.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Divider(
              height: 16,
              thickness: 1,
              color: colors.outlineVariant,
            ),

            const SizedBox(height: 16),

            Text(
              'Shared Classes',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: classes.map((course) {
                return _ClassChip(label: course);
              }).toList(),
            ),

            const SizedBox(height: 16),

            ButtonWidget(
              content: 'View Profile',
              variant: 'outline',
              size: 'small',
              fullWidth: true,
              onPressed: onCompareSchedules,
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.initials,
    required this.imageUrl,
  });

  final String initials;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (imageUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(imageUrl),
      );
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        maxLines: 1,
        overflow: TextOverflow.clip,
        style: TextStyle(
          color: colors.onPrimaryContainer,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ),
    );
  }
}

class _ClassChip extends StatelessWidget {
  const _ClassChip({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colors.onPrimaryContainer,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}