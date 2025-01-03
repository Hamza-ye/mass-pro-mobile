import 'package:d2_remote/modules/datarun/form/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:d2_remote/modules/datarun/form/shared/template_extensions/form_traverse_extension.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/core/utils/get_item_local_string.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignment_detail/assignment_detail_page.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/data_run/form/form_submission/submission_list.provider.dart';
import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:datarun/data_run/screens/form_submission_list/submission_sync_dialog.widget.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormSubmissionsTable extends HookConsumerWidget {
  const FormSubmissionsTable(
      {super.key, required this.assignment, required this.formId});

  final AssignmentModel assignment;
  final String formId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSubmissions = useState<Set<DataFormSubmission>>({});

    final formVersionsAsync =
        ref.watch(submissionVersionFormTemplateProvider(formId: formId));
    return AsyncValueWidget(
      value: formVersionsAsync,
      valueBuilder: (FormVersion formVersion) {
        final columnHeaders = formVersion.formFlatFields.entries.where((entry) {
          final field = entry.value;
          return !field.type!.isSection && field.mainField;
        }).toList();
        final formSubmissions =
            ref.watch(assignmentSubmissionsProvider(assignment.id, form: formVersion.formTemplate));
        return Column(
          children: [
            if (selectedSubmissions.value.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      await ref
                          .read(formSubmissionsProvider(formId).notifier)
                          .deleteSubmission(selectedSubmissions.value
                              .map((s) => s.id)
                              .toList());
                      ref.invalidate(formSubmissionsProvider);
                    },
                    icon: const Icon(Icons.delete),
                    label: Text(S.of(context).delete),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final unSynced = selectedSubmissions.value
                          .where((s) => s.synced == false)
                          .map((s) => s.id!)
                          .toList();
                      await _showSyncDialog(context, unSynced, ref);
                      ref.invalidate(formSubmissionsProvider);
                    },
                    icon: const Icon(Icons.sync),
                    label: Text(S.of(context).syncFormData),
                  ),
                ],
              ),
            AsyncValueWidget(
              value: formSubmissions,
              valueBuilder: (List<DataFormSubmission> submissions) {
                if (submissions.isEmpty) {
                  return Center(child: Text(S.of(context).noSubmissions));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formVersion.name!,
                        style: Theme.of(context).textTheme.titleMedium),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: <DataColumn>[
                          DataColumn(label: Text(S.of(context).status)),
                          ...columnHeaders.map((header) => DataColumn(
                              label: Text(getItemLocalString(
                                  header.value.label.unlock,
                                  defaultString: header.key)))),
                        ],
                        rows: submissions.map((submission) {
                          final extractedValues =
                              _extractValues(submission.formData, formVersion);
                          final totalResources =
                              _sumNumericResources(submission.formData);

                          return DataRow(
                            selected:
                                selectedSubmissions.value.contains(submission),
                            onSelectChanged: (selected) {
                              if (selected == true) {
                                selectedSubmissions.value = {
                                  ...selectedSubmissions.value,
                                  submission
                                };
                              } else {
                                selectedSubmissions.value = {
                                  ...selectedSubmissions.value
                                }..remove(submission);
                              }
                            },
                            cells: <DataCell>[
                              DataCell(buildStatusBadge(
                                  context, submission.status!)),
                              ...columnHeaders.map(
                                (header) => DataCell(Text(
                                    extractedValues[header.value.name]
                                            ?.toString() ??
                                        totalResources[header.value.name]
                                            ?.toString() ??
                                        '')),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  Map<String, dynamic> _extractValues(
      Map<String, dynamic> formData, FormVersion formTemplate) {
    Map<String, dynamic> extractedValues = {};

    void _extract(Map<String, dynamic> data, List<Template> fields) {
      fields.forEach((field) {
        if (field.type!.isSection && data.containsKey(field.name)) {
          _extract(data[field.name], field.fields.toList());
        } else if (field.type!.isRepeatSection &&
            data.containsKey(field.name)) {
          // extractedValues[field.name!] = data[field.name];
        } else if (data.containsKey(field.name)) {
          extractedValues[field.name!] = data[field.name];
        }
      });
    }

    _extract(formData, formTemplate.fields);
    return extractedValues;
  }

  Map<String, double> _sumNumericResources(Map<String, dynamic> formData) {
    Map<String, double> subTotals = {};

    void _sumResources(Map<String, dynamic> data) {
      data.forEach((key, value) {
        if (value is num) {
          subTotals[key] = (subTotals[key] ?? 0) + value.toDouble();
        } else if (value is Map<String, dynamic>) {
          _sumResources(value);
        } else if (value is List) {
          value.forEach((element) {
            if (element is Map<String, dynamic>) {
              _sumResources(element);
            }
          });
        }
      });
    }

    _sumResources(formData);
    return subTotals;
  }

  Future<void> _showSyncDialog(
      BuildContext context, List<String> entityUids, WidgetRef ref) async {
    final formMetadata = FormMetadataWidget.of(context);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SyncDialog(
          entityUids: entityUids,
          syncEntity: (uids) async {
            if (uids != null) {
              await ref
                  .read(formSubmissionsProvider(formMetadata.formId).notifier)
                  .syncEntities(uids);
            }
          },
        );
      },
    );
  }
}
