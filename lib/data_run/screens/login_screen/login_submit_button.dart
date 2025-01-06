import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginSubmitButton extends StatelessWidget {
  const LoginSubmitButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    return FilledButton(
      child: Text(S.of(context).login),
      onPressed: form!.valid ? onPressed : null,
    );
  }
}
