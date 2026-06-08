import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/app_colors_context_extension.dart';
import 'package:flutter_template/core/widget/custom_card.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;

  const CustomBackButton({
    super.key,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap ?? () => context.router.maybePop(),
      padding: const EdgeInsets.fromLTRB(0, 10, 6, 10),
      child: Icon(
        Icons.arrow_back,
        color: iconColor ?? Colors.black,
      ),
    );
  }
}
