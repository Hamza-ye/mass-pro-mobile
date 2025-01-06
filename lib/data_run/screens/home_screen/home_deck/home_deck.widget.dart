// import 'package:datarun/data_run/screens/home_screen/home_deck/home_item.model.dart';
// import 'package:datarun/data_run/screens/home_screen/home_deck/home_items.widget.dart';
// import 'package:datarun/data_run/screens/project_activity_detail/project_activities_screen.widget.dart';
// import 'package:datarun/data_run/screens/view/view_base.dart';
// import 'package:datarun/utils/navigator_key.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class HomeDeck extends ConsumerStatefulWidget {
//   const HomeDeck({super.key});
//
//   @override
//   ConsumerState<HomeDeck> createState() => _HomeDeckState();
// }
//
// class _HomeDeckState extends ConsumerState<HomeDeck> with ViewBase {
//   // Bundle bundle = Bundle();
//
//   @override
//   Widget build(BuildContext context) {
//     return HomeItemList(
//       onItemClick: (homeDeckItemModel) => navigateTo(homeDeckItemModel!),
//       onGranularSyncClick: (homeDeckItemModel) =>
//           showSyncDialog(homeDeckItemModel),
//       onDescriptionClick: (homeDeckItemModel) =>
//           homeDeckItemModel?.description != null
//               ? showDescription(homeDeckItemModel!.description!)
//               : null,
//     );
//   }
//
//   void navigateTo(HomeItemModel homeDeckItem) {
//     // bundle = bundle.putString(EXTRA_PROJECT_UID, homeDeckItem.uid);
//     // logInfo(info: '$EXTRA_PROJECT_UID, ${homeDeckItem.uid}');
//     // // navigatorKey.currentState!
//     //     .pushNamed(ProjectDetailScreenWidget.route, arguments: bundle);
//     Navigator.push(
//       navigatorKey.currentContext!,
//       MaterialPageRoute(
//           builder: (context) => ProjectActivitiesScreen(
//                 project: homeDeckItem.uid,
//               )),
//     );
//     // Get.to(const ProjectActivitiesScreenWidget(), arguments: bundle);
//     // ref
//     //     .read(appStateNotifierProvider.notifier)
//     //     .gotToNextRoute(ProjectDetailScreenWidget(), arguments: bundle);
//     // ref
//     //     .read(appStateNotifierProvider.notifier)
//     //     .navigateToScreen(const ProjectDetailScreenWidget(), bundle: bundle);
//     // Navigator.of(context).pushNamed(ProjectDetailScreenWidget.route, arguments: bundle);
//   }
//
//   void showFilterProgress() {
//     // TODO: implement showFilterProgress
//   }
//
//   void showHideFilter() {
//     // TODO: implement showHideFilter
//   }
//
//   @override
//   Future<void> showSyncDialog<DashboardItemModel>(
//       [DashboardItemModel? program]) async {}
// }
