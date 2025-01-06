import 'package:datarun/data_run/screens/form_ui_elements/get_error_widget.dart';
import 'package:datarun/data_run/screens/home_screen/home_deck/home_item.model.dart';
import 'package:datarun/data_run/screens/home_screen/home_deck/home_item.widget.dart';
import 'package:datarun/data_run/screens/home_screen/home_deck/home_items_models_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeItemList extends ConsumerStatefulWidget {
  const HomeItemList({
    super.key,
    required this.onItemClick,
    required this.onGranularSyncClick,
    this.onDescriptionClick,
  });

  final void Function(HomeItemModel? homeDeckItemModel)? onItemClick;
  final void Function(HomeItemModel? homeDeckItemModel)? onGranularSyncClick;
  final void Function(HomeItemModel? homeDeckItemModel)? onDescriptionClick;

  @override
  ConsumerState<HomeItemList> createState() => _DashboardItemsWidgetState();
}

class _DashboardItemsWidgetState extends ConsumerState<HomeItemList> {
  final ScrollController itemScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(homeItemsModelsNotifierProvider);
    return value.when(
        data: (data) => ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) => ProviderScope(
                overrides: [
                  homeItemModelProvider.overrideWith((_) => data[index])
                ],
                child: HomeItem(
                  onItemClick: (homeDeckItemModel) =>
                      widget.onItemClick?.call(homeDeckItemModel),
                  onGranularSyncClick: (homeDeckItemModel) =>
                      widget.onGranularSyncClick?.call(homeDeckItemModel),
                  onDescriptionClick: (homeDeckItemModel) =>
                      widget.onDescriptionClick?.call(homeDeckItemModel),
                ),
              ),
              controller: itemScrollController,
              // itemPositionsListener: itemPositionsListener,
            ),
        error: (Object error, StackTrace s) => getErrorWidget(error, s),
        loading: () => const CircularProgressIndicator());
  }
}
