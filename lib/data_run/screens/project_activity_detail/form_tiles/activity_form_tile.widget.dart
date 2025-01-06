// import 'package:flutter/material.dart';
// import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
// import 'package:datarun/data_run/screens/project_activity_detail/form_tiles/submissions_chips.widget.dart';
// import 'package:datarun/generated/l10n.dart';
//
// class ActivityFormTile extends StatelessWidget {
//   const ActivityFormTile({
//     super.key,
//     required this.onTap,
//     required this.onAddNew,
//   });
//
//   final void Function()? onTap;
//   final void Function()? onAddNew;
//
//   @override
//   Widget build(BuildContext context) {
//     final formMetadata = FormMetadataWidget.of(context);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           children: [
//             InkWell(
//               onTap: onTap,
//               borderRadius: BorderRadius.circular(10),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Flexible(
//                           child: GestureDetector(
//                             onTap: () {
//                               _showDescriptionDialog(
//                                   context, formMetadata.formLabel, null);
//                             },
//                             child: Text(
//                               formMetadata.formLabel,
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.bold),
//                               softWrap: true,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 2,
//                             ),
//                           ),
//                         ),
//                         // Flexible(
//                         //   child: Marquee(
//                         //     text: formMetadata.formLabel,
//                         //     style: const TextStyle(fontWeight: FontWeight.bold),
//                         //     scrollAxis: Axis.horizontal,
//                         //     crossAxisAlignment: CrossAxisAlignment.start,
//                         //     blankSpace: 20.0,
//                         //     velocity: 50.0,
//                         //     pauseAfterRound: Duration(seconds: 1),
//                         //     startPadding: 10.0,
//                         //     accelerationDuration: Duration(seconds: 1),
//                         //     accelerationCurve: Curves.linear,
//                         //     decelerationDuration: Duration(milliseconds: 500),
//                         //     decelerationCurve: Curves.easeOut,
//                         //   ),
//                         // ),
//                         // Flexible(
//                         //   child: ExpandableText(
//                         //     formMetadata.formLabel,
//                         //     expandText: 'show more',
//                         //     collapseText: 'show less',
//                         //     maxLines: 2,
//                         //     linkColor: Colors.blue,
//                         //     style: const TextStyle(fontWeight: FontWeight.bold),
//                         //   ),
//                         // ),
//                         // Text(
//                         //   formMetadata.formLabel,
//                         //   style: const TextStyle(fontWeight: FontWeight.bold),
//                         //   softWrap: true,
//                         // ),
//                         Text(
//                           '${S.of(context).version}: ${formMetadata.version}',
//                           style: Theme.of(context).textTheme.bodySmall,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     const SubmissionsChips(),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: <Widget>[
//                         ElevatedButton.icon(
//                           onPressed: onAddNew,
//                           icon: const Icon(Icons.add),
//                           label: Text(S.of(context).addNew),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             foregroundColor: Colors.white,
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showDescriptionDialog(
//     BuildContext context,
//     String formLabel,
//     String? description,
//   ) {
//     if (description != null && description.isNotEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(formLabel),
//             content: Text(description),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text(S.of(context).ok),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }
