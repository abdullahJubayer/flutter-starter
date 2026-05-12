import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/app_colors_context_extension.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({
    super.key,
    this.controller,
  });

  final TextEditingController? controller;

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        setState(() {});
      },
      controller: widget.controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: 'What are you going to find?',
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        suffixIcon: _focusNode.hasFocus
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _focusNode.unfocus();
                  widget.controller?.clear();
                },
                child: const Icon(Icons.close),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: context.appColors.primary,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: context.appColors.border,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: context.appColors.primary,
            width: 1,
          ),
        ),
      ),
    );
  }
}
