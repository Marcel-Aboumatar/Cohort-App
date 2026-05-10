import 'package:flutter/material.dart';

class NavItemWidget extends StatelessWidget {
  const NavItemWidget({
    super.key,
    this.onTap,
    this.icon,
    this.active = true,
    this.label = 'Discover',
  });

  final VoidCallback? onTap;
  final Widget? icon;
  final bool active;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ??
                Icon(
                  Icons.explore_rounded,
                  color: active
                      ? colors.primary
                      : colors.onSurfaceVariant,
                ),

            const SizedBox(width: 8),

            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: active
                    ? colors.primary
                    : colors.onSurfaceVariant,
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}