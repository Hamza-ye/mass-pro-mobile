import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ActivityTracker extends StatelessWidget {
  final Map<String, int> tasksCompleted;

  const ActivityTracker({required this.tasksCompleted});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activity Tracker',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: tasksCompleted.entries
                          .map((e) => FlSpot(
                                _dayToDouble(e.key),
                                e.value.toDouble(),
                              ))
                          .toList(),
                      isCurved: true,
                      // colors: [Colors.blue],
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return SideTitleWidget(                        
                              axisSide: meta.axisSide,
                              child: Text(
                                _doubleToDay(value),
                                // meta.formattedValue,
                              ),
                            );
                          },
                          reservedSize: 44,
                          showTitles: true,
                        ),
                      )
                      //  SideTitles(
                      //   showTitles: true,
                      //   getTitles: (value) => _doubleToDay(value),
                      // ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _dayToDouble(String day) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days.indexOf(day).toDouble();
  }

  String _doubleToDay(double value) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[value.toInt()];
  }
}
