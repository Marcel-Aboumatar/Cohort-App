import 'package:flutter/material.dart';

import '../button/button_widget.dart';

class ToolCardWidget extends StatelessWidget {
  const ToolCardWidget({
    super.key,
    this.iconBg,
    this.icon,
    this.iconColor,
    this.title = 'WebAdvisor',
    this.subtitle =
        'Fetch your current semester courses and classmates automatically.',
    this.buttonText = 'Connect WebAdvisor',
    this.variant = 'primary',
    this.buttonIcon = 'login_rounded',
    this.onPressed,
  });

  final Color? iconBg;
  final Widget? icon;
  final Color? iconColor;
  final String title;
  final String subtitle;
  final String buttonText;
  final String variant;
  final String buttonIcon;
  final VoidCallback? onPressed;

  IconData get resolvedButtonIcon {
    switch (buttonIcon) {
      case 'add_rounded':
        return Icons.add_rounded;
      case 'link_rounded':
        return Icons.link_rounded;
      case 'school_rounded':
        return Icons.school_rounded;
      case 'sync_rounded':
        return Icons.sync_rounded;
      case 'login_rounded':
      default:
        return Icons.login_rounded;
    }
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBg ?? colors.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: icon ??
                    Icon(
                      Icons.school_rounded,
                      color: iconColor ?? colors.onPrimaryContainer,
                    ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

          ButtonWidget(
            content: buttonText,
            icon: Icon(
              resolvedButtonIcon,
              color: colors.onPrimary,
              size: 16,
            ),
            iconPresent: false,
            iconEndPresent: false,
            variant: variant,
            size: 'medium',
            fullWidth: true,
            loading: false,
            disabled: false,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}