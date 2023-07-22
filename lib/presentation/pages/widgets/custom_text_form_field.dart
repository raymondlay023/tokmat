import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isPasswordField;
  final String? hintText;
  final String? labelText;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.isPasswordField = false,
    this.hintText,
    this.labelText,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      controller: widget.controller,
      obscureText: widget.isPasswordField ? _obsecureText : false,
      decoration: InputDecoration(
        label: Text('${widget.labelText}'),
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => _obsecureText = !_obsecureText),
          child: widget.isPasswordField == true
              ? Icon(_obsecureText ? Icons.visibility_off : Icons.visibility)
              : const Text(""),
        ),
      ),
    );
  }
}
