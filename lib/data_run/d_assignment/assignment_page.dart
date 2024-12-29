import 'package:flutter/material.dart';
import 'assignment_card.dart';

class AssignmentsPage extends StatelessWidget {
  const AssignmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> assignments = [
      {
        'title': 'Distribute ITNs in Zone A',
        'status': 'Pending',
        'dueDate': DateTime.now().add(const Duration(days: 2)),
        'assignee': 'John Doe',
        'priority': 'High',
      },
      {
        'title': 'Survey Zone B',
        'status': 'In Progress',
        'dueDate': DateTime.now().add(const Duration(days: 5)),
        'assignee': 'Jane Smith',
        'priority': 'Medium',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Assignments')),
      body: Column(
        children: [
          // Placeholder for filters
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Filter'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sort'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: assignments.length,
              itemBuilder: (context, index) {
                final assignment = assignments[index];
                return AssignmentCard(
                  title: assignment['title'],
                  status: assignment['status'],
                  dueDate: assignment['dueDate'],
                  assignee: assignment['assignee'],
                  priority: assignment['priority'],
                  onViewDetails: () {
                    // Handle navigation to details page
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle "Add Assignment" or "Sync Data"
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
