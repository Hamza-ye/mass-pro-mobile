// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
// import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
// import 'package:datarun/data_run/screens/project_activity_detail/form_tiles/form_submissions_status.provider.dart';
//
// class SubmissionsChips extends ConsumerWidget {
//   const SubmissionsChips({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final formMetadata = FormMetadataWidget.of(context);
//     final submissionStatusAsyncValue =
//         ref.watch(formSubmissionsStatusProvider(formMetadata.form));
//
//     return AsyncValueWidget(
//       value: submissionStatusAsyncValue,
//       valueBuilder: (entityCountByStatus) => Wrap(
//         spacing: 8.0,
//         runSpacing: 4.0,
//         children: <Widget>[
//           /// Sent
//           Chip(
//               avatar: CircleAvatar(
//                   foregroundColor: entityCountByStatus.synced > 0
//                       ? Colors.green
//                       : Colors.grey,
//                   child: const Icon(Icons.cloud_done)),
//               label: Text('${entityCountByStatus.synced}')),
//
//           /// Finished
//           Chip(
//             avatar: CircleAvatar(
//                 foregroundColor:
//                     entityCountByStatus.toPost > 0 ? Colors.blue : Colors.grey,
//                 child: const Icon(Icons.cloud_upload)),
//             label: Text('${entityCountByStatus.toPost}'),
//           ),
//
//           /// Not Finished
//           Chip(
//             avatar: CircleAvatar(
//               foregroundColor: entityCountByStatus.toUpdate > 0
//                   ? Colors.orange
//                   : Colors.grey,
//               child: const Icon(Icons.update),
//             ),
//             label: Text('${entityCountByStatus.toUpdate}'),
//           ),
//
//           /// Errors
//           Chip(
//             avatar: const CircleAvatar(
//               child: Icon(Icons.error),
//             ),
//             label: Text('${entityCountByStatus.withError}'),
//           ),
//         ],
//       ),
//     );
//   }
// }
