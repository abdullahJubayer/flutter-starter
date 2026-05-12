import 'package:flutter/material.dart';
import 'package:flutter_template/core/app/my_app.dart';
import 'package:flutter_template/core/theme/app_colors_extension.dart';
import 'package:flutter_template/core/widget/custom_card.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static final FToast _fToast = FToast();

  static void init() {
    _fToast.init(appRouter.navigatorKey.currentContext!);
  }

  static void clear() {
    _fToast.removeCustomToast();
  }

  static void success({String? title, required String msg}) {
    final toast = CustomCard(
      backgroundColor: Colors.green,
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          const Icon(Icons.done, size: 40, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "Success",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  msg,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    _showToast(toast);
  }

  static void error({String? title, required String msg}) {
    final toast = CustomCard(
      backgroundColor: Colors.red,
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          const Icon(Icons.error, size: 40, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "Error",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  msg,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    _showToast(toast);
  }

  static void warning({String? title, required String msg}) {
    final toast = CustomCard(
      backgroundColor: AppColorsExtension.light.error,
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          const Icon(Icons.warning, size: 40, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "Warning",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  msg,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    _showToast(toast);
  }

  static void _showToast(Widget widget) {
    if (_fToast.context == null) return;
    _fToast.showToast(
      child: widget,
      gravity: ToastGravity.SNACKBAR,
      toastDuration: const Duration(seconds: 3),
      positionedToastBuilder: (context, child, gravity) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        double safeBottom = keyboardHeight > 0 ? keyboardHeight + 16 : 32;
        return Positioned(
          bottom: safeBottom,
          left: 16,
          right: 16,
          child: child,
        );
      },
    );
  }
}
