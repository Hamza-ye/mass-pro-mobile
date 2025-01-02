import 'package:d2_remote/modules/datarun/form/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:datarun/core/utils/get_item_local_string.dart';
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
    final submissionInitialRepository =
        ref.read(formSubmissionsProvider(formTemplate.formTemplate).notifier);

    final submission = await submissionInitialRepository.createNewSubmission(
      formVersion: formTemplate.id,
      assignmentId: widget.assignment.id,
      formId: formTemplate.formTemplate,
      teamId: widget.assignment.teamId,
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
    return ListView(
      children: widget.assignment.forms.map((f) {
        final formTemplateAsync =
            ref.watch(submissionVersionFormTemplateProvider(formId: f));
        return AsyncValueWidget(
            value: formTemplateAsync,
            valueBuilder: (formTemplate) {
              return _isLoading
                  ? CircularProgressIndicator()
                  : ListTile(
                      title: Text(
                          '${S.of(context).form(1)}: ${formTemplate.name}'),
                      onTap: () =>
                          createAndPopupWithResult(context, formTemplate),
                    );
            });
      }).toList(),
    );
  }
}
