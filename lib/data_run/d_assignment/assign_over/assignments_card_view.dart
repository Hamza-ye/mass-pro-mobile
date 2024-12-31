import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/entities/data_form_submission.entity.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_form.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/test_/assignment_overview_item.dart';
import 'package:datarun/data_run/screens/form/element/form_metadata.dart';
import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
import 'package:datarun/data_run/screens/form/form_tab_screen.widget.dart';
import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignmentsCardView extends ConsumerWidget {
  const AssignmentsCardView({super.key, required this.onViewDetails});

  final void Function(AssignmentModel) onViewDetails;

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
                onViewDetails: () => onViewDetails(assignment),
                onChangeStatus: (AssignmentStatus newStatus) {},
                onFormSubmission: (createdSubmission) async {
                  // pop bottomSheet
                  Navigator.of(context).pop();
                  // go to createdSubmission's form
                  _goToDataEntryForm(
                      context,
                      AssignmentForm(
                          assignmentModel: assignment,
                          isNew: true,
                          formId: createdSubmission.formVersion),
                      createdSubmission.id!);
                });
          },
        );
      },
    );
  }

  void _goToDataEntryForm(BuildContext context, AssignmentForm assignmentForm,
      String submission) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormMetadataWidget(
                  formMetadata: FormMetadata(
                    assignmentForm: assignmentForm,
                    submission: submission,
                  ),
                  child: const FormSubmissionScreen(currentPageIndex: 1),
                )));
  }

// Future<DataFormSubmission> _createFormSubmission(String formId,
//     AssignmentModel assignment,
//     WidgetRef ref) async {
//   final formTemplate = await ref.watch(
//       submissionVersionFormTemplateProvider(formId: formId).future);
//   final dataFormSubmission = DataFormSubmission(
//     formVersion: formTemplate.id,
//     assignment: assignment.id,
//     form: formId,
//     team: assignment.teamId,
//     version: formTemplate.version,
//     dirty: true,
//   );
//   D2Remote.formModule.dataFormSubmission.setData(dataFormSubmission);
//   await D2Remote.formModule.dataFormSubmission.save();
//   return dataFormSubmission;
// }
}
