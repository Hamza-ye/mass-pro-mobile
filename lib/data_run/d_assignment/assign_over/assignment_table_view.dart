import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/test_/assignment_page.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:d2_remote/core/datarun/utilities/date_utils.dart' as sdk;

class AssignmentTableView extends HookConsumerWidget {
  AssignmentTableView({super.key, required this.onViewDetails, this.scope});

  final void Function(AssignmentModel) onViewDetails;
  final EntityScope? scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(filterAssignmentsProvider(scope));
    final searchQuery = ref.watch(filterQueryProvider).searchQuery;

    // final _sortColumnIndex = useState<int?>(null);
    // final _sortAscending = useState(true);
    //
    // void _sort<T>(Comparable<T> Function(AssignmentModel d) getField,
    //     int columnIndex, bool ascending) {
    //   submissions.value.sort((a, b) {
    //     final aValue = getField(a);
    //     final bValue = getField(b);
    //     return ascending
    //         ? Comparable.compare(aValue, bValue)
    //         : Comparable.compare(bValue, aValue);
    //   });
    //   _sortColumnIndex.value = columnIndex;
    //   _sortAscending.value = ascending;
    // }

    return AsyncValueWidget(
      value: assignmentsAsync,
      valueBuilder: (assignments) {
        return _buildTable(context, assignments, searchQuery);
      },
    );
  }

  Widget _buildTable(BuildContext context, List<AssignmentModel> assignments,
      String searchQuery) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: DataTable(
          columns: <DataColumn>[
            DataColumn(label: Text(S.current.dueDay)),
            DataColumn(label: Text(S.current.status)),
            DataColumn(label: Text(S.current.entity)),
            DataColumn(label: Text(S.current.team)),
            DataColumn(label: Text(S.current.scope)),
            DataColumn(label: Text(S.current.dueDate)),
            DataColumn(label: Text(S.current.rescheduled)),
            DataColumn(label: Text(S.current.allocatedResources)),
            DataColumn(label: Text(S.current.reportedResources)),
          ],
          rows: assignments
              .map((assignment) => DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (assignment.status.isNotStarted() ||
                            assignment.status.isRescheduled()) {
                          return Colors.grey
                              .withOpacity(0.3); // Set the color to gray
                        }
                        if (assignment.status.isDone()) {
                          return null; // Set the color to gray
                        }
                        return Colors.greenAccent
                            .withOpacity(0.3);
                      },
                    ),
                    cells: <DataCell>[
                      DataCell(_buildHighlightedText(
                          '${S.of(context).day} ${assignment.startDay}',
                          searchQuery)),
                      DataCell(buildStatusBadge(assignment.status)),
                      DataCell(_buildHighlightedText(
                          '${assignment.entityCode} - ${assignment.entityName}',
                          searchQuery)),
                      DataCell(Row(children: [
                        Icon(Icons.group),
                        SizedBox(width: 4),
                        Text('${assignment.teamCode}')
                      ])),
                      DataCell(Text(
                          Intl.message(assignment.scope.name.toLowerCase()))),
                      DataCell(Text(assignment.dueDate != null
                          ? sdk.DDateUtils.uiDateFormat()
                              .format(assignment.dueDate!)
                          : '')),
                      DataCell(Text(assignment.rescheduledDate != null
                          ? sdk.DDateUtils.uiDateFormat()
                              .format(assignment.rescheduledDate!)
                          : '')),
                      DataCell(Text(assignment.allocatedResources.toString())),
                      DataCell(Text(assignment.reportedResources.toString())),
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

// Color _statusColor(AssignmentStatus status) {
//   switch (status) {
//     case AssignmentStatus.NOT_STARTED:
//       return Colors.grey;
//     case AssignmentStatus.IN_PROGRESS:
//       return Colors.blue;
//     case AssignmentStatus.COMPLETED:
//       return Colors.green;
//     case AssignmentStatus.RESCHEDULED:
//       return Colors.orange;
//     case AssignmentStatus.CANCELLED:
//       return Colors.red;
//     default:
//       return Colors.black;
//   }
// }
}
