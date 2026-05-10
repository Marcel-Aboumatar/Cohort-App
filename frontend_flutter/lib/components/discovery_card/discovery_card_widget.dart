import 'package:flutter/material.dart';

import '../button/button_widget.dart';

class DiscoveryCardWidget extends StatelessWidget {
  const DiscoveryCardWidget({
    super.key,
    this.name = 'Alex Rivera',
    this.age = '20',
    this.major = 'Computer Science',
    this.classes = const ['Data Structures', 'Linear Algebra'],
    this.onRequest,
  });
  final String name;
  final String age;
  final String major;
  final List<String> classes;
  final VoidCallback? onRequest;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
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
                      '$name, $age',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                    Text(
                      major,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ],
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
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 4),

          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              _ClassChip(text: classes[0]),
              _ClassChip(text: classes[1]),

              if (classes.length > 2)
                _ClassChip(
                  text: '${classes.length - 2} more',
                  icon: Icons.add_rounded,
                ),
            ],
          ),

          const SizedBox(height: 16),

          ButtonWidget(
            content: 'Send Friend Request',
            variant: 'primary',
            size: 'medium',
            fullWidth: true,
            onPressed: onRequest,
          ),
        ],
      ),
    );
  }
}

class _ClassChip extends StatelessWidget {
  const _ClassChip({
    required this.text,
    this.icon = Icons.check_rounded,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colors.outlineVariant,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: colors.onSurface,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: theme.textTheme.labelMedium?.copyWith(
              fontSize: 14,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}