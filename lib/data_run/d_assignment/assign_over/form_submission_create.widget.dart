import 'package:d2_remote/modules/datarun/form/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:datarun/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/data_run/form/form_submission/submission_list.provider.dart';
import 'package:datarun/generated/l10n.dart';

class FormSubmissionCreate extends ConsumerStatefulWidget {
  const FormSubmissionCreate(
      {super.key, required this.assignment, required this.onNewFormCreated});

  final AssignmentModel assignment;
  final Function(DataFormSubmission submissionId) onNewFormCreated;

  @override
  FormSubmissionCreateState createState() => FormSubmissionCreateState();
}

class FormSubmissionCreateState extends ConsumerState<FormSubmissionCreate> {
  bool _isLoading = false;

  Future<DataFormSubmission> _createEntity(
      BuildContext context, FormVersion formTemplate) async {
    final activityModel = ActivityInheritedWidget.of(context);
    final submissionInitialRepository = ref.read(
        formSubmissionsProvider(formTemplate.formTemplate)
            .notifier);

    final submission = await submissionInitialRepository.createNewSubmission(
      formVersion: formTemplate.id,
      assignmentId: widget.assignment.id,
      form: formTemplate.id!.split('_').first,
      team: activityModel.assignedTeam!.id!,
      version: formTemplate.version,
    );
    return submission;
  }

  Future<void> createAndPopupWithResult(
      BuildContext context, FormVersion formTemplate) async {
    setState(() {
      _isLoading = true;
    });

    DataFormSubmission? createdSubmission;
    try {
      createdSubmission = await _createEntity(context, formTemplate);
      setState(() {
        _isLoading = false;
      });
      widget.onNewFormCreated.call(createdSubmission);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).errorOpeningNewForm}: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final formTemplateAsync =
    //     ref.watch(assignmentFormsProvider(widget.assignment.id));
    // final formName = getItemLocalString(formTemplates[index].label,
    //     defaultString: formTemplates[index].name);
    return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        '${S.of(context).selectForm} (${S.of(context).form(widget.assignment.forms.length)})',

        style: Theme.of(context).textTheme.titleMedium,
      ),
    ),
    Divider(),
    Expanded(
      child: ListView(
        children: widget.assignment.forms
            .where((f) =>
                ActivityInheritedWidget.of(context).assignedForms.contains(f))
            .map((f) {
          final formTemplateAsync =
              ref.watch(latestFormTemplateProvider(formId: f));
          return AsyncValueWidget(
              value: formTemplateAsync,
              valueBuilder: (formTemplate) {
                return _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListTile(
                        title: Text(formTemplate.name!),
                        // subtitle: Text(
                        //     '${formTemplate.name}'),
                        onTap: () =>
                            createAndPopupWithResult(context, formTemplate),
                      );
              });
        }).toList(),
      ),
    ),
  ],
);
  }
}
