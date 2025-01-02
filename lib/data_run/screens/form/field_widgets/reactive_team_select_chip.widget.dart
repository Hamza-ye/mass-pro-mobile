import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
import 'package:datarun/data_run/screens/form/element/validation/form_element_validator.dart';
import 'package:datarun/data_run/screens/form/field_widgets/custom_reactive_widget/reactive_chip_option.dart';
import 'package:datarun/data_run/screens/form/field_widgets/custom_reactive_widget/reactive_choice_chips.dart';
import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:datarun/core/utils/get_item_local_string.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QReactiveTeamSelectChip extends ConsumerWidget {
  QReactiveTeamSelectChip({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

    final teamsAsync = ref.watch(teamsProvider(scope: EntityScope.Managed));

    return AsyncValueWidget(
      value: teamsAsync,
      valueBuilder: (List<DTeam> teams) {
        return ReactiveChoiceChips<String>(
            formControl: formInstance.form.control(element.elementPath!)
                as FormControl<String>,
            validationMessages: validationMessages(context),
            selectedColor: Theme.of(context).colorScheme.error.withAlpha(100),
            options: _getChipOptions(teams),
            decoration: InputDecoration(
              enabled: element.elementControl.enabled,
              labelText: element.label,
            ));
      },
    );
  }

  List<ReactiveChipOption<String>> _getChipOptions(List<DTeam> teams) {
    return teams
        .map((DTeam team) => ReactiveChipOption<String>(
              value: team.id!,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[Icon(Icons.group), Text(team.name!)]),
              ),
            ))
        .toList();
  }
}
