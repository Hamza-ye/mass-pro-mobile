import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:datarun/core/element_instance/field_state/field_state.dart';
import 'package:datarun/core/element_instance/form_state.dart';
import 'package:datarun/core/element_instance/repeat_instance/repeat_row_state.dart';
import 'package:datarun/core/element_instance/repeat_instance/repeat_state.dart';
import 'package:datarun/core/element_instance/sction_instance/section_state.dart';
import 'package:datarun/data_run/screens/form_module/form_template/form_element_template.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_state_provider.g.dart';

@riverpod
String submissionId(SubmissionIdRef ref) {
  throw UnimplementedError();
}

@riverpod
T? parentElement<T extends SectionState>(ParentElementRef<T> ref) {
  throw UnimplementedError();
}

@Riverpod(dependencies: [submissionId])
Future<FormFlatTemplate> submissionFormTemplate(
    SubmissionFormTemplateRef ref) async {
  String submissionId = ref.watch(submissionIdProvider);
  final DataFormSubmission? submission = await D2Remote
      .formSubmissionModule.formSubmission
      .byId(submissionId)
      .getOne();

  final FormVersion formTemplate = await D2Remote.formModule.formTemplateV
      .byId(submission!.formVersion)
      .getOne();

  return FormFlatTemplate.fromTemplate(formTemplate);
}

@Riverpod(dependencies: [submissionFormTemplate])
class FormStateNotifier extends _$FormStateNotifier {
  @override
  Future<FormState> build() async {
    // final FormVersion formTemplate =
    //     await ref.watch(submissionFormTemplateProvider.future);
    final FormFlatTemplate formTemplate =
        await ref.watch(submissionFormTemplateProvider.future);
    return FormState.fromTemplate(formTemplate);
  }

  Future<void> loadForm(String submissionUid) async {
    // Load FormSubmission, DataValues, and RepeatInstances from SQLite.
    // Construct SectionState instances from SectionConf and associated DataValues.
    // Initialize dependency manager (see below) for the entire form.
  }

// Methods to update global validity, etc.
}

@Riverpod(dependencies: [submissionFormTemplate, parentElement])
class SectionStateNotifier extends _$SectionStateNotifier {
  @override
  Future<SectionState> build(String path) async {
    final FormFlatTemplate formTemplate =
        await ref.watch(submissionFormTemplateProvider.future);

    return SectionState.fromTemplate(
        formTemplate.flatFields[path] as SectionElementTemplate);
  }
}

@Riverpod(dependencies: [submissionFormTemplate, parentElement])
class RepeatStateNotifier extends _$RepeatStateNotifier {
  @override
  Future<RepeatState> build(String path) async {
    final FormFlatTemplate formTemplate =
        await ref.watch(submissionFormTemplateProvider.future);

    return RepeatState.fromTemplate(
        formTemplate.flatFields[path] as SectionElementTemplate);
  }
}

@Riverpod(dependencies: [submissionFormTemplate, parentElement])
class RepeatRowStateNotifier extends _$RepeatRowStateNotifier {
  @override
  Future<RowState> build(String path, String repeatUid) async {
    // final RowState? closestRepeatParent =
    //     ref.watch<RowState?>(parentElementProvider());
    final FormFlatTemplate formTemplate =
        await ref.watch(submissionFormTemplateProvider.future);

    return RowState.fromTemplate(
        formTemplate.flatFields[path] as SectionElementTemplate,
        rowId: repeatUid,
        repeatIndex: 0);
  }
}

@Riverpod(dependencies: [submissionFormTemplate, parentElement])
class FieldStateNotifier extends _$FieldStateNotifier {
  @override
  Future<FieldState> build(String path) async {
    // final SectionState? closestRepeatParent =
    //     ref.watch<RowState?>(parentElementProvider()) ??
    //         ref.watch<SectionState?>(parentElementProvider());
    final FormFlatTemplate formTemplate =
        await ref.watch(submissionFormTemplateProvider.future);

    return FieldState.fromTemplate(
        formTemplate.flatFields[path] as FormElementTemplate);
  }
}

// final fieldStateProvider =
//     StateProvider.family<FieldState, String>((ref, path) {
//   final formState = ref.watch(formStateProvider);
//   return formState.fields[path]!;
// });
//
// void updateFieldInRiverpod(String path, dynamic value, WidgetRef ref) {
//   ref
//       .read(fieldStateProvider(path).notifier)
//       .update((state) => state.copyWith(value: value));
// }
