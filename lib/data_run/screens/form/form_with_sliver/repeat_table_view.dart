// import 'package:datarun/data_run/screens/form/element/form_instance.dart';
// import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
// import 'package:datarun/data_run/screens/form/form_with_sliver/repeat_table.widget.dart';
// import 'package:datarun/data_run/screens/form/form_with_sliver/repeat_table/edit_panel.dart';
// import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
// import 'package:datarun/data_run/screens/form_module/form/code_generator.dart';
// import 'package:datarun/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:datarun/data_run/screens/form/element/form_element.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:reactive_forms/reactive_forms.dart';
//
// class RepeatInstanceDataTable extends HookConsumerWidget {
//   RepeatInstanceDataTable({super.key, required this.repeatInstance});
//
//   final RepeatInstance repeatInstance;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final formInstance = ref
//         .watch(
//             formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
//         .requireValue;
//
//     final elementPropertiesSnapshot =
//         useStream(repeatInstance.propertiesChanged);
//
//     final Future<void> Function(int index) onEdit =
//         useCallback((int index) async {
//       final itemInstance = repeatInstance.elements[index];
//       await _showEditPanel(context, formInstance, itemInstance, index);
//     }, [repeatInstance, formInstance]);
//
//     final onDelete = useCallback((int index) async {
//       formInstance.onRemoveRepeatedItem(index, repeatInstance);
//     }, [formInstance, repeatInstance]);
//
//     if (!elementPropertiesSnapshot.hasData) {
//       return const CircularProgressIndicator();
//     }
//
//     if (elementPropertiesSnapshot.data!.hidden) {
//       return const SizedBox.shrink();
//     }
//
//     return RepeatTable(
//         repeatInstance: repeatInstance,
//         onEdit: onEdit,
//         onDelete: onDelete,
//         onAdd: () async {
//           await _showEditPanel(context, formInstance);
//         });
//   }
//
//   Future<void> _showEditPanel(BuildContext context, FormInstance formInstance,
//       [RepeatItemInstance? repeatItem, int? index]) async {
//     bool itemSaved = false;
//
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return PopScope(
//           canPop: false,
//           onPopInvokedWithResult: (bool didPop, result) async {
//             if (didPop) {
//               return;
//             }
//
//             final bool shouldPop = await _onTryToClose(
//               context,
//               formInstance,
//               repeatInstance,
//               repeatItem!,
//               itemSaved,
//             );
//             if (context.mounted && shouldPop) {
//               Navigator.pop(context);
//             }
//           },
//           child: Dialog(
//             child: FormMetadataWidget(
//               formMetadata: formInstance.formMetadata,
//               child: Builder(builder: (context) {
//                 String title = repeatItem == null
//                     ? '${S.of(context).newItem}: ${repeatInstance.label}'
//                     : '${S.of(context).editItem}: ${repeatInstance.label}';
//
//                 if (repeatItem == null) {
//                   repeatItem = formInstance.onAddRepeatedItem(repeatInstance);
//                 }
//
//                 return ReactiveForm(
//                   formGroup: repeatItem!.elementControl,
//                   child: EditPanel(
//                     title: title,
//                     repeatInstance: repeatInstance,
//                     item: repeatItem!,
//                     onSave: (formGroup, action) {
//                       repeatInstance.elementControl.markAllAsTouched();
//                       repeatItem!.updateValue(formGroup.value);
//                       if (formGroup.valid) {
//                         itemSaved = true;
//                         _handleSave(
//                           context,
//                           formInstance,
//                           repeatInstance,
//                           repeatItem!,
//                           action,
//                         );
//                       }
//                     },
//                   ),
//                 );
//               }),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _handleSave(
//       BuildContext context,
//       FormInstance formInstance,
//       RepeatInstance repeatInstance,
//       RepeatItemInstance repeatItem,
//       EditActionType action) async {
//     if (repeatItem.elementControl.valid) {
//       // the values are already updated, just to let the repeat
//       // instance emit on stream so it rebuilds,
//       Navigator.of(context).pop(); // Close the current dialog
//
//       if (action == EditActionType.SAVE_AND_ADD_ANOTHER) {
//         _showEditPanel(context, formInstance);
//       } else if (action == EditActionType.SAVE_AND_CLOSE) {
//         // Do nothing, as we've already closed the dialog
//       }
//     }
//   }
//
//   Future<bool> _onTryToClose(
//       BuildContext context,
//       FormInstance formInstance,
//       RepeatInstance repeatInstance,
//       RepeatItemInstance repeatItem,
//       bool itemSaved) async {
//     final isNew = repeatItem.uid == null;
//
//     if (/*control.itemFormGroup.dirty && */ isNew) {
//       final bool? confirmClose = await showDialog<bool>(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(S.of(context).unsavedChangesWarning),
//             content: Text(S.of(context).closeWithoutSaving),
//             actions: <Widget>[
//               TextButton(
//                 child: Text(S.of(context).cancel),
//                 onPressed: () => Navigator.of(context).pop(false),
//               ),
//               if (repeatItem.elementControl.valid)
//                 TextButton(
//                   child: Text(S.of(context).saveAndClose),
//                   onPressed: () {
//                     repeatItem.setUid(CodeGenerator.generateUid());
//                     Navigator.of(context).pop(true);
//                   },
//                 ),
//               TextButton(
//                 child: Text(S.of(context).closeWithoutSaving),
//                 onPressed: () {
//                   formInstance.onRemoveLastItem(repeatInstance);
//                   Navigator.of(context).pop(true);
//                 },
//               ),
//             ],
//           );
//         },
//       );
//
//       return (confirmClose ?? false);
//     } else if (repeatItem.elementControl.valid) {
//       return true;
//     }
//     return false;
//   }
// }
