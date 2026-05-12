import 'package:flutter/material.dart';
import 'package:flutter_template/core/utils/extension/context_extension.dart';
import 'package:flutter_template/core/widget/custom_dialog.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    this.onConfirm,
    required this.content,
    this.title,
  });

  final void Function()? onConfirm;
  final String content;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return CustomDialog(
      title: title ?? 'Confirmation',
      content: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(content, style: theme.textTheme.titleMedium),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: const ButtonStyle().copyWith(
                      backgroundColor: const WidgetStatePropertyAll(Colors.red),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
