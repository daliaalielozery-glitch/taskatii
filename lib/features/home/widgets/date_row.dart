import 'package:flutter/material.dart';
import 'package:to_do_list/features/home/widgets/date_box.dart';

class DateRow extends StatelessWidget {
  const DateRow({super.key});

  @override
  Widget build(BuildContext context) {
    return
    /// DATE SELECTOR
    SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          DateBox(day: "30", label: "MON", month: 'OCT', isSelected: true),
          DateBox(day: "31", label: "TUE", month: 'OCT'),
          DateBox(day: "1", label: "WED", month: 'NOV'),
          DateBox(day: "2", label: "THU", month: 'NOV'),
          DateBox(day: "3", label: "FRI", month: 'NOV'),
          DateBox(day: "4", label: "SAT", month: 'NOV'),
          DateBox(day: "5", label: "SUN", month: 'NOV'),
        ],
      ),
    );
  }
}
