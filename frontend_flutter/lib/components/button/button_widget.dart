import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.content = 'Compare Schedules',
    this.icon,
    this.iconPresent = false,
    this.iconEnd,
    this.iconEndPresent = false,
    this.variant = 'outline',
    this.size = 'small',
    this.fullWidth = true,
    this.loading = false,
    this.disabled = false,
    this.onPressed,
  });

  final String content;
  final Widget? icon;
  final bool iconPresent;
  final Widget? iconEnd;
  final bool iconEndPresent;
  final String variant;
  final String size;
  final bool fullWidth;
  final bool loading;
  final bool disabled;
  final VoidCallback? onPressed;

  double get radius {
    if (size == 'small') return 8;
    if (size == 'large') return 24;
    return 14;
  }

  EdgeInsets get padding {
    if (size == 'small') {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 4);
    }
    if (size == 'large') {
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
    return const EdgeInsets.symmetric(horizontal: 24, vertical: 8);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    Color background;
    Color textColor;
    Border? border;

    switch (variant) {
      case 'secondary':
        background = color.secondary;
        textColor = color.onSecondary;
        border = null;
        break;
      case 'outline':
        background = Colors.transparent;
        textColor = color.onSurface;
        border = Border.all(color: color.outlineVariant);
        break;
      case 'ghost':
        background = Colors.transparent;
        textColor = color.primary;
        border = null;
        break;
      case 'destructive':
        background = color.error;
        textColor = color.onError;
        border = null;
        break;
      default:
        background = color.primary;
        textColor = color.onPrimary;
        border = null;
    }

    final button = Opacity(
      opacity: disabled ? 0.55 : 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: disabled || loading ? null : onPressed,
        child: Container(
          width: fullWidth ? double.infinity : null,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(radius),
            border: border,
          ),
          padding: padding,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: loading ? 0 : 1,
                child: Row(
                  mainAxisSize:
                      fullWidth ? MainAxisSize.max : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (iconPresent && icon != null) ...[
                      icon!,
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Text(
                        content,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),
                    if (iconEndPresent && iconEnd != null) ...[
                      const SizedBox(width: 8),
                      iconEnd!,
                    ],
                  ],
                ),
              ),
              if (loading)
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: textColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}