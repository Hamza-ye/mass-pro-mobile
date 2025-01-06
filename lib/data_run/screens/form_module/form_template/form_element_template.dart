import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/attribute_type.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/scanned_code_properties.dart';
import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/option_set.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/rule.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarun/data_run/screens/form_module/form_template/form_element_template_iterator.dart';
import 'package:datarun/data_run/screens/form_module/form_template/flat_template_factory.dart';
import 'package:datarun/data_run/screens/form_module/form_template/path_walking_service.dart';

String? getParentPath(String? path) {
  final pathSegments = path?.split('.') ?? [];
  if (pathSegments.length > 1) {
    final parentPath =
        pathSegments.sublist(0, pathSegments.length - 1).join('.');
    return parentPath;
  }
  return null;
}

// @immutable
class FormFlatTemplate with PathWalkingService {
  factory FormFlatTemplate.fromTemplate(FormVersion template) {
    return FormFlatTemplate(
        formTemplate: template,
        fields: FlatTemplateFactory.flatTemplateWithPath(template.fields));
  }

  FormFlatTemplate({
    required this.formTemplate,
    List<FormElementTemplate> fields = const [],
  })  : this._optionLists = Map.fromIterable(
            (formTemplate.options)
              ..sort((p1, p2) => p1.order.compareTo(p2.order)),
            key: (option) => option.listName,
            value: (option) => formTemplate.options
                .where((o) => o.listName == option.listName)
                .toList()),
        rootElementTemplate = SectionElementTemplate(children: fields) {
    final itFields = getFormElementTemplateIterator(rootElementTemplate)
        .where((field) => field.path != null)
        .toList()
      ..sort((a, b) => (a.path!).compareTo(b.path!));
    for (final field in itFields) {
      _flatFields[field.path!] = field;
    }
  }

  final FormVersion formTemplate;
  final SectionElementTemplate rootElementTemplate;

  /// {listName: List<option>}
  final Map<String, List<FormOption>> _optionLists;

  String? get name => formTemplate.name;

  String? get code => formTemplate.code;

  String get defaultLocal => formTemplate.defaultLocal;

  // String get activity => formTemplate.activity;

  int get version => formTemplate.version;

  List<FormElementTemplate> get fields => flatFields.values.toList();

  // final List<FormElementTemplate> _flatFields = [];

  Map<String, FormElementTemplate> _flatFields = {};

  Map<String, FormElementTemplate> get flatFields =>
      Map.unmodifiable(_flatFields);

  Map<String, List<FormOption>> get optionLists =>
      Map.unmodifiable(_optionLists);

  List<DOptionSet> get optionSets => List.unmodifiable(formTemplate.optionSets);

  Map<String, String> get label => Map.unmodifiable(formTemplate.label);

  List<String> get orgUnits => <String>[];//List.unmodifiable(formTemplate.orgUnits);
}

// @immutable
sealed class FormElementTemplate with TreeElement/*, EquatableMixin*/ {
  FormElementTemplate({
    this.name,
    this.path,
    required this.runtimePath,
    this.readOnly = false,
    this.order = 0,
    this.fieldValueRenderingType,
    Iterable<Rule> rules = const [],
    Map<String, dynamic> label = const {},
    Map<String, dynamic> properties = const {},
    Iterable<String> ruleDependencies = const [],
  }) {
    _label.addAll(label);
    _rules.addAll(rules);
    _ruleDependencies.addAll(ruleDependencies);
    _properties.addAll(properties);
  }

  ValueType get type;

  final String? name;
  final bool readOnly;
  final String? path;
  final String? runtimePath;
  final int order;
  final String? fieldValueRenderingType;
  final Map<String, dynamic> _label = {};
  final List<Rule> _rules = [];
  final List<String> _ruleDependencies = [];
  final Map<String, dynamic> _properties = {};

  Map<String, String> get label => Map.unmodifiable(_label);

  List<Rule> get rules => List.unmodifiable(_rules);

  List<String> get ruleDependencies => List.unmodifiable(_ruleDependencies);

  Map<String, dynamic> get properties => Map.unmodifiable(_properties);

  List<FormElementTemplate> get children => List.unmodifiable([]);

  FormElementTemplate? _parent;

  FormElementTemplate? get parent => _parent;

  String get pathRecursive => pathBuilder(name);

  String pathBuilder(String? pathItem) {
    return [parent?.pathRecursive, pathItem].whereType<String>().join('.');
  }

  void setProperties(Map<String, dynamic> properties) {
    _properties.clear();
    _properties.addAll(properties);
  }

  void setLabel(Map<String, String> label) {
    _label.clear();
    _label.addAll(label);
  }

  void setRules(List<Rule> rules) {
    _rules.clear();
    _rules.addAll(rules);
  }

  void setRuleDependencies(List<String> ruleDependencies) {
    _ruleDependencies.clear();
    _ruleDependencies.addAll(ruleDependencies);
  }

  // @override
  // List<Object?> get props =>
  //     [type, name, path, order, _rules, _label, fieldValueRenderingType];
}

// @immutable
class FieldElementTemplate extends FormElementTemplate {
  FieldElementTemplate({
    required this.type,
    super.readOnly,
    super.name,
    super.path,
    super.runtimePath,
    super.order,
    super.fieldValueRenderingType,
    super.rules,
    super.ruleDependencies,
    super.properties,
    super.label,
    this.mainField = false,
    this.mandatory = false,
    this.calculation,
    this.listName,
    this.choiceFilter,
    this.defaultValue,
    this.attributeType,
    this.scannedCodeProperties,
    Iterable<FormOption> options = const [],
    Iterable<String> filterDependencies = const [],
  }) {
    _options.addAll(options);
    _filterDependencies.addAll(filterDependencies);
  }

  final ValueType type;
  final String? listName;
  final bool mainField;
  final bool mandatory;
  final String? choiceFilter;
  final dynamic defaultValue;
  final AttributeType? attributeType;
  final String? calculation;
  final ScannedCodeProperties? scannedCodeProperties;
  final List<FormOption> _options = [];

  /// <name, path>
  final List<String> _filterDependencies = [];

  List<FormOption> get options => List.unmodifiable(_options);

  Iterable<Map<String, dynamic>> get optionContext =>
      options.map((option) => option.toContext());

  List<String> get filterDependencies => List.unmodifiable(_filterDependencies);

  void setOptions(List<FormOption> options) {
    _options.clear();
    _options.addAll(options);
  }

  void setFilterDependencies(List<String> filterDependencies) {
    _filterDependencies.clear();
    _filterDependencies.addAll(filterDependencies);
  }
}

/// represent a Section or RepeatableSection, the ValueType tell which on it is
// @immutable
class SectionElementTemplate extends FormElementTemplate {
  SectionElementTemplate(
      {super.name,
      super.readOnly,
      super.runtimePath,
      super.path,
      super.order,
      super.fieldValueRenderingType,
      super.ruleDependencies,
      super.rules,
      super.label,
      super.properties,
      List<FormElementTemplate> children = const [],
      this.itemTitle}) {
    addAll(children);
  }

  final String? itemTitle;

  final List<FormElementTemplate> _children = [];

  List<FormElementTemplate> get children => List.unmodifiable(_children);

  void addAll(List<FormElementTemplate> children) {
    _children.clear();
    for (var child in children) {
      child._parent = this;
    }
    _children.addAll(children);
  }

  // @override
  // List<Object?> get props => super.props..addAll([itemTitle]);

  @override
  ValueType get type => ValueType.Section;
}

/// represent a Section or RepeatableSection, the ValueType tell which on it is
// @immutable
class RepeatElementTemplate extends SectionElementTemplate {
  RepeatElementTemplate(
      {super.name,
      super.readOnly,
      super.runtimePath,
      super.path,
      super.order,
      super.fieldValueRenderingType,
      super.ruleDependencies,
      super.rules,
      super.label,
      super.properties,
      super.children,
      this.repeatCount = 1,
      this.itemTitle});

  final String? itemTitle;
  final int repeatCount;

  add(FormElementTemplate child) {
    child._parent = this;
    _children.add(child);
  }

  @override
  ValueType get type => ValueType.RepeatableSection;

  // @override
  // List<Object?> get props => super.props..addAll([itemTitle]);
}
