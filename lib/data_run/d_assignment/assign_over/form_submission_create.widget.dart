import 'package:d2_remote/modules/datarun/form/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:datarun/core/utils/get_item_local_string.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
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
    // final formTemplates = await ref
    //     .watch(submissionVersionFormTemplateProvider(formId: [formId]).future);

    // if(formTemplates.isEmpty) {
    //   throw Exception('Form template not found');
    // }

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
      // if (model.form.valid) {
      createdSubmission = await _createEntity(context, formTemplate);
      setState(() {
        _isLoading = false;
      });
      widget.onNewFormCreated.call(createdSubmission);
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      // Navigator.of(context).pop(createdSubmission.id!);
      // });
      // } else {
      // model.form.

      // }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).errorOpeningNewForm}: $e')),
      );
      // rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formTemplateAsync =
        ref.watch(assignmentFormsProvider(widget.assignment.id));

    return AsyncValueWidget(
      value: formTemplateAsync,
      valueBuilder: (formTemplates) {
        return ListView.builder(
          itemCount: formTemplates.length,
          itemBuilder: (BuildContext context, int index) {
            final formName = getItemLocalString(formTemplates[index].label,
                defaultString: formTemplates[index].name);
            return ListTile(
              title: _isLoading
                  ? CircularProgressIndicator()
                  : Text('${S.of(context).form(1)}: $formName'),
              onTap: _isLoading
                  ? null
                  : () =>
                      createAndPopupWithResult(context, formTemplates[index]),
            );
          },
        );
      },
    );

    //   return AsyncValueWidget(
    //     value: templateAsyncValue,
    //     valueBuilder: (SubmissionCreationModel model) => AlertDialog(
    //       surfaceTintColor: Theme.of(context).colorScheme.primary,
    //       shadowColor: Theme.of(context).colorScheme.shadow,
    //       title: Column(
    //         children: [
    //           Text('${S.of(context).openNewForm}:',
    //               style: Theme.of(context).textTheme.titleMedium),
    //           Text(formMetadata.formLabel,
    //               style: Theme.of(context).textTheme.titleLarge)
    //         ],
    //       ),
    //       content: SingleChildScrollView(
    //         child: Column(
    //           children: <Widget>[
    //             if (_isLoading)
    //               const Padding(
    //                 padding: EdgeInsets.all(8.0),
    //                 child: CircularProgressIndicator(),
    //               ),
    //           ],
    //         ),
    //       ),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text(S.of(context).cancel),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //         TextButton(
    //           onPressed: _isLoading
    //               ? null
    //               : () => createAndPopupWithResult(context, model),
    //           child: Text(S.of(context).open),
    //         ),
    //       ],
    //     ),
    //   );
    // }
  }
}
