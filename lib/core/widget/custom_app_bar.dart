import 'package:flutter/material.dart';
import 'package:flutter_template/core/utils/extension/context_extension.dart';
import 'package:flutter_template/core/widget/custom_back_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final bool? centerTitle;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.actions,
    this.titleWidget,
    this.centerTitle,
    this.leading,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: titleWidget ??
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
      centerTitle: centerTitle ?? true,
      titleSpacing: 0,
      actions: actions,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 70,
      leading: Navigator.of(context).canPop()
          ? Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: leading ?? const CustomBackButton(),
              ),
            )
          : null,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
