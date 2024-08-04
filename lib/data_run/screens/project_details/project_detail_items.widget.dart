import 'package:fast_immutable_collections/src/ilist/ilist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mass_pro/data_run/screens/project_details/activity_item_expansion_tile.widget.dart';
import 'package:mass_pro/data_run/screens/project_details/project_detail_item.model.dart';
import 'package:mass_pro/data_run/screens/project_details/project_detail_items_models_notifier.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ProjectDetailItemsWidget extends ConsumerStatefulWidget {
  const ProjectDetailItemsWidget({
    super.key,
    required this.onItemClick,
    required this.onGranularSyncClick,
    this.onDescriptionClick,
  });

  final void Function(ProjectDetailItemModel? programViewModel)? onItemClick;
  final void Function(ProjectDetailItemModel? programViewModel)?
      onGranularSyncClick;
  final void Function(ProjectDetailItemModel? programViewModel)?
      onDescriptionClick;

  @override
  ConsumerState<ProjectDetailItemsWidget> createState() =>
      _ProjectItemsWidgetState();
}

class _ProjectItemsWidgetState extends ConsumerState<ProjectDetailItemsWidget> {
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    final AsyncValue<IList<ProjectDetailItemModel>> value =
        ref.watch(projectDetailItemsModelsNotifierProvider);
    return value.when(
        data: (IList<ProjectDetailItemModel> data) =>
            ScrollablePositionedList.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) => ProviderScope(
                overrides: <Override>[
                  projectDetailItemModelProvider
                      .overrideWith((_) => data[index])
                ],
                child: ActivityItemsExpansionTiles(
                  onGranularSyncClick:
                      (ProjectDetailItemModel? programViewModel) =>
                          widget.onGranularSyncClick?.call(programViewModel),
                  onDescriptionClick:
                      (ProjectDetailItemModel? programViewModel) =>
                          widget.onDescriptionClick?.call(programViewModel),
                ),
              ),
              itemScrollController: itemScrollController,
            ),
        error: (Object error, StackTrace s) {
          debugPrint('error: $error');
          debugPrintStack(stackTrace: s, label: error.toString());
          return Text('Error: $error');
        },
        loading: () => const CircularProgressIndicator());
  }
}
