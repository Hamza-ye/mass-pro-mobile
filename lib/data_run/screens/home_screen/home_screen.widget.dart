import 'package:d2_remote/core/datarun/utilities/date_utils.dart' as sdk;
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/core/auth/internet_aware_screen.dart';
import 'package:datarun/core/auth/user_session_manager.dart';
import 'package:datarun/core/network/online_connectivity_provider.dart';
import 'package:datarun/data_run/d_activity/activity_model.dart';
import 'package:datarun/data_run/d_activity/activity_page.dart';
import 'package:datarun/data_run/screens/home_screen/drawer/settings_page.dart';
import 'package:datarun/data_run/screens/sync_screen/sync_screen.widget.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:datarun/utils/navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarun/data_run/d_activity/activity_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, this.refresh = false});

  static String routeName = '/';

  final bool refresh;

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userInfoAsync = ref.watch(userInfoProvider);

    return AsyncValueWidget(
      value: userInfoAsync,
      valueBuilder: (userInfo) {
        final activitiesAsync = ref.watch(activitiesProvider);

        return AsyncValueWidget(
          value: activitiesAsync,
          valueBuilder: (List<ActivityModel> activities) {
            return Scaffold(
              appBar: InternetAwareAppBar(
                title: S.of(context).home,
              ),
              onDrawerChanged: (isOpen) {
                final hasValue = ref.read(isOnlineProvider).hasValue;
                isOpen && hasValue
                    ? ref.read(isOnlineProvider.notifier).check()
                    : null;
              },
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
                      style: ListTileStyle.drawer,
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
                    SyncButton(),
                  ],
                ),
              ),
              body: ActivityPage(
                activities: activities,
              ), // Main content
            );
          },
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.refresh) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.invalidate(activitiesProvider);
      });
    }
  }
}

class SyncButton extends ConsumerWidget {
  const SyncButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSessionManager = ref.watch(userSessionManagerProvider);
    final lastSyncTime = userSessionManager.lastSyncTime;

    return AsyncValueWidget(
      value: ref.watch(isOnlineProvider),
      valueBuilder: (bool isOnline) {
        return ListTile(
          style: ListTileStyle.drawer,
          leading: const Icon(Icons.sync),
          title: Text(S.of(context).fetchUpdates),
          subtitle: lastSyncTime != null
              ? Text(sdk.DDateUtils.dateTimeFormat().format(lastSyncTime))
              : Text(S.of(context).noSyncYet),
          trailing: isOnline
              ? Icon(Icons.check_circle,
                  color:
                      userSessionManager.syncDone ? Colors.green : Colors.red)
              : Icon(MdiIcons.webOff, color: Colors.grey),
          onTap: isOnline
              ? () {
                  Navigator.pop(context);
                  Navigator.push(
                    navigatorKey.currentContext!,
                    MaterialPageRoute(builder: (context) => const SyncScreen()),
                  );
                }
              : null,
        );
      },
    );
  }
}
