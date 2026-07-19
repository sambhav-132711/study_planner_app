import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:hive/hive.dart';

import '../l10n/app_localizations.dart';

class TimerScreen extends StatefulWidget {

  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() =>
      _TimerScreenState();
}

class _TimerScreenState
    extends State<TimerScreen> {

  final CountDownController
      timerController =
      CountDownController();

  final studyBox =
      Hive.box("studyTimeBox");

  int duration = 1500;

  Stopwatch stopwatch =
      Stopwatch();

  /// SAVE TIME
  void saveStudyTime() {

    String today =
        DateTime.now()
            .toString()
            .split(' ')[0];

    String? storedDate =
        studyBox.get("date");

    int previousSeconds =
        studyBox.get(
      "seconds",
      defaultValue: 0,
    );

    if (storedDate != today) {

      studyBox.put(
          "seconds", 0);

      studyBox.put(
          "date", today);

      previousSeconds = 0;
    }

    int secondsStudied =
        stopwatch
            .elapsed.inSeconds;

    studyBox.put(

      "seconds",

      previousSeconds +
          secondsStudied,
    );
  }

  @override
  Widget build(
      BuildContext context) {

    final lang =
        AppLocalizations.of(
            context);

    return Center(

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment
                .center,

        children: [

          /// TIMER
          CircularCountDownTimer(

            duration: duration,

            controller:
                timerController,

            width: 260,

            height: 260,

            fillColor:
                Colors.blue,

            ringColor:
                Colors
                    .grey
                    .shade300,

            strokeWidth: 12,

            isReverse: true,

            autoStart: false,

            onComplete: () {

              stopwatch.stop();

              saveStudyTime();

              stopwatch.reset();

              ScaffoldMessenger.of(
                      context)
                  .showSnackBar(

                SnackBar(

                  content: Text(

                    lang.translate(
                        'study_timer'),
                  ),
                ),
              );
            },
          ),

          const SizedBox(
              height: 40),

          /// BUTTONS
          Row(

            mainAxisAlignment:
                MainAxisAlignment
                    .center,

            children: [

              ElevatedButton(

                onPressed: () {

                  stopwatch.start();

                  timerController
                      .start();
                },

                child: Text(

                  lang.translate(
                      'start'),
                ),
              ),

              const SizedBox(
                  width: 15),

              ElevatedButton(

                onPressed: () {

                  stopwatch.stop();

                  timerController
                      .pause();
                },

                child: Text(

                  lang.translate(
                      'pause'),
                ),
              ),

              const SizedBox(
                  width: 15),

              ElevatedButton(

                onPressed: () {

                  stopwatch.stop();

                  saveStudyTime();

                  stopwatch.reset();

                  timerController
                      .reset();

                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(

                    SnackBar(

                      content: Text(

                        lang.translate(
                            'reset'),
                      ),
                    ),
                  );
                },

                child: Text(

                  lang.translate(
                      'reset'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}