import 'package:datarun/data_run/screens/home_screen/home_screen.widget.dart';
import 'package:datarun/data_run/screens/login_screen/login_page.dart';
import 'package:datarun/data_run/screens/sync_screen/sync_screen.widget.dart';
import 'package:flutter/material.dart';

class AuthSyncWrapper extends StatelessWidget {
  const AuthSyncWrapper({
    Key? key,
    required this.isAuthenticated,
    required this.needsSync,
  }) : super(key: key);
  final bool isAuthenticated;
  final bool needsSync;

  @override
  Widget build(BuildContext context) {
    return isAuthenticated
        ? (needsSync ? SyncScreen() : HomeScreen())
        : LoginPage();
  }
}
