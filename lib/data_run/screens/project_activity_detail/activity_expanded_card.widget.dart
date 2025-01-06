// import 'package:d2_remote/modules/datarun/form/entities/form_template.entity.dart';
// import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
// import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
// import 'package:datarun/data_run/screens/form/form_tab_screen.widget.dart';
// import 'package:datarun/data_run/screens/form/element/form_metadata.dart';
// import 'package:datarun/data_run/screens/form_submission_list/submission_creation_dialog.widget.dart';
// import 'package:datarun/data_run/screens/form_submission_list/submission_list_screen.widget.dart';
// import 'package:datarun/data_run/screens/project_activity_detail/form_tiles/activity_form_tile.widget.dart';
// import 'package:datarun/data_run/screens/project_activity_detail/model/project_activities.provider.dart';
// import 'package:datarun/core/utils/get_item_local_string.dart';
// import 'package:datarun/generated/l10n.dart';
//
// class ActivityExpandedCard extends HookConsumerWidget {
//   const ActivityExpandedCard(
//       {super.key, required this.activity, this.onDescriptionClick});
//
//   final DActivity activity;
//   final void Function()? onDescriptionClick;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final formTemplatesAsyncValue =
//         ref.watch(activityFormsProvider(activity.uid));
//
//     final isExpanded = useState(true);
//
//     return AsyncValueWidget(
//       value: formTemplatesAsyncValue,
//       valueBuilder: (formTemplates) => Card(
//         shadowColor: Theme.of(context).colorScheme.shadow,
//         surfaceTintColor: Theme.of(context).colorScheme.primary,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         elevation: 3,
//         child: ExpansionTile(
//           initiallyExpanded: isExpanded.value,
//           trailing: activity.description != null
//               ? IconButton(
//                   icon: Icon(Icons.description),
//                   onPressed: onDescriptionClick,
//                 )
//               : null,
//           onExpansionChanged: (bool) => isExpanded.value = bool,
//           leading: const Icon(Icons.event_note_sharp),
//           title: Row(
//             children: <Widget>[
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       '${activity.name}',
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     Text(
//                       S.of(context).form(formTemplates.length),
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           subtitle: !isExpanded.value
//               ? Text(
//                   S.of(context).viewAvailableForms,
//                   style: Theme.of(context).textTheme.bodySmall,
//                   textAlign: TextAlign.center,
//                 )
//               : null,
//           children: [
//             ...formTemplates
//                 .map<Widget>((FormTemplate template) => FormMetadataWidget(
//                       formMetadata: FormMetadata(
//                         form: template.uid!,
//                         formLabel: getItemLocalString(template.label,
//                             defaultString: template.name),
//                         activity: activity.uid!,
//                         version: template.version,
//                       ),
//                       child: ActivityFormTile(
//                           onTap: () => onTapActivityFormTile(context, template),
//                           onAddNew: () => onAddNew(context, ref, template)),
//                     ))
//                 .toList(),
//             if (formTemplates.length == 0) Text(S.of(context).noFormsAvailable)
//           ],
//         ),
//       ),
//     );
//   }
//
//   void onTapActivityFormTile(BuildContext context, FormTemplate template) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => FormMetadataWidget(
//               formMetadata: FormMetadata(
//                 form: template.uid!,
//                 version: template.version,
//                 activity: activity.uid!,
//                 formLabel: getItemLocalString(template.label,
//                     defaultString: template.name),
//               ),
//               child: const SubmissionListScreen())),
//     );
//     // Get.to();
//   }
//
//   Future<void> onAddNew(
//     BuildContext context,
//     WidgetRef ref,
//     FormTemplate template,
//   ) async {
//     if (!context.mounted) {
//       return;
//     }
//
//     final String? result = await showDialog<String?>(
//         context: context,
//         builder: (BuildContext context) {
//           return FormMetadataWidget(
//             formMetadata: FormMetadata(
//               activity: /*template.activity*/ '',
//               form: template.uid!,
//               version: template.version,
//               formLabel: getItemLocalString(template.label,
//                   defaultString: template.name),
//             ),
//             child: const SubmissionCreationDialog(),
//           );
//         });
//     if (result != null) {
//       _goToDataEntryForm(context, result, template);
//     } else {
//       // Handle cancellation or failure
//     }
//   }
//
//   void _goToDataEntryForm(BuildContext context, String submissionCreated,
//       FormTemplate template) async {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => FormMetadataWidget(
//                 formMetadata: FormMetadata(
//                     form: template.uid!,
//                     formLabel: getItemLocalString(template.label,
//                         defaultString: template.name),
//                     submission: submissionCreated,
//                     activity: activity.uid!,
//                     version: template.version),
//                 child: const FormSubmissionScreen(
//                   currentPageIndex: 1,
//                 ),
//               )),
//     );
//   }
// }
