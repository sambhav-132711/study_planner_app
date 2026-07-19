import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../l10n/app_localizations.dart';

class SubjectsScreen extends StatefulWidget {

  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() =>
      _SubjectsScreenState();
}

class _SubjectsScreenState
    extends State<SubjectsScreen> {

  final subjectsBox =
      Hive.box("subjectsBox");

  final TextEditingController
      subjectController =
      TextEditingController();

  /// DEFAULT SUBJECTS
  final List<String> defaultSubjects = [

    "maths",
    "physics",
    "chemistry",
    "biology",
    "english",
    "computer",
  ];

  /// ADD SUBJECT
  void addSubject() {

    final lang =
        AppLocalizations.of(context);

    String subject =
        subjectController.text.trim();

    if (subject.isEmpty) {

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

    /// PREVENT DUPLICATES
    bool exists =
        subjectsBox.values.any(

      (item) =>

          item.toString()
              .toLowerCase() ==

          subject.toLowerCase(),
    );

    if (exists) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(

            lang.translate(
                'subject_exists'),
          ),
        ),
      );

      return;
    }

    subjectsBox.add(subject);

    subjectController.clear();

    setState(() {});
  }

  /// ADD DEFAULT SUBJECT
  void addDefaultSubject(
      String subject) {

    bool exists =
        subjectsBox.values
            .contains(subject);

    if (!exists) {

      subjectsBox.add(subject);

      setState(() {});
    }
  }

  /// DELETE SUBJECT
  void deleteSubject(int index) {

    subjectsBox.deleteAt(index);

    setState(() {});
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

          /// CUSTOM SUBJECT INPUT
          Row(

            children: [

              Expanded(

                child: TextField(

                  controller:
                      subjectController,

                  decoration:
                      InputDecoration(

                    hintText:
                        lang.translate(
                            'subjects'),

                    border:
                        const OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              ElevatedButton(

                onPressed:
                    addSubject,

                child: Text(

                  lang.translate(
                      'add'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// DEFAULT SUBJECTS
          Align(

            alignment:
                Alignment.centerLeft,

            child: Text(

              "Quick Add",

              style: const TextStyle(

                fontSize: 18,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Wrap(

            spacing: 8,

            runSpacing: 8,

            children:
                defaultSubjects.map((subject) {

              return ActionChip(

                label: Text(

                  lang.translate(
                      subject),
                ),

                onPressed: () {

                  addDefaultSubject(
                      subject);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          /// SUBJECT LIST
          Expanded(

            child:
                subjectsBox.isEmpty

                    ? Center(

                        child: Text(

                          lang.translate(
                              'no_subjects'),
                        ),
                      )

                    : ListView.builder(

                        itemCount:
                            subjectsBox.length,

                        itemBuilder:
                            (context, index) {

                          String subject =
                              subjectsBox.getAt(index);

                          /// TRANSLATE DEFAULT SUBJECTS
                          bool isDefault =
                              defaultSubjects
                                  .contains(subject);

                          return Card(

                            child: ListTile(

                              leading:
                                  const Icon(
                                      Icons.menu_book),

                              title: Text(

                                isDefault

                                    ? lang.translate(
                                        subject)

                                    : subject,
                              ),

                              trailing:
                                  IconButton(

                                icon:
                                    const Icon(
                                        Icons.delete),

                                onPressed:
                                    () {

                                  deleteSubject(
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