import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/queries/data_form_submission.query.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class FormSubmissionRepository {
  FormSubmissionRepository();

  // final DataFormSubmissionQuery _query;
  DataFormSubmissionQuery get _query => D2Remote.formModule.dataFormSubmission;

  Future<IList<DataFormSubmission>> getSubmissions(String form,
      [String? assignment, int? version]) async {
    final query = _query.byFormTemplate(form, version);
    if (assignment != null) {
      query.where(attribute: 'assignment', value: assignment);
    }
    final List<DataFormSubmission> submissions = await query.get();
    return submissions.lock;
  }

  Future<DataFormSubmission?> getSubmission(String uid) async {
    final DataFormSubmission? submission = await _query.byId(uid).getOne();
    return submission;
  }

  Future<DataFormSubmission?> deleteSubmission(String uid) async {
    final DataFormSubmission? submission = await _query.byId(uid).delete();
    return submission;
  }

  Future<void> deleteAllFormSubmission(String form, [int? version]) async {
    return _query.byFormTemplate(form, version).delete();
  }
}
