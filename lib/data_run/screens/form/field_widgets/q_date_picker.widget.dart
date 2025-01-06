import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:d2_remote/core/datarun/utilities/date_utils.dart' as sdk;

class QDatePickerField<T> extends ConsumerWidget {
  const QDatePickerField({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;
    formInstance.form.control(element.elementPath!) as FormControl<T>;
    return ReactiveTextField<String>(
      // formControl: element.elementControl,
      formControl: formInstance.form.control(element.elementPath!)
          as FormControl<String>,
      readOnly: true,
      valueAccessor: QDateTimeValueAccessor(),
      decoration: InputDecoration(
        enabled: element.elementControl.enabled,
        labelText: element.label,
        suffixIcon: ReactiveDatePicker<String?>(
          formControl: element.elementControl as FormControl<String?>,
          firstDate: DateTime(2015, 1, 1),
          lastDate: DateTime(2040, 1, 1),
          builder: (context, picker, child) {
            return IconButton(
              onPressed:
                  element.elementControl.enabled ? picker.showPicker : null,
              icon: const Icon(Icons.date_range),
            );
          },
        ),
      ),
    );
  }
}

class QDateTimeValueAccessor<T> extends ControlValueAccessor<String, String> {
  /// Returns the value that must be supplied to the [control].
  ///
  /// Converts value from UI data type to [control] data type.
  @override
  String? modelToViewValue(String? modelValue) {
    return modelValue == null ? null : sdk.DDateUtils.format(modelValue);
  }

  /// Returns the value that must be supplied to the UI widget.
  ///
  /// Converts value from [control] data type to UI data type.
  @override
  String? viewToModelValue(String? viewValue) {
    return viewValue == null ? null : sdk.DDateUtils.formatForDb(viewValue);
  }
}
