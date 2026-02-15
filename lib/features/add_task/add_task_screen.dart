import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/features/add_task/widgets/custom_text_form_field.dart';
import 'package:to_do_list/features/auth/widget/custom_button.dart';
import 'package:to_do_list/features/home/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Color> taskColors = [
    Colors.indigoAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.purpleAccent,
  ];

  // Controllers
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.indigo),
        title: const Text(
          "Add Task",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 5,
              children: [
                // Title
                CustomTextFormField(
                  controller: titleController,
                  hintText: "Task Title",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter task title";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Description
                CustomTextFormField(
                  controller: descriptionController,
                  hintText: "Task Description",
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Task Description";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Date
                CustomTextFormField(
                  controller: dateController,
                  hintText: "Enter Task Date",
                  readOnly: true,
                  suffixIcon: const Icon(
                    Icons.date_range_sharp,
                    color: Colors.indigo,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Task Date";
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2027),
                      initialDate: DateTime.now(),
                    );

                    setState(() {
                      if (pickedDate != null) {
                        dateController.text = DateFormat(
                          'yyyy-MM-dd',
                        ).format(pickedDate);
                      } else if (dateController.text.isEmpty) {
                        dateController.text = DateFormat(
                          'yyyy-MM-dd',
                        ).format(DateTime.now());
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Start & End Time
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: startTimeController,
                        hintText: "Start Time",
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter task Start Time";
                          }
                          return null;
                        },
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            final now = DateTime.now();
                            final dt = DateTime(
                              now.year,
                              now.month,
                              now.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                            setState(() {
                              startTimeController.text = DateFormat(
                                'hh:mm a',
                              ).format(dt);
                            });
                          } else if (startTimeController.text.isEmpty) {
                            startTimeController.text = DateFormat(
                              'hh:mm a',
                            ).format(DateTime.now());
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextFormField(
                        controller: endTimeController,
                        hintText: "End Time",
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter task End Time";
                          }

                          // Compare Start and End times
                          final format = DateFormat('hh:mm a');
                          final start = format.parse(startTimeController.text);
                          final end = format.parse(value);
                          if (!end.isAfter(start)) {
                            return "End Time must be after Start Time";
                          }

                          return null;
                        },
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            final now = DateTime.now();
                            final dt = DateTime(
                              now.year,
                              now.month,
                              now.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                            setState(() {
                              endTimeController.text = DateFormat(
                                'hh:mm a',
                              ).format(dt);
                            });
                          } else if (endTimeController.text.isEmpty) {
                            endTimeController.text = DateFormat(
                              'hh:mm a',
                            ).format(DateTime.now());
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Task color selection
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: taskColors.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: taskColors[index],
                        child: activeIndex == index
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                  ),
                ),
                const SizedBox(height: 10),

                // Create Task button
                CustomButton(
                  btn_text: "Create Task",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Add the task to the list
                      allTasks.add(
                        TaskModel(
                          title: titleController.text,
                          description: descriptionController.text,
                          color: taskColors[activeIndex],
                          startTime: startTimeController.text,
                          endTime: endTimeController.text,
                          stausText: "TODO",
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Task added successfully!"),
                        ),
                      );

                      // Pop back to previous screen
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
