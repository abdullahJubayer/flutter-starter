import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/app_colors_context_extension.dart';
import 'package:flutter_template/core/utils/extension/context_extension.dart';
import 'package:flutter_template/core/widget/custom_card.dart';
import 'package:flutter_template/core/widget/custom_dialog.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key, this.onLogout});

  final void Function()? onLogout;

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
                      Icons.logout,
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
                      'Are you sure?',
                      style: theme.textTheme.bodySmall?.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Do you want to logout',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                margin: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: const ButtonStyle().copyWith(
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.red),
                        ),
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onLogout,
                        child: const Text('Yes'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
