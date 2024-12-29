import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignmentTableView extends ConsumerWidget {
  AssignmentTableView({required this.onViewDetails});

  final void Function(AssignmentModel) onViewDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(filterAssignmentsProvider);
    final searchQuery = ref.watch(filterQueryProvider).searchQuery;

    return AsyncValueWidget(
      value: assignmentsAsync,
      valueBuilder: (assignments) {
        return _buildTable(assignments, searchQuery);
      },
    );
  }

  Widget _buildTable(List<AssignmentModel> assignments, String searchQuery) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Activity')),
            DataColumn(label: Text('Entity')),
            DataColumn(label: Text('Team')),
            DataColumn(label: Text('Scope')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Due Date')),
            DataColumn(label: Text('Rescheduled Date')),
            DataColumn(label: Text('Allocated Resources')),
            DataColumn(label: Text('Reported Resources')),
            DataColumn(label: Text('Forms')),
            DataColumn(label: Text('Status')),
          ],
          rows: assignments
              .map((assignment) => DataRow(
                    cells: <DataCell>[
                      DataCell(_buildHighlightedText(
                          assignment.activity, searchQuery)),
                      DataCell(_buildHighlightedText(
                          '${assignment.entityCode} - ${assignment.entityName}',
                          searchQuery)),
                      DataCell(_buildHighlightedText(
                          '${assignment.teamCode} - ${assignment.teamName}',
                          searchQuery)),
                      DataCell(Text(assignment.scope.name)),
                      DataCell(Text(assignment.status.name)),
                      DataCell(Text(assignment.dueDate.toString())),
                      DataCell(
                          Text(assignment.rescheduledDate?.toString() ?? '')),
                      DataCell(Text(assignment.allocatedResources.toString())),
                      DataCell(Text(assignment.reportedResources.toString())),
                      DataCell(Text(assignment.forms.toString())),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _statusColor(assignment.status),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            assignment.status.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                    onSelectChanged: (_) => onViewDetails(assignment),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildHighlightedText(String text, String searchQuery) {
    if (searchQuery.isEmpty) {
      return Text(text);
    }

    final lowerCaseText = text.toLowerCase();
    final lowerCaseQuery = searchQuery.toLowerCase();
    final startIndex = lowerCaseText.indexOf(lowerCaseQuery);

    if (startIndex == -1) {
      return Text(text);
    }

    final endIndex = startIndex + searchQuery.length;
    final highlightedText = TextSpan(
      text: text.substring(0, startIndex),
      style: const TextStyle(color: Colors.black),
      children: [
        TextSpan(
          text: text.substring(startIndex, endIndex),
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: text.substring(endIndex),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );

    return RichText(text: highlightedText);
  }

  Color _statusColor(AssignmentStatus status) {
    switch (status) {
      case AssignmentStatus.NOT_STARTED:
        return Colors.grey;
      case AssignmentStatus.IN_PROGRESS:
        return Colors.blue;
      case AssignmentStatus.COMPLETED:
        return Colors.green;
      case AssignmentStatus.RESCHEDULED:
        return Colors.orange;
      case AssignmentStatus.CANCELLED:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
