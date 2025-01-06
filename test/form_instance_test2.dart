// import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
// import 'package:d2_remote/modules/datarun/form/shared/field_template/field_template.entity.dart';
// import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
// import 'package:flutter/foundation.dart';
// import 'package:datarun/data_run/screens/form/element/form_element_members.dart';
// import 'package:datarun/data_run/screens/form/element/form_element_model.dart';
// import 'package:datarun/data_run/screens/form/element/form_instance.dart';
// import 'package:test/test.dart';
//
// void main() {
//   group('FormInstance Tests', () {
//     late FormTemplateV formTemplate;
//     late FormInstance formInstance;
//     late FieldTemplate nameTemplate;
//     late FieldTemplate ageTemplate;
//     late FieldTemplate personalInfoTemplate;
//     late FieldTemplate emailTemplate;
//     late FieldTemplate phoneTemplate;
//     late FieldTemplate addressSectionTemplate;
//     late FieldTemplate addressTemplate;
//     late FieldTemplate cityTemplate;
//
//     setUp(() {
//       // Mocking a form template with various types of value
//       nameTemplate = FieldTemplate(
//         name: 'name',
//         type: ValueType.Text,
//         // properties: FormElementState(disabled: false),
//         defaultValue: '',
//         mandatory: false,
//         mainField: false,
//         path: '',
//       );
//       ageTemplate = FieldTemplate(
//         name: 'age',
//         type: ValueType.Integer,
//         // properties: FormElementState(disabled: false),
//         defaultValue: 18,
//         mandatory: false,
//         mainField: false,
//         path: '',
//       );
//       emailTemplate = FieldTemplate(
//         name: 'email',
//         type: ValueType.Text,
//         // properties: FormElementState(disabled: false),
//         defaultValue: '',
//         mandatory: false,
//         mainField: false,
//         path: '',
//       );
//       phoneTemplate = FieldTemplate(
//         name: 'phone',
//         type: ValueType.Text,
//         // properties: FormElementState(disabled: false),
//         defaultValue: '',
//         mandatory: false,
//         mainField: false,
//         path: '',
//       );
//       personalInfoTemplate = FieldTemplate(
//         name: 'personalInfo',
//         type: ValueType.Section,
//         // properties: FormElementState(disabled: false),
//         mandatory: false,
//         mainField: false,
//         path: '',
//         fields: [
//           emailTemplate,
//           phoneTemplate,
//         ],
//       );
//       addressTemplate = FieldTemplate(
//         name: 'address',
//         type: ValueType.Text,
//         // properties: FormElementState(disabled: false),
//         defaultValue: '',
//         mandatory: false,
//         mainField: false,
//         path: '',
//       );
//       cityTemplate = FieldTemplate(
//         name: 'city',
//         type: ValueType.Text,
//         // properties: FormElementState(disabled: false),
//         defaultValue: '',
//         mandatory: false,
//         mainField: false,
//         path: '',
//       );
//
//       addressSectionTemplate = FieldTemplate(
//         name: 'addressSection',
//         type: ValueType.RepeatableSection,
//         // properties: FormElementState(disabled: false),
//         mandatory: false,
//         mainField: false,
//         path: '',
//         fields: [
//           addressTemplate,
//           cityTemplate,
//         ],
//       );
//
//       formTemplate = FormTemplateV(fields: [
//         nameTemplate,
//         ageTemplate,
//         personalInfoTemplate,
//         addressSectionTemplate,
//       ], activity: '', version: 1, defaultLocal: '', dirty: false);
//
//       // Initializing a FormInstance with the above template
//       formInstance = FormInstance(template: formTemplate);
//       formInstance.initializeFormElements();
//     });
//
//     test('Initial form values are correctly populated', () {
//       // Test that the form is initialized with the correct default values
//       expect(formInstance.elements['name']?.name, 'name');
//       expect(
//           formInstance.elements['name']?.value, ''); // Name field default value
//
//       expect(formInstance.elements['age']?.name, 'age');
//       expect(
//           formInstance.elements['age']?.value, 18); // Age field default value
//
//       SectionInstance personalInfo =
//           formInstance.elements['personalInfo'] as SectionInstance;
//       expect(personalInfo.name, 'personalInfo');
//       expect(personalInfo.elements['email']?.name, 'email');
//       expect(personalInfo.elements['email']?.value,
//           ''); // Email field default value
//       expect(personalInfo.elements['phone']?.name, 'phone');
//       expect(personalInfo.elements['phone']?.value,
//           ''); // Phone field default value
//     });
//
//     test('Repeat section initializes with no entries', () {
//       // Test that the repeat section starts empty
//       RepeatSectionInstance repeatSection =
//           formInstance.elements['addressSection'] as RepeatSectionInstance;
//       expect(repeatSection.name, 'addressSection');
//       expect(repeatSection.elements.isEmpty, true); // No addresses yet
//     });
//
//     test('Add and remove repeated value', () {
//       // Add repeated sections
//       RepeatSectionInstance repeatSection =
//           formInstance.elements['addressSection'] as RepeatSectionInstance;
//       repeatSection.add(
//         SectionInstance(
//           name: 'addressSection',
//           type: ValueType.Section,
//           properties: FormElementState(disabled: false),
//           elements: {
//             'address': FieldInstance(
//               name: 'address',
//               type: ValueType.Text,
//               properties: FormElementState(disabled: false),
//               value: '123 Street',
//               form: formInstance.form,
//               template: addressTemplate,
//             ),
//             'city': FieldInstance(
//               name: 'city',
//               type: ValueType.Text,
//               properties: FormElementState(disabled: false),
//               value: 'New York',
//               form: formInstance.form,
//               template: cityTemplate,
//             ),
//           },
//           template: addressTemplate,
//           form: formInstance.form,
//         ),
//       );
//
//       repeatSection.add(SectionInstance(
//         name: 'addressSection',
//         type: ValueType.Section,
//         properties: FormElementState(disabled: false),
//         elements: {
//           'address': FieldInstance(
//             name: 'address',
//             type: ValueType.Text,
//             properties: FormElementState(disabled: false),
//             value: '456 Avenue',
//             form: formInstance.form,
//             template: addressTemplate,
//           ),
//           'city': FieldInstance(
//             name: 'city',
//             type: ValueType.Text,
//             properties: FormElementState(disabled: false),
//             value: 'Los Angeles',
//             form: formInstance.form,
//             template: cityTemplate,
//           ),
//         },
//         template: addressSectionTemplate,
//         form: formInstance.form,
//       ));
//
//       // Test if repeated value are added correctly
//       expect(repeatSection.elements.length, 2);
//       expect(
//           (repeatSection.elements[0] as SectionElement)
//               .element('address')
//               .value,
//           '123 Street');
//       expect(
//           (repeatSection.elements[1] as SectionElement).element('city').value,
//           'Los Angeles');
//
//       // Remove one entry
//       repeatSection.removeAt(0);
//       expect(repeatSection.elements.length, 1);
//       expect(
//           (repeatSection.elements[0] as SectionElement)
//               .element('address')
//               .value,
//           '456 Avenue');
//     });
//
//     test('Form raw values are flattened correctly', () {
//       // Test if the form values are flattened for saving/submission
//       RepeatSectionInstance repeatSection =
//           formInstance.elements['addressSection'] as RepeatSectionInstance;
//       repeatSection.add(SectionInstance(
//         name: 'addressSection',
//         type: ValueType.Section,
//         properties: FormElementState(disabled: false),
//         elements: {
//           'address': FieldInstance(
//             name: 'address',
//             type: ValueType.Text,
//             properties: FormElementState(disabled: false),
//             value: '789 Boulevard',
//             form: formInstance.form,
//             template: addressTemplate,
//           ),
//           'city': FieldInstance(
//             name: 'city',
//             type: ValueType.Text,
//             properties: FormElementState(disabled: false),
//             value: 'Chicago',
//             form: formInstance.form,
//             template: cityTemplate,
//           ),
//         },
//         template: addressSectionTemplate,
//         form: formInstance.form,
//       ));
//
//       Map<String, dynamic> rawValue = formInstance.rawValue;
//
//       expect(rawValue['formData']['name'], '');
//       expect(rawValue['formData']['age'], 18);
//       expect(rawValue['formData']['personalInfo']['email'], '');
//       expect(rawValue['formData']['personalInfo']['phone'], '');
//       expect(rawValue['formData']['addressSection'][0]['address'],
//           '789 Boulevard');
//       expect(rawValue['formData']['addressSection'][0]['city'], 'Chicago');
//     });
//
//     test('Update form data from saved data', () {
//       // Mock saved data to update the form
//       final savedData = {
//         'name': 'John Doe',
//         'age': 25,
//         'personalInfo': {
//           'email': 'john@example.com',
//           'phone': '555-1234',
//         },
//         'addressSection': [
//           {
//             'address': '100 First St',
//             'city': 'Boston',
//           },
//           {
//             'address': '200 Second St',
//             'city': 'Seattle',
//           },
//         ],
//       };
//
//       formInstance.updateFormData(savedData);
//
//       expect(formInstance.elements['name']?.value, 'John Doe');
//       expect(formInstance.elements['age']?.value, 25);
//
//       SectionInstance personalInfo =
//           formInstance.elements['personalInfo'] as SectionInstance;
//       debugPrint('email.path: ${personalInfo.element('email').pathRecursive}');
//
//       expect(personalInfo.element('email').pathRecursive,
//           'personalInfo.email');
//
//       expect(personalInfo.element('email').value, 'john@example.com');
//       expect(personalInfo.element('phone').value, '555-1234');
//
//       RepeatSectionInstance repeatSection =
//           formInstance.elements['addressSection'] as RepeatSectionInstance;
//
//       expect(repeatSection.elements.length, 2);
//
//       debugPrint(
//           'address.path: ${(repeatSection.elements[0] as SectionElement).element('address').pathRecursive}');
//       expect(
//           (repeatSection.elements[0] as SectionElement)
//               .element('address')
//               .pathRecursive,
//           'addressSection.0.address');
//       expect(
//           (repeatSection.elements[0] as SectionElement)
//               .element('address')
//               .value,
//           '100 First St');
//       expect(
//           (repeatSection.elements[0] as SectionElement).element('city').value,
//           'Boston');
//       expect(
//           (repeatSection.elements[1] as SectionElement)
//               .element('address')
//               .value,
//           '200 Second St');
//       expect(
//           (repeatSection.elements[1] as SectionElement).element('city').value,
//           'Seattle');
//     });
//   });
// }
