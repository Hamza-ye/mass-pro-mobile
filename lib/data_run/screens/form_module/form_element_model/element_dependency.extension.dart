// part of 'form_element_model.dart';
//
//
// extension ElementDependencyHandler<T> on FormElementModel<T> {
//   Map<String, dynamic> get evalContext {
//     return {
//       for (final dependency in _dependencies)
//         dependency.name: calculationFriendlyValue(dependency)
//     };
//   }
//
//   calculationFriendlyValue(FormElementModel<dynamic> dependency) {
//     if (!dependency.visible) {
//       return dependency.type.isNumeric ? 0 : null;
//     } else if (dependency.type.isNumeric && dependency.value == null) {
//       return 0;
//     } else {
//       return dependency.value;
//     }
//   }
//
//   FormElementState updateStatus(FormElementState newValue) {
//     // if (newValue != _elementState) {
//     _elementState = newValue;
//     propertiesChangedSubject?.add(newValue);
//     logDebug('$name, changed, --> Notifying subscribers');
//     notifySubscribers();
//
//     // } else {
//     // logDebug('$name, same, x not Notifying subscribers');
//     // }
//     return _elementState;
//   }
//
//   void addDependency(FormElementInstance<dynamic> dependency) {
//     _dependencies.add(dependency);
//     dependency._addDependent(this);
//   }
//
//   void removeDependent(FormElementInstance<dynamic> dependent) {
//     _dependents.remove(dependent);
//   }
//
//   void removeDependency(FormElementInstance<dynamic> dependency) {
//     _dependencies.remove(dependency);
//   }
//
//   void _addDependent(FormElementInstance<dynamic> dependent) {
//     _dependents.add(dependent);
//   }
//
//   // void addDependency(FormElementInstance<dynamic> dependency) {
//   //   addDependency(dependency);
//   //   dependency.addDependent(this);
//   // }
//
//   List<String> get resolvedDependentsNames =>
//       _dependents.map((dependent) => dependent.name).toList();
//
//   void notifySubscribers() {
//     logDebug('$name, notifying: ${resolvedDependentsNames}');
//     _dependents.forEach((s) => s.evaluate(name));
//   }
//
//   /// didUpdateElement(covariant FormElement<E> oldElement)
//   /// void didChange(ViewDataType value)
//   /// void didChangeDependencies()
// // void onDependencyChanged(String changedDependency, value) {
// //
// //   reEvaluateStatus();
// //   notifyDependents();
// // }
//
//   /// the element use name to find the dependency in closest parent
//   /// and register itself and add them to their dependencies
//   FormElementInstance<dynamic>? findElementInParentSection(String name) {
//     FormElementInstance<dynamic>? current = this;
//
//     while (current?.parentSection != null) {
//       current = current?.parentSection;
//       final found = current?.findElement(name);
//       if (found != null) return found;
//     }
//
//     return walkTreeForDependency(current!, name);
//   }
//
//   /// Recursively walk through all elements in the form tree and find a match
//   FormElementInstance<dynamic>? walkTreeForDependency(
//       FormElementInstance<dynamic> current, String name) {
//     if (current.name == name) {
//       return current;
//     }
//
//     if (current is SectionElement) {
//       final childElements = current is SectionInstance
//           ? current.elements.values
//           : (current as RepeatInstance).elements;
//       for (var nestedElement in childElements) {
//         var result = walkTreeForDependency(nestedElement, name);
//         if (result != null) {
//           return result;
//         }
//       }
//     }
//
//     return null;
//   }
//
// // void setNotifiers(Map<String, FormElementInstance<dynamic>> notifiers) {
// //   _unresolvedDependencies.clear();
// //   _unresolvedDependencies.addAll(
// //       requiredNotifiersNames.where((item) => !notifiers.keys.contains(item)));
// //   if (_unresolvedDependencies.length > 0) {
// //     loggerEvaluation.w({
// //       'unresolved dependencies': _unresolvedDependencies,
// //       'element': name,
// //     });
// //   }
// //
// //   _notifiers.addAll(notifiers);
// //   // final Listenable fff = Listenable.merge(notifiers.values);
// // }
// }
