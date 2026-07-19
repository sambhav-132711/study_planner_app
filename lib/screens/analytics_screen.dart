import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fl_chart/fl_chart.dart';

import '../l10n/app_localizations.dart';

class AnalyticsScreen extends StatelessWidget {

  const AnalyticsScreen({super.key});

  List<double> getWeeklyData() {

    final studyBox =
        Hive.box("studyTimeBox");

    List<double> data = [];

    DateTime today =
        DateTime.now();

    for (int i = 6; i >= 0; i--) {

      DateTime day =
          today.subtract(
              Duration(days: i));

      String key =
          day.toString()
              .split(' ')[0];

      int seconds =
          studyBox.get(
        key,
        defaultValue: 0,
      );

      data.add(
          seconds / 3600);
    }

    return data;
  }

  @override
  Widget build(
      BuildContext context) {

    final lang =
        AppLocalizations.of(
            context);

    List<double> weeklyData =
        getWeeklyData();

    List<String> days = [

      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat",
      "Sun"
    ];

    return Padding(

      padding:
          const EdgeInsets.all(
              20),

      child: Column(

        children: [

          Text(

            lang.translate(
                'weekly_analytics'),

            style:
                const TextStyle(

              fontSize: 22,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 20),

          Expanded(

            child: BarChart(

              BarChartData(

                titlesData:
                    FlTitlesData(

                  bottomTitles:
                      AxisTitles(

                    sideTitles:
                        SideTitles(

                      showTitles:
                          true,

                      getTitlesWidget:
                          (value,
                              meta) {

                        return Text(

                          days[value
                              .toInt()],
                        );
                      },
                    ),
                  ),

                  leftTitles:
                      AxisTitles(

                    sideTitles:
                        SideTitles(
                      showTitles:
                          true,
                    ),
                  ),
                ),

                borderData:
                    FlBorderData(
                  show: false,
                ),

                barGroups:

                    weeklyData
                        .asMap()
                        .entries
                        .map((entry) {

                  return BarChartGroupData(

                    x: entry.key,

                    barRods: [

                      BarChartRodData(

                        toY:
                            entry.value,

                        width: 14,
                      ),
                    ],
                  );

                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}