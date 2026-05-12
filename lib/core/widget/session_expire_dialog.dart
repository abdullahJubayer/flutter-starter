import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/app_colors_context_extension.dart';
import 'package:flutter_template/core/utils/extension/context_extension.dart';
import 'package:flutter_template/core/widget/custom_card.dart';
import 'package:flutter_template/core/widget/custom_dialog.dart';

class SessionExpireDialog extends StatelessWidget {
  const SessionExpireDialog({super.key, this.onConfirm});

  final void Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return CustomDialog(
      showCloseIcon: false,
      padding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              color: context.appColors.primary,
              child: Center(
                child: CustomCard(
                  borderWidth: 4,
                  backgroundColor: context.appColors.primary,
                  borderColor: Colors.white.withValues(alpha: 0.4),
                  padding: const EdgeInsets.all(16),
                  borderRadius: 50,
                  child: const Icon(
                    Icons.schedule,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Session Expired',
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your session has expired. Please login again.',
                    style: theme.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: onConfirm,
                child: const Text('OK'),
              ),
            )
          ],
        ),
      ),
    );
  }
}



