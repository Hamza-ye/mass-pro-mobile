import 'package:datarun/core/element_instance/field_state/field_state.dart';
import 'package:datarun/core/element_instance/repeat_instance/repeat_state.dart';
import 'package:datarun/core/element_instance/sction_instance/section_state.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';

abstract class ElementVisitor {
  void visitField(FieldState field);

  void visitSection(SectionState section);

  void visitRepeatSection(RepeatState section);

  void visitRepeatItem(RepeatItemInstance section);
}

