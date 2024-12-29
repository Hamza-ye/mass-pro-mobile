import 'package:flutter/material.dart';

import '../../utils/mass_utils/date_formating.dart';

class AssignmentCard extends StatelessWidget {
  final String title;
  final String status;
  final DateTime dueDate;
  final String assignee;
  final String priority;
  final VoidCallback onViewDetails;

  const AssignmentCard({
    Key? key,
    required this.title,
    required this.status,
    required this.dueDate,
    required this.assignee,
    required this.priority,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Icon(
          Icons.assignment,
          color: _getStatusColor(status),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Due: ${formatDate(dueDate.toLocal().toIso8601String())}'),
            Text('Assigned to: $assignee'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(priority, style: TextStyle(color: _getPriorityColor(priority))),
            const SizedBox(height: 4),
            Text(status, style: TextStyle(color: _getStatusColor(status))),
          ],
        ),
        onTap: onViewDetails,
      ),
    );
  }


  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
