import 'package:d2_remote/modules/datarun/form/shared/field_template/field_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/section_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/rule_parse_extension.dart';
import 'package:d2_remote/modules/datarun/form/shared/template_extensions/form_traverse_extension.dart';
import 'package:datarun/data_run/screens/form_module/form_template/form_element_template.dart';

class FlatTemplateFactory {
  static List<FormElementTemplate> flatTemplateWithPath(
      List<Template> templates,
      {String? initialPath,
      String? initialRuntimePath}) {
    List<FormElementTemplate> result = [];
    for (var template in templates) {
      result.addAll(_flattenElementTemplate(template,
          prefix: initialPath, runtimePrefix: initialRuntimePath));
    }
    return result;
  }

  static List<FormElementTemplate> _flattenElementTemplate(Template template,
      {String? prefix, String? runtimePrefix}) {
    List<FormElementTemplate> result = [];
    String fullPrefix =
        prefix != null ? '$prefix.${template.name}' : template.name!;
    String fullRuntimePrefix = runtimePrefix != null
        ? '$runtimePrefix.${template.name}.{key}'
        : '${template.name!}.{key}';
    if (template.isSection) {
      template as SectionTemplate;
      result.add(SectionElementTemplate(
          name: template.name,
          label: template.label.unlockView,
          order: template.order,
          fieldValueRenderingType: template.fieldValueRenderingType,
          path: fullPrefix,
          runtimePath: fullRuntimePrefix,
          properties: template.properties?.unlockView ?? {},
          rules: template.rules,
          itemTitle: template.itemTitle,
          // fieldValueRenderingType: template.fieldValueRenderingType,
          ruleDependencies: template.dependencies,
          children: flatTemplateWithPath(template.fields.unlockView,
              initialPath: fullPrefix, initialRuntimePath: fullRuntimePrefix)));
      // result.addAll(
      //     flatTemplateWithPath(template.fields, initialPath: fullPrefix));
    } else if (template.isRepeat) {
      template as SectionTemplate;
      result.add(RepeatElementTemplate(
          name: template.name,
          label: template.label.unlockView,
          order: template.order,
          fieldValueRenderingType: template.fieldValueRenderingType,
          path: fullPrefix,
          runtimePath: fullRuntimePrefix,
          properties: template.properties?.unlockView ?? {},
          rules: template.rules,
          itemTitle: template.itemTitle,
          ruleDependencies: template.dependencies,
          // pathTemplate: '${fullPrefix}.{key}',
          children: flatTemplateWithPath(template.fields.unlockView,
              initialPath: fullPrefix, initialRuntimePath: fullRuntimePrefix)));
      // result.addAll(
      //     flatTemplateWithPath(template.fields, initialPath: fullPrefix));
    } else if (!template.isSection) {
      template as FieldTemplate;
      result.add(FieldElementTemplate(
        type: template.type!,
        readOnly: template.readOnly,
        name: template.name,
        order: template.order,
        listName: template.listName,
        label: template.label.unlockView,
        path: fullPrefix,
        runtimePath: fullRuntimePrefix,
        mandatory: template.mandatory,
        mainField: template.mainField,
        rules: template.rules,
        // referenceInfo: template.referenceInfo,
        choiceFilter: template.choiceFilter,
        defaultValue: template.defaultValue,
        options: template.options,
        // calculation: template.calculation,
        scannedCodeProperties: template.scannedCodeProperties,
        filterDependencies: template.filterDependencies,
        ruleDependencies: template.dependencies,
      ));
    }

    return result;
  }
}
