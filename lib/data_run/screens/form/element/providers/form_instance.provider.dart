import 'dart:async';
import 'dart:io';

import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/section_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:datarun/data_run/form/form_element_factories/form_element_builder.dart';
import 'package:datarun/data_run/form/form_element_factories/form_element_control_builder.dart';
import 'package:datarun/data_run/form/form_template/template_providers.dart';
import 'package:datarun/data_run/screens/form/element/form_metadata.dart';
import 'package:datarun/data_run/screens/form/element/service/device_info_service.dart';
import 'package:datarun/data_run/screens/form/element/form_instance.dart';
import 'package:datarun/data_run/screens/form/element/service/form_instance_service.dart';
import 'package:datarun/data_run/screens/form_module/form_template/form_element_template.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_instance.provider.g.dart';

@riverpod
Future<AndroidDeviceInfoService> userDeviceInfoService(
    UserDeviceInfoServiceRef ref) async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  final deviceInfo =
      Platform.isAndroid ? await deviceInfoPlugin.androidInfo : null;
  final deviceService = AndroidDeviceInfoService(deviceInfo: deviceInfo);
  return deviceService;
}

@riverpod
Future<FormFlatTemplate> formFlatTemplate(FormFlatTemplateRef ref,
    {required FormMetadata formMetadata}) async {
  final formVersion = await ref.watch(formVersionAsyncProvider(
          form: formMetadata.form, version: formMetadata.version)
      .future);

  return FormFlatTemplate.fromTemplate(formVersion);
}

@riverpod
Future<FormInstanceService> formInstanceService(FormInstanceServiceRef ref,
    {required FormMetadata formMetadata}) async {
  final userDeviceService =
      await ref.watch(userDeviceInfoServiceProvider.future);

  return FormInstanceService(
      formMetadata: formMetadata, deviceInfoService: userDeviceService);
}

@riverpod
Future<FormInstance> formInstance(FormInstanceRef ref,
    {required FormMetadata formMetadata}) async {
  final enabled = await D2Remote.formModule.dataFormSubmission
      .byId(formMetadata.submission!)
      .canEdit();

  final submission = await D2Remote.formModule.dataFormSubmission
      .byId(formMetadata.submission!)
      .getOne();

  final Map<String, dynamic>? initialFormValue = submission.formData;

  final formInstanceService = await ref
      .watch(formInstanceServiceProvider(formMetadata: formMetadata).future);

  final formFlatTemplate = await ref
      .watch(formFlatTemplateProvider(formMetadata: formMetadata).future);

  final form = FormGroup(FormElementControlBuilder.formDataControls(
      formFlatTemplate, initialFormValue));

  final elements = FormElementBuilder.buildFormElements(form, formFlatTemplate,
      initialFormValue: initialFormValue);

  final _formSection = SectionInstance(
      template: SectionTemplate(type: ValueType.Unknown, path: null),
      elements: elements,
      form: form)
    ..resolveDependencies()
    ..evaluate();
  final attributeMap =
      await formInstanceService.formAttributesControls(initialFormValue);

  return FormInstance(ref,
      enabled: enabled,
      initialValue: {...?initialFormValue, ...attributeMap},
      elements: elements,
      formMetadata: formMetadata,
      form: form,
      rootSection: _formSection,
      formFlatTemplate: formFlatTemplate);
}
