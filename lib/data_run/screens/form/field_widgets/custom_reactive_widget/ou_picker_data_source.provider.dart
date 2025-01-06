import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:datarun/data_run/screens/form/element/form_metadata.dart';
import 'package:datarun/data_run/screens/form_ui_elements/org_unit_picker/model/data_model.provider.dart';
import 'package:datarun/data_run/screens/form_ui_elements/org_unit_picker/model/tree_node_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ou_picker_data_source.provider.g.dart';

@riverpod
Future<TreeNodeDataSource> ouPickerDataSource(OuPickerDataSourceRef ref,
    {required FormMetadata formMetadata}) async {
  final FormVersion template = await ref.watch(
      submissionVersionFormTemplateProvider(
              formId: formMetadata.formId)
          .future);

  final dataSourceValue = await ref.watch(treeNodeDataSourceProvider(
          selectableUids: /*(template?.orgUnits ?? [])*/ <String>[].lock)
      .future);

  return dataSourceValue;
}
