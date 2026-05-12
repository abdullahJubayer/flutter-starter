import 'package:flutter/material.dart';
import 'package:flutter_template/core/utils/extension/context_extension.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
    this.title,
    required this.content,
    this.padding,
    this.titleColor,
    this.titleBackground,
    this.showCloseIcon = true,
    this.onClose,
  });

  final Widget content;
  final EdgeInsetsGeometry? padding;
  final String? title;
  final Color? titleColor;
  final Color? titleBackground;
  final bool showCloseIcon;
  final VoidCallback? onClose;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.title != null)
              Container(
                height: 45,
                color: widget.titleBackground,
                child: Row(
                  children: [
                    if (widget.showCloseIcon) const SizedBox(width: 40),
                    Expanded(
                      child: Text(
                        widget.title ?? '',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: widget.titleColor,
                        ),
                      ),
                    ),
                    if (widget.showCloseIcon)
                      SizedBox(
                        width: 40,
                        child: IconButton(
                          onPressed: widget.onClose ??
                              () {
                                Navigator.pop(context);
                              },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                  ],
                ),
              ),
            if (widget.title != null)
              const Divider(
                thickness: 1,
                height: 1,
                endIndent: 10,
                indent: 10,
                color: Colors.black12,
              ),
            Flexible(
              child: Container(
                padding: widget.padding ?? const EdgeInsets.all(16),
                child: widget.content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
