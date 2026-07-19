import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../l10n/app_localizations.dart';

class TasksScreen extends StatefulWidget {

  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() =>
      _TasksScreenState();
}

class _TasksScreenState
    extends State<TasksScreen> {

  final taskBox =
      Hive.box("tasksBox");

  final subjectsBox =
      Hive.box("subjectsBox");

  final TextEditingController
      taskController =
      TextEditingController();

  String? selectedSubject;

  DateTime selectedDate =
      DateTime.now();

  /// ADD TASK
  void addTask() {

    final lang =
        AppLocalizations.of(context);

    if (taskController.text.isEmpty ||
        selectedSubject == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(

            lang.translate(
                'fill_fields'),
          ),
        ),
      );

      return;
    }

    taskBox.add({

      "title":
          taskController.text,

      "subject":
          selectedSubject,

      "date":
          selectedDate.toString(),

      "completed":
          false,
    });

    taskController.clear();

    selectedSubject = null;

    setState(() {});
  }

  /// DELETE TASK
  void deleteTask(int index) {

    taskBox.deleteAt(index);

    setState(() {});
  }

  /// TOGGLE TASK
  void toggleTask(int index) {

    var task =
        taskBox.getAt(index);

    taskBox.putAt(index, {

      "title":
          task["title"],

      "subject":
          task["subject"],

      "date":
          task["date"],

      "completed":
          !task["completed"],
    });

    setState(() {});
  }

  /// PICK DATE
  Future pickDate() async {

    DateTime? pickedDate =
        await showDatePicker(

      context: context,

      initialDate:
          selectedDate,

      firstDate:
          DateTime(2020),

      lastDate:
          DateTime(2035),
    );

    if (pickedDate != null) {

      setState(() {

        selectedDate =
            pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final lang =
        AppLocalizations.of(context);

    return Padding(

      padding:
          const EdgeInsets.all(12),

      child: Column(

        children: [

          /// TITLE
          TextField(

            controller:
                taskController,

            decoration:
                InputDecoration(

              labelText:
                  lang.translate(
                      'task_title'),

              border:
                  const OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          /// SUBJECTS
          subjectsBox.isEmpty

              ? Text(

                  "⚠ ${lang.translate('subjects')} first",
                )

              : DropdownButtonFormField<String>(

                  value:
                      selectedSubject,

                  decoration:
                      InputDecoration(

                    labelText:
                        lang.translate(
                            'select_subject'),

                    border:
                        const OutlineInputBorder(),
                  ),

                  items:
                      subjectsBox.values.map<
                          DropdownMenuItem<String>>(

                    (subject) {

                      return DropdownMenuItem(

                        value: subject,

                        child: Text(

                          lang.translate(
                              subject),
                        ),
                      );
                    },
                  ).toList(),

                  onChanged:
                      (value) {

                    setState(() {

                      selectedSubject =
                          value!;
                    });
                  },
                ),

          const SizedBox(height: 12),

          /// DATE
          Row(

            children: [

              Expanded(

                child: Text(

                  "${lang.translate('date')} : ${selectedDate.toLocal().toString().split(' ')[0]}",
                ),
              ),

              ElevatedButton(

                onPressed:
                    pickDate,

                child: Text(

                  lang.translate(
                      'pick_date'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// ADD BUTTON
          SizedBox(

            width:
                double.infinity,

            child: ElevatedButton(

              onPressed:
                  addTask,

              child: Text(

                lang.translate(
                    'add'),
              ),
            ),
          ),

          const SizedBox(height: 15),

          /// TASK LIST
          Expanded(

            child:
                taskBox.isEmpty

                    ? Center(

                        child: Text(

                          lang.translate(
                              'no_tasks'),
                        ),
                      )

                    : ListView.builder(

                        itemCount:
                            taskBox.length,

                        itemBuilder:
                            (context,
                                index) {

                          var task =
                              taskBox.getAt(index);

                          DateTime taskDate =
                              DateTime.parse(
                                  task["date"]);

                          return Card(

                            child: ListTile(

                              leading:
                                  Checkbox(

                                value:
                                    task["completed"] ??
                                        false,

                                onChanged:
                                    (value) {

                                  toggleTask(
                                      index);
                                },
                              ),

                              title: Text(

                                task["title"],

                                style:
                                    TextStyle(

                                  decoration:
                                      task["completed"] ==
                                              true

                                          ? TextDecoration
                                              .lineThrough

                                          : null,
                                ),
                              ),

                              subtitle: Text(

                                "${lang.translate(task["subject"])}\n${taskDate.toLocal().toString().split(' ')[0]}",
                              ),

                              trailing:
                                  IconButton(

                                icon:
                                    const Icon(
                                        Icons.delete),

                                onPressed:
                                    () {

                                  deleteTask(
                                      index);
                                },
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}