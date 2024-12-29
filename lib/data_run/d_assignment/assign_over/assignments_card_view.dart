import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/test_/assignment_overview_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignmentsCardView extends ConsumerWidget {
  const AssignmentsCardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(filterAssignmentsProvider);

    return AsyncValueWidget(
      value: assignmentsAsync,
      valueBuilder: (assignments) {
        return ListView.builder(
          itemCount: assignments.length,
          itemBuilder: (context, index) {
            final assignment = assignments[index];
            return AssignmentOverviewItem(
                assignment: assignment,
                onViewDetails: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         AssignmentPage(assignment: assignment),
                  //   ),
                  // );
                },
                onSubmitForm: () {},
                onChangeStatus: (AssignmentStatus newStatus) {
                  // ref.read(assignmentStatusProvider(assignment.id!)).state =
                  //     newStatus;
                });
          },
        );
      },
    );
  }
}
