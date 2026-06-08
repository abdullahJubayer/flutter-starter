import 'package:flutter/material.dart';

class AuthInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;

  const AuthInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.suffixIcon = false,
    this.isDense,
    this.obscureText = false,
    this.controller,
    this.onSaved,
    this.onChanged,
    this.keyboardType,
  });

  @override
  State<AuthInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<AuthInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 3),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.labelText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: (widget.obscureText && _obscureText),
            style: TextStyle(color: colorScheme.onSurface),
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.error),
              ),
              isDense: (widget.isDense != null) ? widget.isDense : false,
              hint: Text(
                widget.hintText,
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
              suffixIcon: widget.suffixIcon
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.remove_red_eye
                            : Icons.visibility_off_outlined,
                        color: colorScheme.onSurface,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              suffixIconConstraints: (widget.isDense != null)
                  ? const BoxConstraints(maxHeight: 33)
                  : null,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
            onSaved: widget.onSaved,
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}
