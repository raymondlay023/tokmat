import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isPasswordField;
  final String? hintText;
  final String? labelText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? icon;

  const CustomTextFormField(
      {super.key,
      this.controller,
      this.isPasswordField = false,
      this.hintText,
      this.labelText,
      this.onChanged,
      this.keyboardType,
      this.prefixIcon,
      this.icon});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.isPasswordField ? _obsecureText : false,
      decoration: InputDecoration(
        icon: widget.icon,
        prefixIcon: widget.prefixIcon,
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
