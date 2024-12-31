import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AssignmentTableView extends ConsumerWidget {
  AssignmentTableView({super.key,required this.onViewDetails});

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
          columns: <DataColumn>[
            // DataColumn(label: Text(S.current.activity)),
            DataColumn(label: Text(S.current.status)),
            DataColumn(label: Text(S.current.entity)),
            DataColumn(label: Text(S.current.team)),
            DataColumn(label: Text(S.current.scope)),
            // DataColumn(label: Text(S.current.status)),
            DataColumn(label: Text(S.current.dueDate)),
            DataColumn(label: Text(S.current.rescheduled)),
            DataColumn(label: Text(S.current.allocatedResources)),
            DataColumn(label: Text(S.current.reportedResources)),
            // DataColumn(label: Text(S.current.forms)),
          ],
          rows: assignments
              .map((assignment) => DataRow(
                    cells: <DataCell>[
                      // DataCell(_buildHighlightedText(
                      //     assignment.activity, searchQuery)),
                      DataCell(_buildStatusBadge(assignment)),
                      DataCell(_buildHighlightedText(
                          '${assignment.entityCode} - ${assignment.entityName}',
                          searchQuery)),
                      DataCell(_buildHighlightedText(
                          '${assignment.teamName}', searchQuery)),
                      DataCell(Text(
                          Intl.message(assignment.scope.name.toLowerCase()))),
                      // DataCell(Text(
                      //     Intl.message(assignment.status.name.toLowerCase()))),
                      DataCell(Text(assignment.dueDate.toString())),
                      DataCell(
                          Text(assignment.rescheduledDate?.toString() ?? '')),
                      DataCell(Text(assignment.allocatedResources.toString())),
                      DataCell(Text(assignment.reportedResources.toString())),
                      // DataCell(Text(assignment.forms.toString())),
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

  Widget _buildStatusBadge(AssignmentModel assignment) {
    IconData statusIcon;
    Color badgeColor;

    switch (assignment.status) {
      case AssignmentStatus.NOT_STARTED:
        statusIcon = Icons.hourglass_empty;
        badgeColor = Colors.grey;
        break;
      case AssignmentStatus.IN_PROGRESS:
        statusIcon = Icons.autorenew;
        badgeColor = Colors.blue;
        break;
      case AssignmentStatus.COMPLETED:
        statusIcon = Icons.check_circle;
        badgeColor = Colors.green;
        break;
      case AssignmentStatus.RESCHEDULED:
        statusIcon = Icons.schedule;
        badgeColor = Colors.orange;
        break;
      case AssignmentStatus.CANCELLED:
        statusIcon = Icons.cancel;
        badgeColor = Colors.red;
        break;
      default:
        statusIcon = Icons.help_outline;
        badgeColor = Colors.black;
    }

    return Tooltip(
      message: Intl.message(assignment.status.name.toLowerCase()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: badgeColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(statusIcon, color: Colors.white),
      ),
    );
  }
}
