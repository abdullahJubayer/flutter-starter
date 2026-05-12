import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/app_colors_context_extension.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.child,
    this.label,
    required this.isSelected,
    this.onTap,
  });

  final Widget child;
  final String? label;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme(
              data: IconThemeData(
                color: isSelected ? context.appColors.primary : context.appColors.neutralPalette.shade900,
              ),
              child: child,
            ),
            if (label != null) const SizedBox(height: 4),
            if (label != null)
              Text(
                label!,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? context.appColors.primary : context.appColors.neutralPalette.shade900,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
