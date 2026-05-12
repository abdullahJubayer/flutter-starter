import 'package:flutter/material.dart';

class InfoDetailsItem extends StatelessWidget {
  const InfoDetailsItem({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: theme.dividerColor),
            SizedBox(width: 8),
          ],
          Expanded(
            child: RichText(
              text: TextSpan(
                text: label,
                style: theme.textTheme.titleSmall,
                children: [
                  TextSpan(text: ' :  '),
                  TextSpan(
                    text: value,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
