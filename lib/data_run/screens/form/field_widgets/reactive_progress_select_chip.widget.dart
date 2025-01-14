import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/assignment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
import 'package:datarun/data_run/screens/form/element/validation/form_element_validator.dart';
import 'package:datarun/data_run/screens/form/field_widgets/custom_reactive_widget/reactive_chip_option.dart';
import 'package:datarun/data_run/screens/form/field_widgets/custom_reactive_widget/reactive_choice_chips.dart';
import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QReactiveProgressSelectChip extends ConsumerWidget {
  QReactiveProgressSelectChip({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

    final progressStatuses =
        AssignmentStatus.values.where((v) => !v.isNotStarted()).toList();

    return ReactiveChoiceChips<String>(
      formControl: formInstance.form.control(element.elementPath!)
          as FormControl<String>,
      validationMessages: validationMessages(context),
      selectedColor: Theme.of(context).colorScheme.error.withAlpha(100),
      options: _getChipOptions(progressStatuses),
      decoration: InputDecoration(
        enabled: element.elementControl.enabled,
        labelText: element.label,
      ),
      onChanged: (control) async {
        await formInstance
            .onChangeStatus(AssignmentStatus.getType(control.value));
        ref.read(assignmentsProvider.notifier).updateStatus(
            AssignmentStatus.getType(control.value),
            formInstance.formMetadata.assignmentModel.id);
      },
    );
  }

  List<ReactiveChipOption<String>> _getChipOptions(
      List<AssignmentStatus> teams) {
    return teams
        .map((AssignmentStatus status) => ReactiveChipOption<String>(
              value: status.name,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildStatusBadge(status),
                    // const SizedBox(width: 20),
                    Text(Intl.message(status.name.toLowerCase()))
                  ]),
            ))
        .toList();
  }
}
