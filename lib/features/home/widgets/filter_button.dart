import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  FilterButton({
    super.key,
    required this.title,
    this.isactive = false,
    this.onTap,
  });
  final String title;
  final bool isactive;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isactive ? Colors.pinkAccent : Colors.transparent,
              border: Border.all(color: Colors.purple),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: isactive ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
