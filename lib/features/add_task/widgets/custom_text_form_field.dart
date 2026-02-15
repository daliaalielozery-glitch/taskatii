import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final int? maxLines;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final bool readOnly;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    super.key,
    this.controller,
    required this.hintText,
    this.maxLines,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      controller: widget.controller,
      validator: widget.validator,
      onTapUpOutside: (v) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        suffixIcon: null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo),
        ),
        hint: Text(widget.hintText),
        border: OutlineInputBorder(),
      ),
    );
  }
}
