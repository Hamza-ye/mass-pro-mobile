import 'package:d2_remote/core/datarun/utilities/date_utils.dart' as sdk;
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/core/auth/internet_aware_screen.dart';
import 'package:datarun/core/auth/user_session_manager.dart';
import 'package:datarun/core/sync_manager/sync_service.dart';
import 'package:datarun/data_run/d_activity/activity_page.dart';
import 'package:datarun/data_run/screens/home_screen/drawer/settings_page.dart';
import 'package:datarun/data_run/screens/sync_screen/sync_screen.widget.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:datarun/utils/navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen(
      {super.key, this.launchDataSync = false, this.forceToNotSynced = false});

  static String routeName = '/';

  final bool forceToNotSynced;

  final bool launchDataSync;

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userSessionManager = ref.watch(userSessionManagerProvider);
    final lastSyncTime = userSessionManager.lastSyncTime;
    final userInfoAsync = ref.watch(userInfoProvider);
    return AsyncValueWidget(
      value: userInfoAsync,
      valueBuilder: (userInfo) {
        return Scaffold(
          appBar: InternetAwareAppBar(
            title: S.of(context).home,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(userInfo?.firstName ?? '-'),
                  accountEmail: Text(userInfo?.username ?? '-'),
                  currentAccountPicture: CircleAvatar(
                    child: Text(userInfo?.firstName?.substring(0, 1) ?? ''),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(S.of(context).settings),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        navigatorKey.currentContext!,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ));
                  },
                ),
                Divider(),
                ListTile(
                  leading: const Icon(Icons.sync),
                  title: Text(S.of(context).fetchUpdates),
                  subtitle: lastSyncTime != null
                      ? Text(
                          sdk.DDateUtils.dateTimeFormat().format(lastSyncTime))
                      : Text(S.of(context).noSyncYet),
                  trailing: Icon(Icons.check_circle,
                      color: userSessionManager.syncDone
                          ? Colors.green
                          : Colors.red),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      navigatorKey.currentContext!,
                      MaterialPageRoute(
                          builder: (context) => const SyncScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          // body: const HomeDeck(), // Main content
          body: const ActivityPage(), // Main content
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndSync();
    });
  }

  Future<void> _checkAndSync() async {
    final syncService = ref.read(syncServiceProvider.notifier);
    if ((await syncService.needsSync()) || widget.launchDataSync) {
      Navigator.push(
        navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const SyncScreen()),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.refresh(homeItemsModelsNotifierProvider);
    });
  }
}
