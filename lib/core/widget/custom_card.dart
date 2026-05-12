import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.borderRadius = 15.0,
    required this.child,
    this.onTap,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.margin,
    this.borderWidth,
    this.gradient,
    this.elevation = 0,
  });

  final Widget child;
  final double borderRadius;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double elevation;
  final double? borderWidth;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? EdgeInsets.zero,
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      color: gradient == null ? backgroundColor : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(borderRadius),
        side: borderWidth != null
            ? BorderSide(
                width: borderWidth!,
                color: borderColor ??
                    Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.4),
              )
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: DecoratedBox(
            decoration: BoxDecoration(gradient: gradient),
            child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
          ),
        ),
      ),
    );
  }
}
