import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AssignmentsOverview extends StatelessWidget {
  final int total;
  final int completed;
  final int pending;
  final int overdue;
  final Function(String category) onCategoryTap;

  const AssignmentsOverview({
    required this.total,
    required this.completed,
    required this.pending,
    required this.overdue,
    required this.onCategoryTap,
    Key? key,
  }) : super(key: key);

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
              'Assignments Overview',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat(
                    'Total', total, Colors.blue, () => onCategoryTap('Total')),
                _buildStat('Completed', completed, Colors.green,
                    () => onCategoryTap('Completed')),
                _buildStat('Remaining', pending, Colors.orange,
                    () => onCategoryTap('Pending')),
                _buildStat('Overdue', overdue, Colors.red,
                    () => onCategoryTap('Overdue')),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: completed / (total == 0 ? 1 : total),
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),
            const SizedBox(height: 8),
            Text(
              '${(completed / (total == 0 ? 1 : total) * 100).toStringAsFixed(1)}% Completed',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, int value, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            value.toString(),
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
