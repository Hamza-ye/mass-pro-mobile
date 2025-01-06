// ignore_for_file: strict_raw_type

import 'package:d2_remote/core/datarun/utilities/date_utils.dart';
import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';

extension StringNullExtension on String? {
  DateTime? toDate() {
    DateTime? date;
    try {
      return DDateUtils.databaseDateFormat().parse(this ?? '');
    } catch (e) {
      logError('wrong DateTime format');
    }

    try {
      return DDateUtils.uiDateFormat().parse(this ?? '');
    } catch (e) {
      logError('wrong DateTime format');
    }

    try {
      return DDateUtils.oldUiDateFormat().parse(this ?? '');
    } catch (e) {
      logError('wrong DateTime format');
    }

    try {
      return DDateUtils.databaseDateFormatNoZone().parse(this ?? '');
    } catch (e) {
      logError('wrong DateTime format');
    }

    try {
      return DDateUtils.dateTimeFormat().parse(this ?? '');
    } catch (e) {
      logError('wrong DateTime format');
    }

    return date;
  }

  bool get isNullOrEmpty => this?.isEmpty ?? true;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool toBoolean() {
    return this == 'true' || this == 'TRUE';
  }

  double toDouble() => double.parse(this!);

  int toInt({int? radix}) => int.parse(this!, radix: radix);

  String? format(List args, {String needleRegex = '%s'}) {
    final RegExp exp = RegExp(needleRegex);

    int i = -1;
    return this?.replaceAllMapped(exp, (Match match) {
      i = i + 1;
      return '${args[i]}';
    });
  }
}

extension StringExtension on String {
  String format(List args, {String needleRegex = '%s'}) {
    final RegExp exp = RegExp(needleRegex);

    // Iterable<RegExpMatch> matches = exp.allMatches(this);
    // assert(
    //     l.length == matches.length,
    //     'StringExtension.format: number of string '
    //     'args not match number of %s in the string');

    int i = -1;
    return replaceAllMapped(exp, (Match match) {
      i = i + 1;
      return '${args[i]}';
    });
  }
}
