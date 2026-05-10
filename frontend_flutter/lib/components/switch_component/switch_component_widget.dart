import 'package:flutter/material.dart';

class SwitchComponentWidget extends StatefulWidget {
  const SwitchComponentWidget({
    super.key,
    this.label = 'Active Discovery',
    this.labelPresent = true,
    this.variant = 'Android',
    this.active = false,
    this.onChanged,
  });

  final String label;
  final bool labelPresent;
  final String variant;
  final bool active;
  final ValueChanged<bool>? onChanged;

  @override
  State<SwitchComponentWidget> createState() =>
      _SwitchComponentWidgetState();
}

class _SwitchComponentWidgetState
    extends State<SwitchComponentWidget> {
  late bool switchValue;

  @override
  void initState() {
    super.initState();
    switchValue = widget.active;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.variant != 'iOS 26+')
            Switch(
              value: switchValue,
              onChanged: (value) {
                setState(() {
                  switchValue = value;
                });

                widget.onChanged?.call(value);
              },
              activeTrackColor: colors.primary,
              inactiveTrackColor: colors.outlineVariant,
              inactiveThumbColor: colors.onSurfaceVariant,
            ),

          if (widget.variant == 'iOS 26+')
            GestureDetector(
              onTap: () {
                setState(() {
                  switchValue = !switchValue;
                });

                widget.onChanged?.call(switchValue);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 64,
                height: 28,
                decoration: BoxDecoration(
                  color: switchValue
                      ? colors.primary
                      : colors.outlineVariant,
                  borderRadius: BorderRadius.circular(9999),
                ),
                padding: const EdgeInsets.all(2),
                child: Align(
                  alignment: switchValue
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 39,
                    height: 24,
                    decoration: BoxDecoration(
                      color: switchValue
                          ? colors.onPrimary
                          : colors.surface,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                ),
              ),
            ),

          if (widget.labelPresent)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                widget.label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface,
                  height: 1.6,
                ),
              ),
            ),
        ],
      ),
    );
  }
}