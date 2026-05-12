import 'package:flutter/material.dart';
import 'package:flutter_template/core/widget/custom_card.dart';

class InfoDetailsCard extends StatelessWidget {
  const InfoDetailsCard({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
  });

  final String title;
  final IconData icon;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: CustomCard(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: theme.primaryColor.withValues(alpha: .1),
                  ),
                  child: Icon(icon, color: theme.primaryColor),
                ),
                SizedBox(width: 16),
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(color: Colors.black12, height: 24),
            ...items,
          ],
        ),
      ),
    );
  }
}
