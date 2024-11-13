part of 'form_element_model.dart';

/// A section
class RepeatItemElementModel extends SectionElementModel {
  RepeatItemElementModel(
      {required String id,
      super.hidden,
      super.elements,
      required super.templatePath})
      : _id = id;

  final String _id;

  String get id => _id;

  int get sectionIndex => (parent as RepeatElementModel)
      .sectionIndexWhere((section) => section == this);

  @override
  String get name => '$sectionIndex';

  set parent(CollectionElementModel<dynamic>? parent) {
    if (parent is! RepeatElementModel) {
      throw StateError(
          'A RepeatItemInstance\'s Parent can only be a RepeatInstance, parent: ${parent.runtimeType}');
    }

    _parent = parent;
  }

  String pathBuilder(String? pathItem) {
    if (parent == null) {
      throw StateError('RepeatItemInstance\'s Parent should not be null');
    }

    if (!(parent is RepeatElementModel)) {
      throw StateError(
          'A RepeatItemInstance\'s Parent can only be a RepeatInstance, parent: ${parent.runtimeType}');
    }

    return [parent!.elementPath, pathItem].whereType<String>().join('.');
  }

  @override
  RepeatItemElementModel getInstance() => RepeatItemElementModel(
      templatePath: templatePath, id: CodeGenerator.generateCompositeUid());

  @override
  RepeatItemElementModel clone(CollectionElementModel<dynamic>? parent) {
    final instance = getInstance();
    instance.parent = parent;
    final elements =
        _elements.map((key, element) => MapEntry(key, element.clone(instance)));
    instance.setDependencies(List.from(dependencies));
    instance.addAll(elements);
    return instance;
  }
}
