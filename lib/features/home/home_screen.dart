import 'package:flutter/material.dart';
import 'package:to_do_list/features/home/widgets/date_box.dart';
import 'package:to_do_list/features/home/widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hello, Dalia",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Have A Nice Day.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.pinkAccent,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// DATE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "October 30, 2023",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Today",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  /// ADD TASK BUTTON
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5B67F1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        style: TextStyle(color: Colors.white),
                        "+ Add Task",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              /// DATE SELECTOR
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    DateBox(
                      day: "30",
                      label: "MON",
                      month: 'OCT',
                      isSelected: true,
                    ),
                    DateBox(day: "31", label: "TUE", month: 'OCT'),
                    DateBox(day: "1", label: "WED", month: 'NOV'),
                    DateBox(day: "2", label: "THU", month: 'NOV'),
                    DateBox(day: "3", label: "FRI", month: 'NOV'),
                    DateBox(day: "4", label: "SAT", month: 'NOV'),
                    DateBox(day: "5", label: "SUN", month: 'NOV'),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// TASK LIST
              Expanded(
                child: ListView(
                  children: [
                    Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        alignment: AlignmentGeometry.centerLeft,
                        color: Colors.red,
                        child: Icon(Icons.delete),
                      ),
                      secondaryBackground: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        alignment: AlignmentGeometry.centerRight,
                        color: Colors.green,
                        child: Icon(Icons.done),
                      ),
                      child: TaskCard(
                        color: Color(0xff5B67F1),
                        title: "Flutter Task - 1",
                        time: "02:25 AM - 02:40 AM",
                      ),
                    ),
                    TaskCard(
                      color: Color(0xffFF5C7C),
                      title: "Flutter Task - 2",
                      time: "4:27 PM - 6:42 PM",
                    ),
                    TaskCard(
                      color: Color(0xffFFB47E),
                      title: "Flutter Task - 3",
                      time: "7:27 PM - 9:43 PM",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
