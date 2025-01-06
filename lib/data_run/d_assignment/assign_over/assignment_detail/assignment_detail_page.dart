import 'package:datarun/data_run/d_activity/activity_card.dart';
import 'package:datarun/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignment_detail/form_submissions_table.dart';
import 'package:datarun/data_run/d_assignment/assign_over/form_submission_create.widget.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/test_/assignment_page.dart';
import 'package:datarun/data_run/form/form_submission/submission_list.provider.dart';
import 'package:datarun/data_run/screens/form_ui_elements/get_error_widget.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';

class AssignmentDetailPage extends ConsumerWidget {
  const AssignmentDetailPage({super.key, required this.assignment});

  final AssignmentModel assignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityModel = ActivityInheritedWidget.of(context);
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
              Divider(height: 20),
              const SizedBox(height: 16),
              _buildResourcesComparison(context),
              const SizedBox(height: 16),
              _buildActions(context, ref, activityModel),
              const SizedBox(height: 20),
              Divider(height: 20),
              const SizedBox(height: 20),
              ...assignment.forms
                  .where((f) => ActivityInheritedWidget.of(context)
                      .assignedForms
                      .contains(f))
                  .toList()
                  .distinct()
                  .map(
                    (form) => _EagerInitialization(
                      child: FormSubmissionsTable(
                        assignment: assignment,
                        formId: form,
                      ),
                      assignment: assignment,
                      formId: form,
                    ),
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
        buildStatusBadge(assignment.status),
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
        _buildDetailRow(
            context, S.of(context).scope, Intl.message(assignment.scope.name.toLowerCase())),
        if (assignment.dueDate != null)
          _buildDetailRow(context, S.of(context).dueDate,
              formatDate(assignment.dueDate!, context)),
        if (assignment.rescheduledDate != null)
          _buildDetailRow(
              context,
              S.of(context).rescheduled,
              formatDate(assignment.rescheduledDate!, context)),
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
          final reported = assignment.reportedResources[key.toLowerCase()] ?? 0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Intl.message(key.toLowerCase()),
                  style: Theme.of(context).textTheme.bodyMedium),
              Text('$reported / $allocated',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildActions(
      BuildContext context, WidgetRef ref, ActivityModel activityModel) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            await showFormSelectionBottomSheet(
                context, assignment, activityModel);
          },
          icon: const Icon(Icons.send),
          label: Text(S.of(context).openNewForm),
        ),
      ],
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  _EagerInitialization(
      {required this.child, required this.assignment, required this.formId});

  final Widget child;
  final AssignmentModel assignment;
  final String formId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref.watch(formSubmissionsProvider(formId));
    if (formInstance.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (formInstance.hasError) {
      return getErrorWidget(formInstance.error, formInstance.stackTrace);
    }

    return child;
  }
}

Future<void> showFormSelectionBottomSheet(BuildContext context,
    AssignmentModel assignment, ActivityModel activityModel) async {
  try {
    await showModalBottomSheet(
      enableDrag: false,
      context: context,
      builder: (BuildContext context) {
        return ActivityInheritedWidget(
          activityModel: activityModel,
          child: FormSubmissionCreate(
            assignment: assignment,
            onNewFormCreated: (createdSubmission) async {
              Navigator.of(context).pop();
              goToDataEntryForm(
                  context, assignment, createdSubmission, activityModel);
              // ref.invalidate(assignmentsProvider);
            },
          ),
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
