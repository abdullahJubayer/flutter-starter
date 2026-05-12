import 'package:flutter/material.dart';

enum ToastType {
  success(
    color: Colors.green,
    icon: Icons.done,
    defaultTitle: 'Success',
  ),
  error(
    color: Colors.red,
    icon: Icons.error,
    defaultTitle: 'Error',
  ),
  warning(
    color: Colors.amber,
    icon: Icons.warning,
    defaultTitle: 'Warning',
  );

  const ToastType({
    required this.color,
    required this.icon,
    required this.defaultTitle,
  });

  final IconData icon;
  final Color color;
  final String defaultTitle;
}
