// import 'package:d2_remote/d2_remote.dart';
// import 'package:d2_remote/modules/metadatarun/project/entities/d_project.entity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:datarun/data_run/screens/project_activity_detail/project_activities_cards.widget.dart';
// import 'package:datarun/data_run/screens/view/view_base.dart';
// import 'package:datarun/riverpod/use_on_init_hook.dart';
//
// /// List Activities of certain project
// class ProjectActivitiesScreen extends ConsumerStatefulWidget
//     with ViewBase {
//   const ProjectActivitiesScreen({super.key, required this.project});
//
//   static const String route = '/projects/detail';
//
//   final String project;
//
//   @override
//   ConsumerState<ProjectActivitiesScreen> createState() =>
//       _ProjectDetailScreenWidgetState();
// }
//
// class _ProjectDetailScreenWidgetState
//     extends ConsumerState<ProjectActivitiesScreen> with ViewBase {
//   late final String projectUid;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(ref.watch(projectNameProvider)),
//       ),
//       body: ProjectActivitiesCards(
//         onDescriptionClick: (activity) =>
//             showDescription(activity.description ?? ''),
//         project: projectUid,
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     projectUid = widget.project;
//     D2Remote.projectModuleD.project
//         .byId(projectUid)
//         .getOne()
//         .then((project) => setProject(project!));
//     super.initState();
//   }
//
//   void setProject(DProject project) {
//     useOnInit(() => ref
//         .read(projectNameProvider.notifier)
//         .update((String state) => project.displayName ?? project.name ?? ''));
//   }
//
//   @override
//   Future<void> showSyncDialog<ProjectItemModel>(
//       [ProjectItemModel? program]) async {}
// }
//
// final AutoDisposeStateProvider<String> projectNameProvider =
//     StateProvider.autoDispose<String>(
//         (AutoDisposeStateProviderRef<String> ref) => '');
