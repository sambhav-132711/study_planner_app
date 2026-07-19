import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../l10n/app_localizations.dart';

class SubmissionsScreen extends StatefulWidget {

  const SubmissionsScreen({super.key});

  @override
  State<SubmissionsScreen> createState() =>
      _SubmissionsScreenState();
}

class _SubmissionsScreenState
    extends State<SubmissionsScreen> {

  final submissionsBox =
      Hive.box("submissionsBox");

  final subjectsBox =
      Hive.box("subjectsBox");

  final TextEditingController
      titleController =
      TextEditingController();

  String? selectedSubject;

  String? selectedType;

  DateTime selectedDate =
      DateTime.now();

  /// ADD
  void addSubmission() {

    final lang =
        AppLocalizations.of(context);

    if (titleController.text.isEmpty ||
        selectedSubject == null ||
        selectedType == null) {

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

    submissionsBox.add({

      "title":
          titleController.text,

      "subject":
          selectedSubject,

      "type":
          selectedType,

      "date":
          selectedDate.toString(),

      "completed":
          false,
    });

    titleController.clear();

    selectedSubject = null;

    selectedType = null;

    setState(() {});
  }

  /// DELETE
  void deleteSubmission(
      int index) {

    submissionsBox.deleteAt(index);

    setState(() {});
  }

  /// TOGGLE
  void toggleSubmission(
      int index) {

    var submission =
        submissionsBox.getAt(index);

    submissionsBox.putAt(index, {

      "title":
          submission["title"],

      "subject":
          submission["subject"],

      "type":
          submission["type"],

      "date":
          submission["date"],

      "completed":
          !submission["completed"],
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
                titleController,

            decoration:
                InputDecoration(

              labelText:
                  lang.translate(
                      'submission_title'),

              border:
                  const OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          /// SUBJECT
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

          /// TYPE
          DropdownButtonFormField<String>(

            value:
                selectedType,

            decoration:
                InputDecoration(

              labelText:
                  lang.translate(
                      'submission_type'),

              border:
                  const OutlineInputBorder(),
            ),

            items: [

              "assignment",
              "project",
              "exam",
              "lab",
              "seminar",

            ].map((type) {

              return DropdownMenuItem(

                value: type,

                child: Text(

                  lang.translate(type),
                ),
              );

            }).toList(),

            onChanged:
                (value) {

              setState(() {

                selectedType =
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

          /// ADD
          SizedBox(

            width:
                double.infinity,

            child: ElevatedButton(

              onPressed:
                  addSubmission,

              child: Text(

                lang.translate(
                    'add'),
              ),
            ),
          ),

          const SizedBox(height: 15),

          /// LIST
          Expanded(

            child:
                submissionsBox.isEmpty

                    ? Center(

                        child: Text(

                          lang.translate(
                              'no_submissions'),
                        ),
                      )

                    : ListView.builder(

                        itemCount:
                            submissionsBox.length,

                        itemBuilder:
                            (context,
                                index) {

                          var submission =
                              submissionsBox
                                  .getAt(index);

                          DateTime date =
                              DateTime.parse(
                                  submission["date"]);

                          return Card(

                            child: ListTile(

                              leading:
                                  Checkbox(

                                value:
                                    submission["completed"] ??
                                        false,

                                onChanged:
                                    (value) {

                                  toggleSubmission(
                                      index);
                                },
                              ),

                              title: Text(

                                submission["title"],

                                style:
                                    TextStyle(

                                  decoration:
                                      submission["completed"] ==
                                              true

                                          ? TextDecoration
                                              .lineThrough

                                          : null,
                                ),
                              ),

                              subtitle: Text(

                                "${lang.translate(submission["subject"])} | ${lang.translate(submission["type"])}\n${date.toLocal().toString().split(' ')[0]}",
                              ),

                              trailing:
                                  IconButton(

                                icon:
                                    const Icon(
                                        Icons.delete),

                                onPressed:
                                    () {

                                  deleteSubmission(
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