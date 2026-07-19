import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/subject_progress_widget.dart';
import '../services/notification_service.dart';
import '../l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  final taskBox =
      Hive.box("tasksBox");

  final submissionsBox =
      Hive.box("submissionsBox");

  @override
  void initState() {

    super.initState();

    checkTodaySubmissions();
  }

  /// DAILY NOTIFICATIONS
  void checkTodaySubmissions() {

    DateTime today =
        DateTime.now();

    int notificationId = 0;

    for (var submission
        in submissionsBox.values) {

      if (submission["date"] == null)
        continue;

      DateTime submissionDate =
          DateTime.parse(
              submission["date"]);

      bool sameDate =

          submissionDate.year ==
                  today.year &&

              submissionDate.month ==
                  today.month &&

              submissionDate.day ==
                  today.day;

      if (sameDate &&
          submission["completed"] != true) {

        NotificationService
            .scheduleNotification(

          id: notificationId++,

          title:
              "Submission Due Today 📌",

          body:
              "${submission["title"]} (${submission["subject"]}) is due today!",
        );
      }
    }
  }

  /// SUBJECT PROGRESS
  double calculateProgress(
      String subject) {

    var subjectTasks =
        taskBox.values.where(

      (task) =>
          task["subject"] == subject,
    );

    if (subjectTasks.isEmpty)
      return 0;

    var completedTasks =
        subjectTasks.where(

      (task) =>
          task["completed"] == true,
    );

    return completedTasks.length /
        subjectTasks.length;
  }

  /// SUBJECTS
  List<String> getSubjects() {

    final subjectsBox =
        Hive.box("subjectsBox");

    return subjectsBox.values
        .cast<String>()
        .toList();
  }

  /// UPCOMING TASKS
  List getUpcomingTasks() {

    DateTime today =
        DateTime.now();

    List tasks =
        taskBox.values.where((task) {

      if (task["date"] == null)
        return false;

      DateTime taskDate =
          DateTime.parse(
              task["date"]);

      return taskDate.isAfter(

              today.subtract(
                const Duration(days: 1),
              ),
            ) &&
          task["completed"] != true;

    }).toList();

    tasks.sort((a, b) {

      DateTime dateA =
          DateTime.parse(a["date"]);

      DateTime dateB =
          DateTime.parse(b["date"]);

      return dateA.compareTo(dateB);
    });

    return tasks;
  }

  /// UPCOMING SUBMISSIONS
  List getUpcomingSubmissions() {

    DateTime today =
        DateTime.now();

    List submissions =
        submissionsBox.values.where((submission) {

      if (submission["date"] == null)
        return false;

      DateTime submissionDate =
          DateTime.parse(
              submission["date"]);

      return submissionDate.isAfter(

              today.subtract(
                const Duration(days: 1),
              ),
            ) &&
          submission["completed"] != true;

    }).toList();

    submissions.sort((a, b) {

      DateTime dateA =
          DateTime.parse(a["date"]);

      DateTime dateB =
          DateTime.parse(b["date"]);

      return dateA.compareTo(dateB);
    });

    return submissions;
  }

  /// COMPLETE TASK
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

  /// COMPLETE SUBMISSION
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

  /// FORMAT TIME
  String formatTime(
      int seconds) {

    int hrs = seconds ~/ 3600;

    int mins =
        (seconds % 3600) ~/ 60;

    int secs =
        seconds % 60;

    return "${hrs.toString().padLeft(2, '0')}:"
        "${mins.toString().padLeft(2, '0')}:"
        "${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {

    final lang =
        AppLocalizations.of(context);

    final studyBox =
        Hive.box("studyTimeBox");

    final user =
        FirebaseAuth.instance.currentUser;

    String userName =

        user?.displayName ??

            user?.email ??

            "Student";

    int totalTasks =
        taskBox.length;

    int completedTasks =
        taskBox.values
            .where((task) =>
                task["completed"] == true)
            .length;

    /// RESET DAILY
    String today =
        DateTime.now()
            .toString()
            .split(' ')[0];

    String? storedDate =
        studyBox.get("date");

    int studySeconds =
        studyBox.get(
          "seconds",
          defaultValue: 0,
        );

    if (storedDate != today) {

      studyBox.put(
          "seconds", 0);

      studyBox.put(
          "date", today);

      studySeconds = 0;
    }

    String studyTimeFormatted =
        formatTime(studySeconds);

    List upcomingTasks =
        getUpcomingTasks();

    List upcomingSubmissions =
        getUpcomingSubmissions();

    List<String> subjects =
        getSubjects();

    return Padding(

      padding:
          const EdgeInsets.all(20),

      child: ListView(

        children: [

          /// HELLO
          Text(

            "${lang.translate('hello')} $userName 👋",

            style: const TextStyle(

              fontSize: 24,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 20),

          /// TODAY PROGRESS
          Card(

            elevation: 4,

            shape:
                RoundedRectangleBorder(

              borderRadius:
                  BorderRadius.circular(
                      12),
            ),

            child: Padding(

              padding:
                  const EdgeInsets.all(
                      16),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(

                    lang.translate(
                        'today_progress'),

                    style:
                        const TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 10),

                  Text(
                      "${lang.translate('tasks')} : $totalTasks"),

                  Text(
                      "${lang.translate('completed')} : $completedTasks"),

                  Text(
                      "${lang.translate('study_time')} : $studyTimeFormatted"),

                  const SizedBox(
                      height: 10),

                  ElevatedButton.icon(

                    icon: const Icon(
                        Icons.refresh),

                    label: Text(
                      lang.translate(
                          'reset'),
                    ),

                    onPressed: () {

                      studyBox.put(
                          "seconds", 0);

                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
              height: 30),

          /// SUBJECT PROGRESS
          Text(

            lang.translate(
                'subjects_progress'),

            style: const TextStyle(

              fontSize: 18,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 10),

          subjects.isEmpty

              ? Text(
                  lang.translate(
                      'no_subjects'),
                )

              : Column(

                  children:
                      subjects.map((subject) {

                    return SubjectProgressWidget(

                      subject:
                          lang.translate(
                              subject),

                      percent:
                          calculateProgress(
                              subject),
                    );

                  }).toList(),
                ),

          const SizedBox(
              height: 30),

          /// UPCOMING TASKS
          Text(

            lang.translate(
                'upcoming_tasks'),

            style: const TextStyle(

              fontSize: 18,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 10),

          upcomingTasks.isEmpty

              ? Text(
                  lang.translate(
                      'no_upcoming_tasks'),
                )

              : ListView.builder(

                  shrinkWrap: true,

                  physics:
                      const NeverScrollableScrollPhysics(),

                  itemCount:
                      upcomingTasks.length,

                  itemBuilder:
                      (context, index) {

                    var task =
                        upcomingTasks[index];

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

                            int realIndex =
                                taskBox.values
                                    .toList()
                                    .indexOf(task);

                            toggleTask(
                                realIndex);
                          },
                        ),

                        title: Text(
                            task["title"]),

                        subtitle: Text(

                          "${lang.translate(task["subject"])} | ${taskDate.toLocal().toString().split(' ')[0]}",
                        ),
                      ),
                    );
                  },
                ),

          const SizedBox(
              height: 30),

          /// SUBMISSIONS
          Text(

            lang.translate(
                'upcoming_submissions'),

            style: const TextStyle(

              fontSize: 18,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 10),

          upcomingSubmissions.isEmpty

              ? Text(
                  lang.translate(
                      'no_upcoming_submissions'),
                )

              : ListView.builder(

                  shrinkWrap: true,

                  physics:
                      const NeverScrollableScrollPhysics(),

                  itemCount:
                      upcomingSubmissions.length,

                  itemBuilder:
                      (context, index) {

                    var submission =
                        upcomingSubmissions[index];

                    DateTime submissionDate =
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

                            int realIndex =
                                submissionsBox.values
                                    .toList()
                                    .indexOf(submission);

                            toggleSubmission(
                                realIndex);
                          },
                        ),

                        title: Text(
                            submission["title"]),

                        subtitle: Text(

                          "${lang.translate(submission["subject"])} | ${lang.translate(submission["type"])}\n${submissionDate.toLocal().toString().split(' ')[0]}",
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}