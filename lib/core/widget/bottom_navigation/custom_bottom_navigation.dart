import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/app_colors_context_extension.dart';
import 'package:flutter_template/core/widget/bottom_navigation/navigation_item.dart';
import 'package:flutter_template/core/widget/custom_card.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key, this.onTap, required this.index});

  final void Function(int)? onTap;
  final int index;

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      color: context.appColors.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavigationItem(
            label: 'History',
            isSelected: widget.index == 0,
            onTap: () => widget.onTap?.call(0),
            child: const Icon(Icons.history),
          ),
          NavigationItem(
            label: 'Member',
            isSelected: widget.index == 1,
            onTap: () => widget.onTap?.call(1),
            child: const Icon(Icons.group),
          ),
          NavigationItem(
            isSelected: widget.index == 2,
            onTap: () => widget.onTap?.call(2),
            child: CustomCard(
              backgroundColor: context.appColors.primary.withValues(alpha: .1),
              padding: EdgeInsets.all(12),
              child: const Icon(Icons.home, size: 32),
            ),
          ),
          NavigationItem(
            label: 'Meeting',
            isSelected: widget.index == 3,
            onTap: () => widget.onTap?.call(3),
            child: const Icon(Icons.handshake),
          ),
          NavigationItem(
            label: 'Menu',
            isSelected: widget.index == 4,
            onTap: () => widget.onTap?.call(4),
            child: const Icon(Icons.menu),
          ),
        ],
      ),
    );
  }
}
