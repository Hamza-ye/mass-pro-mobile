import 'package:flutter/material.dart';
import 'package:mass_pro/commons/logging/logging.dart';

Widget getErrorWidget(Object? error, StackTrace? stackTrace) {
  logError(error: 'error: $error');
  debugPrintStack(stackTrace: stackTrace, label: error.toString());
  return Builder(
    builder: (context) {
      return Center(
        child: Text(
          'Error $error',
          style: Theme
              .of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.red),
        ),
      );
    }
  );
}
