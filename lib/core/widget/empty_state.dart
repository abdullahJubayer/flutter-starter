import 'package:flutter/material.dart';
import 'package:flutter_template/core/utils/extension/context_extension.dart';
import 'package:flutter_template/gen/assets.gen.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.icon,
    this.title,
    this.desc,
    this.buttonText,
    this.onButtonPressed,
    this.iconHeight,
    this.centerVertically = true,
  });

  final Widget? icon;
  final String? title;
  final String? desc;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final double? iconHeight;
  final bool centerVertically;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon / illustration
        icon ?? Assets.logo.launcherIcon.image(height: iconHeight ?? 140),
        const SizedBox(height: 20),

        // Title
        Text(
          title ?? 'No Data Found!',
          style: theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),

        // Description (optional)
        if (desc != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              desc!,
              style: theme.textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),

        // CTA button (optional)
        if (buttonText != null && onButtonPressed != null) ...[
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(buttonText!),
          ),
        ],
      ],
    );

    if (centerVertically) {
      return Center(child: content);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: content,
    );
  }
}
