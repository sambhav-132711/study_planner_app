import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';

import '../l10n/app_localizations.dart';

class CalendarScreen extends StatefulWidget {

  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() =>
      _CalendarScreenState();
}

class _CalendarScreenState
    extends State<CalendarScreen> {

  DateTime selectedDay =
      DateTime.now();

  final taskBox =
      Hive.box("tasksBox");

  final submissionsBox =
      Hive.box("submissionsBox");

  /// TASKS FOR DATE
  List getTasksForDate(
      DateTime date) {

    return taskBox.values.where((task) {

      if (task["date"] == null)
        return false;

      DateTime taskDate =
          DateTime.parse(
              task["date"]);

      return taskDate.year ==
                  date.year &&
              taskDate.month ==
                  date.month &&
              taskDate.day ==
                  date.day &&
              task["completed"] !=
                  true;

    }).toList();
  }

  /// SUBMISSIONS FOR DATE
  List getSubmissionsForDate(
      DateTime date) {

    return submissionsBox.values
        .where((submission) {

      if (submission["date"] ==
          null) {
        return false;
      }

      DateTime submissionDate =
          DateTime.parse(
              submission["date"]);

      return submissionDate.year ==
                  date.year &&
              submissionDate.month ==
                  date.month &&
              submissionDate.day ==
                  date.day &&
              submission["completed"] !=
                  true;

    }).toList();
  }

  /// EVENT HIGHLIGHT
  bool hasEvents(DateTime day) {

    return getTasksForDate(day)
                .isNotEmpty ||

            getSubmissionsForDate(
                    day)
                .isNotEmpty;
  }

  @override
  Widget build(
      BuildContext context) {

    final lang =
        AppLocalizations.of(
            context);

    List selectedTasks =
        getTasksForDate(
            selectedDay);

    List selectedSubmissions =
        getSubmissionsForDate(
            selectedDay);

    bool isDark =
        Theme.of(context)
                .brightness ==

            Brightness.dark;

    return Column(

      children: [

        /// CALENDAR
        TableCalendar(

          focusedDay:
              selectedDay,

          firstDay:
              DateTime(2020),

          lastDay:
              DateTime(2035),

          selectedDayPredicate:
              (day) {

            return isSameDay(
                selectedDay,
                day);
          },

          onDaySelected:
              (selected,
                  focused) {

            setState(() {

              selectedDay =
                  selected;
            });
          },

          /// HIGHLIGHT
          calendarBuilders:
              CalendarBuilders(

            defaultBuilder:
                (context,
                    day,
                    focusedDay) {

              bool eventExists =
                  hasEvents(day);

              return Container(

                margin:
                    const EdgeInsets
                        .all(6),

                decoration:
                    BoxDecoration(

                  color:
                      eventExists

                          ? Colors
                              .deepPurple
                              .withOpacity(
                                  0.25)

                          : Colors
                              .transparent,

                  shape:
                      BoxShape.circle,
                ),

                child: Center(

                  child: Text(

                    "${day.day}",

                    style:
                        TextStyle(

                      color:
                          isDark

                              ? Colors
                                  .white

                              : Colors
                                  .black,

                      fontWeight:
                          eventExists

                              ? FontWeight
                                  .bold

                              : FontWeight
                                  .normal,
                    ),
                  ),
                ),
              );
            },
          ),

          calendarStyle:
              CalendarStyle(

            todayDecoration:
                const BoxDecoration(

              color:
                  Colors.blue,

              shape:
                  BoxShape.circle,
            ),

            selectedDecoration:
                const BoxDecoration(

              color:
                  Colors.deepPurple,

              shape:
                  BoxShape.circle,
            ),
          ),
        ),

        const SizedBox(
            height: 15),

        /// TASK TITLE
        Text(

          lang.translate(
              'tasks'),

          style:
              const TextStyle(

            fontSize: 18,

            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(
            height: 8),

        /// TASK LIST
        selectedTasks.isEmpty

            ? Padding(

                padding:
                    const EdgeInsets
                        .all(8),

                child: Text(

                  lang.translate(
                      'no_tasks'),
                ),
              )

            : ListView.builder(

                shrinkWrap:
                    true,

                physics:
                    const NeverScrollableScrollPhysics(),

                itemCount:
                    selectedTasks
                        .length,

                itemBuilder:
                    (context,
                        index) {

                  var task =
                      selectedTasks[
                          index];

                  return Card(

                    child:
                        ListTile(

                      leading:
                          const Icon(

                        Icons
                            .task_alt,

                        color:
                            Colors
                                .blue,
                      ),

                      title: Text(

                        task["title"] ??
                            lang.translate(
                                'task_title'),
                      ),

                      subtitle:
                          Text(

                        lang.translate(
                            task["subject"]),
                      ),
                    ),
                  );
                },
              ),

        const SizedBox(
            height: 15),

        /// SUBMISSIONS TITLE
        Text(

          lang.translate(
              'submissions'),

          style:
              const TextStyle(

            fontSize: 18,

            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(
            height: 8),

        /// SUBMISSION LIST
        Expanded(

          child:
              selectedSubmissions
                      .isEmpty

                  ? Center(

                      child:
                          Text(

                        lang.translate(
                            'no_submissions'),
                      ),
                    )

                  : ListView.builder(

                      itemCount:
                          selectedSubmissions
                              .length,

                      itemBuilder:
                          (context,
                              index) {

                        var submission =
                            selectedSubmissions[
                                index];

                        return Card(

                          child:
                              ListTile(

                            leading:
                                const Icon(

                              Icons
                                  .assignment,

                              color:
                                  Colors
                                      .deepPurple,
                            ),

                            title:
                                Text(

                              submission[
                                  "title"],
                            ),

                            subtitle:
                                Text(

                              "${lang.translate(submission["subject"])} | ${lang.translate(submission["type"])}",
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}