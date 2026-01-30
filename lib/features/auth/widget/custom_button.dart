import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btn_text;
  final void Function()? onPressed;

  const CustomButton({super.key, required this.btn_text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.indigo),
      ),
      onPressed: onPressed,
      child: Text(btn_text, style: TextStyle(color: Colors.white)),
    );
  }
}
