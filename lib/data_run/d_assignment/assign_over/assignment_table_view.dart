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

    return AsyncValueWidget(
      value: assignmentsAsync,
      valueBuilder: (assignments) {
        return _buildTable(assignments);
      },
    );
  }

  Widget _buildTable(List<AssignmentModel> assignments) {
    return DataTable(
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
                  DataCell(Text(assignment.activity)),
                  DataCell(Text(
                      '${assignment.entityCode} - ${assignment.entityName}')),
                  DataCell(
                      Text('${assignment.teamCode} - ${assignment.teamName}')),
                  DataCell(Text(assignment.scope.name)),
                  DataCell(Text(assignment.status.name)),
                  DataCell(Text(assignment.dueDate.toString())),
                  DataCell(Text(assignment.rescheduledDate?.toString() ?? '')),
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
    );
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
