import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class SubmissionSummary with EquatableMixin {
  SubmissionSummary({required this.orgUnit, Map<String, dynamic>? formData})
      : this.formData = formData ?? {};

  final String orgUnit;
  final Map<String, dynamic> formData;

  @override
  List<Object?> get props => [orgUnit, formData];
}
