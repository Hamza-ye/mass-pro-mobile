import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:datarun/data_run/screens/form_module/form_template/form_element_template.dart';

class FormStructureManager {

  FormStructureManager(
      {Map<String, dynamic> formValueMap = const {},
      required this.formVersion,
      required this.formFlatTemplate}) {
    _formValueMapBackup.addAll({...formValueMap});
    _formValueMap.addAll({...formValueMap});
  }
  final Map<String, dynamic> _formValueMapBackup = {};
  final Map<String, dynamic> _formValueMap = {};
  final FormVersion formVersion;
  final FormFlatTemplate formFlatTemplate;

  void resetForm() {
    _formValueMap.clear();
    _formValueMap.addAll(_formValueMapBackup);
  }

  void setFormValue(String elementId, dynamic value) {
    _formValueMap[elementId] = value;
  }

// bool isFormValid() {
//   for (final FormElementTemplate elementTemplate in formFlatTemplate.elements) {
//     final FormElementModel elementModel = FormElementModel(elementTemplate);
//     if (!elementModel.isValid(_formValueMap[elementTemplate.id])) {
//       return false;
//     }
//   }
//   return true;
// }
}
