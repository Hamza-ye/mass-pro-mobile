// ignore_for_file: avoid_dynamic_calls

import 'package:d2_remote/core/arch/helpers/uids_helper.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/data/tracker/queries/event.query.dart';
import 'package:d2_remote/modules/data/tracker/queries/tracked_entity_instance.query.dart';
import 'package:d2_remote/modules/metadata/dataset/queries/data_set.query.dart';
import 'package:d2_remote/modules/metadata/program/queries/program.query.dart';
import 'package:d2_remote/shared/entities/base.entity.dart';
import 'package:d2_remote/shared/queries/base.query.dart';
import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../commons/helpers/result.dart';
import '../../../core/arch/call/d2_progress.dart';
import '../../../core/arch/call/d2_progress_manager.dart';
import '../../../core/arch/call/d2_progress_status.dart';
import '../../../core/d2_remote_extensions/tracker/queries/event_query_download_extension.dart';
import '../../../core/d2_remote_extensions/tracker/queries/event_query_upload_extension.dart';
import '../../../core/d2_remote_extensions/tracker/queries/tei_upload_extension.dart';
import '../../../core/tracker/tracker_d2_progress.dart';
import 'sync_presenter.dart';
import 'sync_result.dart';
import 'sync_status_controller.dart';
part 'sync_presenter_impl.g.dart';

@riverpod
SyncPresenter syncPresenter(SyncPresenterRef ref) {
  return SyncPresenterImpl(ref);
}

class SyncPresenterImpl implements SyncPresenter {
  SyncPresenterImpl(this.ref)
      : eventQuery = EventQuery(),
        programQuery = ProgramQuery(),
        dataSet = DataSetQuery(),
        teisQuery = TrackedEntityInstanceQuery();
  final EventQuery eventQuery;
  final ProgramQuery programQuery;
  final TrackedEntityInstanceQuery teisQuery;
  final DataSetQuery dataSet;
  // : preferences = ref.read(preferencesInstanceProvider),
  // syncStatusController = ref.read(syncStatusControllerInstanceProvider),
  // syncRepository = ref.read(syncRepositoryProvider);

  final SyncPresenterRef ref;
  // final PreferenceProvider preferences;
  // final WorkManagerController workManagerController;
  // final AnalyticsHelper analyticsHelper;
  // final SyncStatusController syncStatusController;
  // final SyncRepository syncRepository;

  void _postProgress(TrackerD2Progress d2Progress) {
    ref
        .read(syncStatusControllerInstanceProvider.notifier)
        .updateDownloadProcess(d2Progress.programs);
  }

  void _resetQueryFilters(BaseQuery<BaseEntity> query) {
    query.filters = null;
  }

  @override
  Future<void> initSyncControllerMap() {
    // return D2Remote.programModule.program
    return programQuery
        .get()
        .then((programs) => IMap.fromEntries(UidsHelper.getUidsList(programs)
            .map((programUid) => MapEntry(programUid,
                const D2ProgressStatus(isComplete: false, syncStatus: null)))))
        .then((programsMap) {
      // return D2Remote.dataSetModule.dataSet.get().then((dataSets) {
      return dataSet.get().then((dataSets) {
        programsMap.addAll(IMap.fromEntries(UidsHelper.getUidsList(dataSets)
            .map((dataSetUid) => MapEntry(dataSetUid,
                const D2ProgressStatus(isComplete: false, syncStatus: null)))));
        return programsMap;
      });
    }).then((allMap) => ref
            .read(syncStatusControllerInstanceProvider.notifier)
            .initDownloadProcess(allMap));
    // return Future(
    //     () => ref.read(d2ProgressNotifierProvider.notifier).initValue());
  }

  @override
  void finishSync() {
    ref.read(syncStatusControllerInstanceProvider.notifier).finishSync();
  }

  @override
  void setNetworkUnavailable() {
    ref
        .read(syncStatusControllerInstanceProvider.notifier)
        .onNetworkUnavailable();
  }

  // throws Exception;
  @override
  Future<void> syncAndDownloadEvents({Dio? dioTestClient}) async {
    // upload unSynced
    // TODO(NMC): make service to do that and handle errors inside it
    _resetQueryFilters(eventQuery);
    // await D2Remote.trackerModule.event
    await eventQuery.uploadProgress(_postProgress,
        dioTestClient: dioTestClient);
    // download
    // await D2Remote.trackerModule.event
    await D2Remote.trackerModule.event
        .downloadWithProgress(_postProgress, dioTestClient: dioTestClient);
  }

  // throws Exception;
  @override
  Future<void> syncAndDownloadTeis({Dio? dioTestClient}) async {
    _resetQueryFilters(D2Remote.trackerModule.trackedEntityInstance);
    // await D2Remote.trackerModule.trackedEntityInstance
    await D2Remote.trackerModule.trackedEntityInstance
        .uploadWithProgress(_postProgress, dioTestClient: dioTestClient);
    // download teis
    // await D2Remote.trackerModule.trackedEntityInstance
    await D2Remote.trackerModule.trackedEntityInstance
        .downloadWithProgress(_postProgress, dioTestClient: dioTestClient);
  }

// throws Exception;
  @override
  Future<void> syncAndDownloadDataValues({Dio? dioTestClient}) {
    return Future.value();
  }

  // throws Exception;
  @override
  Future<void> syncMetadata({Dio? dioTestClient}) {
    final d2ProgressManager = D2ProgressManager(totalCalls: 4);
    // TODO(NMC): here it will sync everything
    // return ref.read(syncProvider).download(
    //     callback: (requestProgresses, p1, p2) {
    //   if (requestProgresses != null) {
    //     for (final requestProgress in requestProgresses) {
    //       ref.read(d2ProgressNotifierProvider.notifier).postValue(
    //           d2ProgressManager.increaseProgress(
    //               resourceName: requestProgress.resourceName,
    //               message: requestProgress.message,
    //               percentage: requestProgress.percentage,
    //               isComplete: p1));
    //     }
    //   }
    // });
    return Future.value();
  }

  @override
  Future<void> syncReservedValues({Dio? dioTestClient}) {
    return Future.value();
  }

  @override
  Future<SyncResult> checkSyncStatus() {
    return Future.value(SyncResult.SYNC);
  }

  /// TrackerD2Progress
  @override
  Future<D2Progress> syncGranularEvent(String eventUid,
      {Dio? dioTestClient}) async {
    // upload unSynced
    // TODO(NMC): make service to do that and handle errors inside it
    // await D2Remote.trackerModule.event
    await eventQuery
        .byId(eventUid)
        .uploadProgress(_postProgress, dioTestClient: dioTestClient);
    // download
    // return D2Remote.trackerModule.event
    return eventQuery
        .byId(eventUid)
        .downloadWithProgress(_postProgress, dioTestClient: dioTestClient);
  }

  /// ListenableWorker.Result
  @override
  Future<Result<String>> syncGranularProgram(String programUid,
      {Dio? dioTestClient}) async {
    // upload unSynced
    // TODO(NMC): make service to do that and handle errors inside it
    _resetQueryFilters(eventQuery);
    // await D2Remote.trackerModule.event
    // await EventQuery()
    await eventQuery
        .byProgram(programUid)
        .uploadProgress(_postProgress, dioTestClient: dioTestClient);
    // download
    // return D2Remote.trackerModule.event
    return eventQuery
        .byProgram(programUid)
        .downloadWithProgress(_postProgress, dioTestClient: dioTestClient)
        .then((value) => Result.success(''))
        .onError((Exception? error, stackTrace) =>
            Result.failure(Exception(error?.toString())));
  }

  /// ListenableWorker.Result
  @override
  Future<Result<String>> syncGranularActivity(String activityUid,
      {Dio? dioTestClient}) async {
    // upload unSynced
    // TODO(NMC): make service to do that and handle errors inside it
    _resetQueryFilters(eventQuery);
    // await D2Remote.trackerModule.event
    await eventQuery
        .byActivity(activityUid)
        .uploadProgress(_postProgress, dioTestClient: dioTestClient);
    // download
    // return D2Remote.trackerModule.event
    return eventQuery
        .byActivity(activityUid)
        .downloadWithProgress(_postProgress, dioTestClient: dioTestClient)
        .then((value) => Result.success(''))
        .onError((Exception? error, stackTrace) =>
            Result.failure(Exception(error?.toString())));
  }

  @override
  Future<Result<String>> syncGranularTei(
      String? teiUid, String? activityUid, String? orgUnit,
      {Dio? dioTestClient}) async {
    return Future.value(Result.success('not Implemented'));
    // TODO(NMC): implement uploadProgress
    // _resetQueryFilters(teisQuery);
    // if (teiUid != null) {
    //   teisQuery.byId(teiUid);
    // }

    // if (activityUid != null) {
    //   teisQuery.byActivity(activityUid);
    // }

    // if (orgUnit != null) {
    //   teisQuery.byOrgUnit(orgUnit);
    // }

    // await teisQuery.uploadProgress(_postProgress, dioTestClient: dioTestClient);
    // // download
    // return teisQuery
    //     .downloadWithProgress(_postProgress, dioTestClient: dioTestClient)
    //     .then((value) => Result.success(''))
    //     .onError((Exception? error, stackTrace) =>
    //         Result.failure(Exception(error?.toString())));
  }

  // /// ListenableWorker.Result
  // @override
  // Future<Result<String>> blockSyncGranularEvent(String eventUid,
  //     {Dio? dioTestClient}) {
  //   return Future.value();
  // }

  /// ListenableWorker.Result
  @override
  Future<Result<String>> syncGranularDataSet(String dataSetUid,
      {Dio? dioTestClient}) {
    return Future.value(Result.success('not Implemented'));
  }

  // /// Observable
  // @override
  // Future<D2Progress> syncGranularProgram(String uid, {Dio? dioTestClient}) {
  //   return Future.value();
  // }

  /// Observable
  /// TrackerD2Progress
  // @override
  // Future<D2Progress> syncGranularTEI(String uid, {Dio? dioTestClient}) {
  //   return Future.value();
  // }

  // /// Observable
  // @override
  // Future<D2Progress> syncGranularDataSet(String uid, {Dio? dioTestClient}) {
  //   return Future.value();
  // }

  /// Observable
  @override
  Future<Result<String>> syncGranularDataValues(
      String? activityUid, String? orgUnit, String? period,
      {Dio? dioTestClient}) async {
    // TODO(NMC): not implemented on DataValue Level, we have to upload the
    // whole event
    // final eventsQuery = D2Remote.trackerModule.event;
    // _resetQueryFilters(eventsQuery);
    // if (activityUid != null) {
    //   eventsQuery.byActivity(activityUid);
    // }

    // if (orgUnit != null) {
    //   eventsQuery.byOrgUnit(orgUnit);
    // }

    // return eventsQuery
    //     .uploadWithProgress(_postProgress, dioTestClient: dioTestClient)
    //     .then((value) => Result.success(''))
    //     .onError((Exception? error, stackTrace) =>
    //         Result.failure(Exception(error?.toString())));
    return Future.value(Result.success('not Implemented'));
  }

  /// Observable
  @override
  Future<D2Progress> syncGranularDataSetDataComplete(
      String dataSetUid,
      String activityUid,
      String orgUnit,
      String attributeOptionCombo,
      String period,
      {Dio? dioTestClient}) {
    return Future.value(D2Progress());
  }

  /// Observable
  @override
  Future<D2Progress> syncGranularDataSetComplete(String dataSetUid,
      {Dio? dioTestClient}) {
    return Future.value(D2Progress());
  }

  @override
  Future<SyncResult> checkSyncEventStatus(String uid) {
    return Future.value(SyncResult.SYNC);
  }

  @override
  Future<SyncResult> checkSyncTEIStatus(String uid) {
    return Future.value(SyncResult.SYNC);
  }

  @override
  Future<bool> checkSyncDataValueStatus(
      String orgUnit, String attributeOptionCombo, String period) {
    return Future.value(true);
  }

  @override
  Future<bool> checkSyncProgramStatus(String uid) {
    return Future.value(true);
  }

  @override
  Future<bool> checkSyncDataSetStatus(String uid) {
    return Future.value(true);
  }

  // List<TrackerImportConflict> messageTrackerImportConflict(String uid){}

  @override
  void startPeriodicDataWork() {}

  @override
  void startPeriodicMetaWork() {}

  @override
  Future<void> downloadResources({Dio? dioTestClient}) {
    return Future.value();
  }

  /// ListenableWorker.Result
  @override
  Future<Result<String>> syncGranularDataSetValues(String dataSetUid,
      String activityUid, String orgUnitUid, String? periodId,
      {Dio? dioTestClient}) {
    return Future.value(Result.success('not Implemented'));
  }

  @override
  void logTimeToFinish(int millisToFinish, String eventName) {}

  @override
  void updateProyectAnalytics() {}
}
