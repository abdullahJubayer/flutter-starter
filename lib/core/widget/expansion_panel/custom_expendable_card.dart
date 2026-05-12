import 'package:flutter/material.dart';
import 'package:flutter_template/core/widget/custom_card.dart';
import 'package:flutter_template/core/widget/expansion_panel/custom_expansion_panel.dart';

class CustomExpendableCard extends StatelessWidget {
  const CustomExpendableCard({
    super.key,
    required this.header,
    required this.body,
    required this.isExpanded,
    this.onExpanded,
    this.margin,
  });

  final Widget header;
  final Widget body;
  final EdgeInsetsGeometry? margin;
  final bool isExpanded;
  final Function(bool)? onExpanded;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      elevation: 0,
      margin: margin ?? const EdgeInsets.all(0),
      child: AppExpansionPanelList(
        animationDuration: const Duration(milliseconds: 500),
        expansionCallback: (panelIndex, isExpanded) {
          if (onExpanded != null) onExpanded!.call(!isExpanded);
        },
        elevation: 0,
        expandedHeaderPadding: const EdgeInsets.all(0),
        children: [
          ExpansionPanel(
            isExpanded: isExpanded,
            canTapOnHeader: onExpanded != null,
            headerBuilder: (context, isExpanded) => header,
            body: body,
          )
        ],
      ),
    );
  }
}
