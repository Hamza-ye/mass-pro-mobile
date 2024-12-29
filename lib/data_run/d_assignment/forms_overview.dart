import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FormsOverview extends StatelessWidget {
  const FormsOverview(
      {super.key,
      required this.available,
      required this.submitted,
      required this.pending});

  final int available;
  final int submitted;
  final int pending;

  @override
  Widget build(BuildContext context) {
    final total = available; // Total is derived from available forms
    final submittedPercentage = (submitted / total * 100).toStringAsFixed(1);
    final pendingPercentage = (pending / total * 100).toStringAsFixed(1);

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forms Overview',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    _buildBarGroup(0, submitted, total, Colors.green),
                    _buildBarGroup(1, pending, total, Colors.orange),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 30,
                        showTitles: true,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          reservedSize: 20,
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            switch (value.toInt()) {
                              case 0:
                                return Text(
                                  '${submitted} (${submittedPercentage}%)',
                                  style: Theme.of(context).textTheme.labelSmall,
                                );
                              case 1:
                                return Text(
                                  '${pending} (${pendingPercentage}%)',
                                  style: Theme.of(context).textTheme.labelSmall,
                                );
                              default:
                                return Text('');
                            }
                          }),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  maxY: total.toDouble(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStat('Submitted', '$submitted ($submittedPercentage%)',
                    Colors.green),
                _buildStat(
                    'Pending', '$pending ($pendingPercentage%)', Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, int value, int total, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value.toDouble(),
          color: color,
          width: 16,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
