import 'package:flutter/material.dart';
import 'package:flutter_template/core/utils/enum/button_type.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.isLoading = false,
    this.isDisable = false,
    this.onPressed,
    this.label,
    this.child,
    this.type = ButtonType.fill,
  }) : height = 45;

  const CustomButton.small({
    super.key,
    this.isLoading = false,
    this.isDisable = false,
    this.onPressed,
    this.label,
    this.child,
    this.type = ButtonType.fill,
  }) : height = 35;

  final bool isLoading;
  final bool isDisable;
  final void Function()? onPressed;
  final String? label;
  final Widget? child;
  final ButtonType type;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: type == ButtonType.outlined
          ? ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.grey),
            )
          : null,
      onPressed: isDisable
          ? null
          : isLoading
              ? null
              : onPressed,
      child: SizedBox(
        height: height,
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : Center(
                child: child ??
                    Text(
                      label ?? '',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: type == ButtonType.outlined
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
              ),
      ),
    );
  }
}
