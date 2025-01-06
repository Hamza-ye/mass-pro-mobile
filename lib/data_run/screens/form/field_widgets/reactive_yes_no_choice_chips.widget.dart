import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
import 'package:datarun/data_run/screens/form/element/validation/form_element_validator.dart';
import 'package:datarun/data_run/screens/form/field_widgets/custom_reactive_widget/reactive_chip_option.dart';
import 'package:datarun/data_run/screens/form/field_widgets/custom_reactive_widget/reactive_choice_chips.dart';
import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveYesNoChoiceChips extends ConsumerWidget {
  const ReactiveYesNoChoiceChips({super.key, required this.element});

  final FieldInstance<bool> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

    return ReactiveChoiceChips<bool>(
      formControl: formInstance.form.control(element.elementPath!)
          as FormControl<bool>,
      validationMessages: validationMessages(context),
      selectedColor: Theme.of(context).colorScheme.error.withAlpha(100),
      // options: _getOptions(element.visibleOption, wide: false),
      options: _getOptions(context, wide: false),
      decoration: InputDecoration(
        // border: const OutlineInputBorder(gapPadding: 20),
        contentPadding: const EdgeInsets.all(16),
        labelText: element.label,
      ),
    );
  }

  List<ReactiveChipOption<bool>> _getOptions(BuildContext context,
      {bool? wide}) {
    return [true, false]
        .map((option) => ReactiveChipOption<bool>(
              value: option,
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(option ? S.of(context).yes : S.of(context).no),
                    ],
                  )),
            ))
        .toList();
  }
}
