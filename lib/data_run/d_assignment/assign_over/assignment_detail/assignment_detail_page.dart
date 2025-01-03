import 'package:d2_remote/modules/datarun/form/entities/data_form_submission.entity.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignment_detail/form_submissions_table.dart';
import 'package:datarun/data_run/d_assignment/assign_over/form_submission_create.widget.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/data_run/screens/form/element/form_metadata.dart';
import 'package:datarun/data_run/screens/form/form_tab_screen.widget.dart';
import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';

class AssignmentDetailPage extends ConsumerWidget {
  const AssignmentDetailPage({super.key, required this.assignment});

  final AssignmentModel assignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).assignmentDetail)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Divider(
                height: 20,
              ),
              const SizedBox(height: 16),
              _buildDetails(context),
              Divider(
                height: 20,
              ),
              const SizedBox(height: 16),
              _buildResourcesComparison(context),
              const SizedBox(height: 16),
              _buildActions(context),
              const SizedBox(height: 16),
              ...assignment.forms
                  .map(
                    (form) => FormSubmissionsTable(
                        assignment: assignment, formId: form),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            assignment.activity ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        buildStatusBadge(context, assignment.status),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(context, S.of(context).entity,
            '${assignment.entityCode} - ${assignment.entityName}'),
        _buildDetailRow(context, S.of(context).team, '${assignment.teamCode}'),
        _buildDetailRow(context, S.of(context).scope, assignment.scope.name),
        _buildDetailRow(
            context, S.of(context).dueDate, assignment.dueDate.toString()),
        if (assignment.rescheduledDate != null)
          _buildDetailRow(context, S.of(context).rescheduled,
              assignment.rescheduledDate.toString()),
        _buildDetailRow(
            context, S.of(context).forms, assignment.forms.length.toString()),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildResourcesComparison(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).resources,
            style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        ...assignment.allocatedResources.keys.map((key) {
          final allocated = assignment.allocatedResources[key] ?? 0;
          final reported = assignment.reportedResources[key] ?? 0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Intl.message(key), style: Theme.of(context).textTheme.bodyMedium),
              Text('$reported / $allocated',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            await showFormSelectionBottomSheet(context, assignment);
            // ref.invalidate(assignmentsProvider);
          },
          icon: const Icon(Icons.send),
          label: Text(S.of(context).openNewForm),
        ),
        const SizedBox(height: 8),
        DropdownButton<AssignmentStatus>(
          onChanged: (value) {
            if (value != null) {
              // Handle status change
            }
          },
          value: assignment.status,
          items: AssignmentStatus.values.map((status) {
            return DropdownMenuItem<AssignmentStatus>(
              value: status,
              child: Text(Intl.message(status.name.toLowerCase())),
            );
          }).toList(),
        ),
      ],
    );
  }
}

Widget buildStatusBadge(BuildContext context, AssignmentStatus status) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: statusColor(status),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      Intl.message(status.name.toLowerCase()),
      style: const TextStyle(color: Colors.white),
    ),
  );
}

Color statusColor(AssignmentStatus status) {
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

Future<void> goToDataEntryForm(BuildContext context, AssignmentModel assignment,
    DataFormSubmission submission) async {
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FormMetadataWidget(
                formMetadata: FormMetadata(
                  assignmentModel: assignment,
                  formId: submission.formVersion is String
                      ? submission.formVersion
                      : submission.formVersion.id,
                  submission: submission.id,
                ),
                child: const FormSubmissionScreen(currentPageIndex: 1),
              )));
}

Future<void> showFormSelectionBottomSheet(
    BuildContext context, AssignmentModel assignment) async {
  try {
    await showModalBottomSheet(
      enableDrag: false,
      context: context,
      builder: (BuildContext context) {
        return FormSubmissionCreate(
          assignment: assignment,
          onNewFormCreated: (createdSubmission) {
            Navigator.of(context).pop();
            goToDataEntryForm(context, assignment, createdSubmission);
          },
        );
      },
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${S.of(context).errorOpeningForm}: ${e.toString().substring(0, 50)}'),
        duration: const Duration(seconds: 2),
      ),
    );
    return;
  }
}
