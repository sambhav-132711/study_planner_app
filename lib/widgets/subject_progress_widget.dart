import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SubjectProgressWidget extends StatelessWidget {

  final String subject;
  final double percent;

  const SubjectProgressWidget({
    super.key,
    required this.subject,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.symmetric(vertical: 8),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          /// Subject title + percentage text
          Row(

            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              Text(
                subject,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              Text(
                "${(percent * 100).toInt()}%",
              ),
            ],
          ),

          const SizedBox(height: 6),

          /// Progress bar
          LinearPercentIndicator(

            lineHeight: 12,

            percent: percent,

            backgroundColor: Colors.grey.shade300,

            progressColor: Colors.blueAccent,

            barRadius: const Radius.circular(10),

            animation: true,
          ),
        ],
      ),
    );
  }
}