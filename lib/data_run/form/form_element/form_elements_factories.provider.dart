import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:datarun/data_run/form/form_submission/submission_list.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_elements_factories.provider.g.dart';

@riverpod
Future<Map<String, dynamic>?> formInitialData(FormInitialDataRef ref,
    {required String submission}) async {
  final DataFormSubmission? formSubmission = await ref
      .watch(formSubmissionRepositoryProvider)
      .getSubmission(submission);

  return formSubmission!.formData;
}
