import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarun/data_run/screens/form/element_widgets/popup_section.widget.dart';
import 'package:datarun/data_run/screens/form/field_widgets/q_barcode_reader_field.dart';
import 'package:datarun/data_run/screens/form/field_widgets/reactive_team_select_chip.widget.dart';
import 'package:datarun/data_run/screens/form/field_widgets/reference_search/q_reference_drop_down_search_field.widget.dart';
import 'package:datarun/data_run/screens/form/form_with_sliver/repeat_table.widget.dart';
import 'package:flutter/material.dart';
import 'package:datarun/data_run/screens/form/field_widgets/reactive_choice_single_select_chip.widget.dart';
import 'package:datarun/data_run/screens/form/field_widgets/q_date_picker.widget.dart';
import 'package:datarun/data_run/screens/form/field_widgets/q_drop_down_multi_select_field.widget.dart';
import 'package:datarun/data_run/screens/form/field_widgets/reactive_ou_picker_field.dart';
import 'package:datarun/data_run/screens/form/field_widgets/q_switch_field.widget.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:datarun/data_run/screens/form/element_widgets/field.widget.dart';
import 'package:datarun/data_run/screens/form/field_widgets/q_drop_down_with_search_field.widget.dart';
import 'package:datarun/data_run/screens/form/field_widgets/q_text_type_field.widget.dart';
import 'package:datarun/data_run/screens/form/field_widgets/reactive_yes_no_choice_chips.widget.dart';

import '../field_widgets/reactive_progress_select_chip.widget.dart';

/// Factory that instantiate form input fields based on a dynamic element tree
class PopupFormElementWidgetFactory {
  static Widget createWidget(FormElementInstance<dynamic> element) {
    return switch (element) {
      FieldInstance() =>
        FieldWidget(key: ValueKey(element.elementPath), element: element),
      RepeatInstance() => RepeatTable(
          key: Key(element.elementPath!),
          repeatInstance: element,
        ),
      SectionInstance() => PopupSectionWidget(
          key: ValueKey(element.elementPath), element: element),
      // // TODO: Handle this case.
      // RepeatScanInstance() => throw UnimplementedError(),
      // TODO: Handle this case.
      // RepeatScanInstance() => throw UnimplementedError(),
    };
  }
}

/// a Factory that is called by the [FieldWidget] to create the input widget based on ValueType of element
class FieldFactory {
  static Widget fromType<T>(FieldInstance<T> element) {
    switch (element.type) {
      case ValueType.Text:
      case ValueType.LongText:
      case ValueType.Letter:
      case ValueType.Email:
      case ValueType.FullName:
      case ValueType.Integer:
      case ValueType.IntegerPositive:
      case ValueType.IntegerNegative:
      case ValueType.IntegerZeroOrPositive:
      case ValueType.Number:
      case ValueType.Age:
        return QTextTypeField(element: element);
      case ValueType.Date:
      case ValueType.Time:
      case ValueType.DateTime:
        return QDatePickerField(element: element as FieldInstance<String>);
      case ValueType.Boolean:
      case ValueType.YesNo:
        return ReactiveYesNoChoiceChips(
            element: element as FieldInstance<bool>);
      case ValueType.TrueOnly:
        return QSwitchField(element: element as FieldInstance<bool>);
      case ValueType.OrganisationUnit:
        return QOrgUnitPickerField(element: element as FieldInstance<String>);
      case ValueType.Progress:
        return QReactiveProgressSelectChip(
            element: element as FieldInstance<String>);
      case ValueType.Team:
        return QReactiveTeamSelectChip(
            element: element as FieldInstance<String>);
      case ValueType.SelectOne:
        if ((element.choiceFilter?.options ?? element.visibleOption).length <=
            6) {
          return QReactiveChoiceSingleSelectChips(
              element: element as FieldInstance<String>);
        } else {
          return QDropDownWithSearchField(
              element: element as FieldInstance<String>);
        }

      case ValueType.SelectMulti:
        return QDropDownMultiSelectWithSearchField(
            element: element as FieldInstance<List<String>>);
      case ValueType.ScannedCode:
        // return QTextTypeField(element: element);
        return QBarcodeReaderField(element: element as FieldInstance<String>);
      case ValueType.Reference:
        return QReferenceDropDownSearchField(
            element: element as FieldInstance<String>);
      default:
        return Text('Unsupported element type: ${element.type}');
    }
  }
}
