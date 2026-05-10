import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    this.label = '',
    this.keyboardType,
    this.inputFormatters,
    this.labelPresent = false,
    this.helper = '',
    this.helperPresent = false,
    this.hint = 'Search your friends...',
    this.value = '',
    this.leadingIcon,
    this.leadingIconPresent = true,
    this.trailingIcon,
    this.trailingIconPresent = false,
    this.variant = 'filled',
    this.error = false,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
  });

  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String label;
  final bool labelPresent;
  final String helper;
  final bool helperPresent;
  final String hint;
  final String value;
  final Widget? leadingIcon;
  final bool leadingIconPresent;
  final Widget? trailingIcon;
  final bool trailingIconPresent;
  final String variant;
  final bool error;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final isFilled = widget.variant == 'filled';
    final isGhost = widget.variant == 'ghost';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.labelPresent)
          Text(
            widget.label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: widget.error ? colors.error : colors.onSurface,
              height: 1.2,
            ),
          ),

        if (widget.labelPresent) const SizedBox(height: 6),

        Container(
          height: 40,
          decoration: BoxDecoration(
            color: isFilled ? colors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.error
                  ? colors.error
                  : isFilled || isGhost
                      ? Colors.transparent
                      : colors.outlineVariant,
              width: isGhost ? 0 : 1,
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              if (widget.leadingIconPresent && widget.leadingIcon != null) ...[
                widget.leadingIcon!,
                const SizedBox(width: 8),
              ],

              Expanded(
                child: TextFormField(
                  inputFormatters: widget.inputFormatters,
                  keyboardType: widget.keyboardType,
                  controller: controller,
                  focusNode: focusNode,
                  obscureText: widget.obscureText,
                  onChanged: widget.onChanged,
                  onFieldSubmitted: widget.onSubmitted,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: widget.hint,
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.6,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface,
                    height: 1.6,
                  ),
                ),
              ),

              if (widget.trailingIconPresent && widget.trailingIcon != null) ...[
                const SizedBox(width: 8),
                widget.trailingIcon!,
              ],
            ],
          ),
        ),

        if (widget.helperPresent) const SizedBox(height: 6),

        if (widget.helperPresent)
          Text(
            widget.helper,
            style: theme.textTheme.bodySmall?.copyWith(
              color: widget.error ? colors.error : colors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
      ],
    );
  }
}