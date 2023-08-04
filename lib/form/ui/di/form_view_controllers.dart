import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../commons/extensions/standard_extensions.dart';
import '../../../commons/helpers/collections.dart';
import '../../../commons/logging/logging.dart';
import '../../di/injector.dart';
import '../../model/action_type.dart';
import '../../model/field_ui_model.dart';
import '../../model/form_repository_records.dart';
import '../../model/info_ui_model.dart';
import '../../model/row_action.dart';
import '../../model/store_result.dart';
import '../../model/value_store_result.dart';
import '../form_model.dart';
import '../intent/form_intent.dart';
import 'form_view_repository.dart';

part 'form_view_controllers.g.dart';

@riverpod
FormRepositoryRecords formRepositoryRecordsInstance(
    FormRepositoryRecordsInstanceRef ref) {
  logInfo(info: 'FormRepositoryRecords formRepositoryRecords');
  ref.onDispose(() {
    logInfo(info: 'FormRepositoryRecords onDispose');
  });
  ref.keepAlive();
  throw UnimplementedError();
}

@Riverpod(dependencies: [formRepository])
FormViewRepository _formViewRepository(_FormViewRepositoryRef ref) {
  // final records = ref.watch(formRepositoryRecordsInstanceProvider);
  return FormViewRepository(ref, ref.watch(formRepositoryProvider));
}

@riverpod
class FormPendingIntents extends _$FormPendingIntents {
  @override
  FormIntent build() {
    return const FormIntent.init();
  }

  @override
  bool updateShouldNotify(FormIntent oldI, FormIntent newI) {
    logInfo(
        info:
            'FormPendingIntents: updateShouldNotify(oldI,newI): oldI: $oldI, newI: $newI');
    if (oldI is OnFinish && newI is OnFinish) {
      return false;
    } else {
      return oldI != newI;
    }
  }

  void submitIntent(FormIntent Function(FormIntent current) updateCallback) {
    logInfo(info: 'FormPendingIntents: submitIntent(), current: $state');
    state = updateCallback.call(state);
  }
}

@Riverpod(dependencies: [_formViewRepository])
RowAction _rowActionFromIntent(_RowActionFromIntentRef ref) {
  final pendingIntents = ref.watch(formPendingIntentsProvider);
  final formViewRepo = ref.watch(_formViewRepositoryProvider);
  logInfo(info: '_rowActionFromIntent');
  return formViewRepo.rowActionFromIntent(pendingIntents);
}

@Riverpod(dependencies: [_rowActionFromIntent])
bool formViewFocused(FormViewFocusedRef ref) {
  return ref.watch(_rowActionFromIntentProvider
      .select((rowAction) => rowAction.type == ActionType.ON_FOCUS));
}

@Riverpod(dependencies: [_rowActionFromIntent, ItemsResult])
bool formViewLoading(FormViewLoadingRef ref) {
  final onSaveRowActionType = ref.watch(_rowActionFromIntentProvider
      .select((rowAction) => rowAction.type == ActionType.ON_SAVE));
  final bool dataIsLoading = ref.watch(itemsResultProvider
      .select((itemsResultAsyncValue) => itemsResultAsyncValue.isLoading));
  final loading = onSaveRowActionType || dataIsLoading;
  return loading;
}

// _completionPercentage
@Riverpod(dependencies: [_formViewRepository, ItemsResult])
double completionPercentage(CompletionPercentageRef ref) {
  final repository = ref.watch(_formViewRepositoryProvider);
  final IList<FieldUiModel>? itemsResult = ref.watch(itemsResultProvider
      .select((itemsResultAsyncValue) => itemsResultAsyncValue.value));
  final percentage = repository.completedFieldsPercentage(
      itemsResult ?? const IListConst<FieldUiModel>([]));
  logInfo(
      info:
      'completionPercentage: percentage $percentage');
  return percentage;
}

@Riverpod(dependencies: [_formViewRepository, ItemsResult])
bool calculationLoop(CalculationLoopRef ref) {
  final repository = ref.watch(_formViewRepositoryProvider);
  final IList<FieldUiModel>? itemsResult = ref.watch(itemsResultProvider
      .select((itemsResultAsyncValue) => itemsResultAsyncValue.value));
  final displayLoopWarningIfNeeded =
      // itemsResult != null ? repository.calculationLoopOverLimit() : false;
      itemsResult != null && repository.calculationLoopOverLimit();
  return displayLoopWarningIfNeeded;
}

@Riverpod(dependencies: [_rowActionFromIntent, _formViewRepository])
Future<Pair<RowAction, StoreResult>> _rowActionStore(
    _RowActionStoreRef ref) async {
  final rowAction = ref.watch(_rowActionFromIntentProvider);
  final formViewRepo = ref.watch(_formViewRepositoryProvider);
  final result = await formViewRepo.processUserAction(rowAction);
  logInfo(
      info:
          '_rowActionStore: processing rowActionFromIntent, '
              'rowActionType: ${rowAction.type}, StoreResult: ${result.valueStoreResult}');
  return Pair<RowAction, StoreResult>(rowAction, result);
}

@Riverpod(dependencies: [_formViewRepository, _rowActionStore])
class ItemsResult extends _$ItemsResult {
  @override
  FutureOr<IList<FieldUiModel>> build() {
    logInfo(info: 'itemsProvider: got built -> build()');
    final repository = ref.read(_formViewRepositoryProvider);
    setUpListener();
    try {
      final items = repository.fetchFormItems();
      return items;
    } catch (e) {
      return const IListConst<FieldUiModel>([]);
    }
  }

  Future<void> loadData() async {
    logInfo(info: 'itemsProvider: fetchFormItems()');
    final repository = ref.read(_formViewRepositoryProvider);
    state = await AsyncValue.guard(repository.fetchFormItems);
  }

  Future<void> _processCalculatedItems() async {
    logInfo(info: 'itemsProvider: processCalculatedItems()');
    final repository = ref.read(_formViewRepositoryProvider);
    state = await AsyncValue.guard(repository.composeList);
  }

  void runDataIntegrityCheck({bool? backButtonPressed}) {
    final repository = ref.read(_formViewRepositoryProvider);
    repository
        .runDataIntegrityCheck(allowDiscard: false)
        .then((integrityResult) {
      ref.read(formModelNotifierProvider.notifier).updateValue(
          (current) => current.copyWith(dataIntegrityResult: integrityResult));
    }).then((_) => _processCalculatedItems());
  }

  void saveDataEntry() {
    final repository = ref.read(_formViewRepositoryProvider);
    repository
        .saveDataEntry();
  }

  void setUpListener() {
    ref.listen<AsyncValue<Pair<RowAction, StoreResult>>>(
        _rowActionStoreProvider,
        (AsyncValue<Pair<RowAction, StoreResult>>? previous,
            AsyncValue<Pair<RowAction, StoreResult>> next) {
      when(next.value?.second.valueStoreResult, {
        ValueStoreResult.VALUE_CHANGED: () {
          logInfo(info: 'itemsProvider: ValueStoreResult.VALUE_CHANGED');
          ref.read(formModelNotifierProvider.notifier).updateValue(
              (current) => current.copyWith(savedValue: next.value?.first));
          _processCalculatedItems();
        },
        ValueStoreResult.ERROR_UPDATING_VALUE: () {
          logInfo(info: 'itemsProvider: ValueStoreResult.ERROR_UPDATING_VALUE');
          ref.read(formModelNotifierProvider.notifier).updateValue((current) =>
              current.copyWith(showToast: 'string.update_field_error'));
        },
        ValueStoreResult.UID_IS_NOT_DE_OR_ATTR: () {
          logInfo(
              info:
                  'Timber.tag(TAG).d("${next.value?.first.id} is not a data element or attribute")');
          _processCalculatedItems();
        },
        ValueStoreResult.VALUE_NOT_UNIQUE: () {
          logInfo(info: 'itemsProvider: ValueStoreResult.VALUE_NOT_UNIQUE');
          ref.read(formModelNotifierProvider.notifier).updateValue((current) =>
              current.copyWith(
                  showInfo: const InfoUiModel(
                      'string.error', 'string.unique_warning')));
          _processCalculatedItems();
        },
        ValueStoreResult.VALUE_HAS_NOT_CHANGED: () => _processCalculatedItems(),
        ValueStoreResult.TEXT_CHANGING: () {
          logInfo(info: 'itemsProvider: ValueStoreResult.TEXT_CHANGING');
          logInfo(
              info:
                  'Timber.d("${next.value?.first.id} is changing its value")');
          ref.read(formModelNotifierProvider.notifier).updateValue(
              (current) => current.copyWith(queryData: next.value?.first));
        },
        ValueStoreResult.FINISH: () {
          logInfo(info: 'itemsProvider: ValueStoreResult.FINISH');
          _processCalculatedItems().then((value) => runDataIntegrityCheck());
        }
      });
    });
  }
}

@riverpod
class FormModelNotifier extends _$FormModelNotifier {
  @override
  FormModel build() {
    logInfo(info: 'FormModelNotifier: got built -> build()');

    return FormModel();
  }

  void updateValue(FormModel Function(FormModel current) updateCallback) {
    state = updateCallback.call(state);
  }
}

@riverpod
int formViewIndex(FormViewIndexRef ref) {
  throw UnimplementedError();
}
