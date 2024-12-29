import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/data_run/d_assignment/model/extract_and_sum_allocated_actual.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_provider.g.dart';

@riverpod
class Assignments extends _$Assignments {
  @override
  Future<List<AssignmentModel>> build() async {
    final List<DAssignment> assignments =
        await D2Remote.assignmentModuleD.assignment.get();
    final futures =
        assignments.map<Future<AssignmentModel>>((assignment) async {
      final activityEntity = await D2Remote.activityModuleD.activity
          .byId(assignment.activity)
          .getOne();
      final orgUnitEntity = await D2Remote.organisationUnitModuleD.orgUnit
          .byId(assignment.orgUnit)
          .getOne();
      final teamEntity =
          await D2Remote.teamModuleD.team.byId(assignment.team).getOne();
      final submissions =
          await ref.watch(assignmentSubmissionsProvider(assignment.id!).future);
      AssignmentStatus status;

      if (submissions.isEmpty) {
        status = AssignmentStatus.NOT_STARTED;
      } else {
        submissions
            .sort((a, b) => b.lastModifiedDate!.compareTo(a.lastModifiedDate!));
        status = submissions.first.status!;
      }

      return AssignmentModel(
        id: assignment.id!,
        activity: activityEntity.name,
        entityCode: orgUnitEntity.code!,
        entityName: orgUnitEntity.name!,
        teamCode: teamEntity.team.code,
        teamName: teamEntity.team.name,
        scope: assignment.scope!,
        status: status,
        dueDate: DateTime.parse(assignment.startDate!),
        rescheduledDate: assignment.startDate != null
            ? DateTime.parse(assignment.startDate!)
            : null,
        allocatedResources: assignment.allocatedResources
            .map((key, value) => MapEntry(key, value ?? 0)),
        reportedResources: sumActualResources(
            submissions, assignment.allocatedResources.keys.toList()),
        forms: assignment.forms,
      );
    }).toList();

    final assignmentModels = await Future.wait<AssignmentModel>(futures);
    return assignmentModels;
  }
}

@riverpod
class AssignmentSubmissions extends _$AssignmentSubmissions {
  @override
  Future<List<DataFormSubmission>> build(String assignmentId) {
    return D2Remote.formModule.dataFormSubmission
        .where(attribute: 'assignment', value: assignmentId)
        .get();
  }
}

@riverpod
class FilterQuery extends _$FilterQuery {
  @override
  AssignmentFilterQuery build() {
    return AssignmentFilterQuery();
  }

  updateSearchQuery(String searchQuery) {
    state = state.copyWith(searchQuery: searchQuery);
  }

  updateSelectedStatus(AssignmentStatus? selectedStatus) {
    state = state.copyWith(selectedStatus: selectedStatus);
  }

  updateSelectedScope(EntityScope? selectedScope) {
    state = state.copyWith(selectedScope: selectedScope);
  }

  updateSelectedDays(IList<int> selectedDays) {
    state = state.copyWith(selectedDays: selectedDays);
  }

  toggleCardTableView(bool isCardView) {
    state = state.copyWith(isCardView: isCardView);
  }
}

@riverpod
Future<List<AssignmentModel>> filterAssignments(
    FilterAssignmentsRef ref) async {
  final assignments = await ref.watch(assignmentsProvider.future);
  final query = ref.watch(filterQueryProvider);

  final lowerCaseQuery = query.searchQuery.toLowerCase() ?? '';

  return assignments.where((assignment) {
    if (query.selectedStatus != null &&
        assignment.status != query.selectedStatus) {
      return false;
    }
    if (query.selectedScope != null &&
        assignment.scope != query.selectedScope) {
      return false;
    }
    if (query.selectedDays != null &&
        query.selectedDays!.isNotEmpty &&
        (assignment.startDay == null ||
            !query.selectedDays!.contains(assignment.startDay))) {
      return false;
    }
    if (query.searchQuery.isNotEmpty) {
      final lowerCaseActivity = assignment.activity.toLowerCase();
      final lowerCaseEntityCode = assignment.entityCode.toLowerCase();
      final lowerCaseEntityName = assignment.entityName.toLowerCase();
      final lowerCaseTeamName = assignment.teamName.toLowerCase();

      if (!lowerCaseActivity.contains(lowerCaseQuery) &&
          !lowerCaseEntityCode.contains(lowerCaseQuery) &&
          !lowerCaseEntityName.contains(lowerCaseQuery) &&
          !lowerCaseTeamName.contains(lowerCaseQuery)) {
        return false;
      }
    }
    return true;
  }).toList();
}

class AssignmentModel {
  AssignmentModel({
    required this.id,
    required this.activity,
    required this.entityCode,
    required this.entityName,
    required this.teamCode,
    required this.teamName,
    required this.scope,
    required this.status,
    this.startDay,
    this.startDate,
    required this.dueDate,
    this.rescheduledDate,
    this.allocatedResources = const {},
    this.reportedResources = const {},
    required this.forms,
  });

  final String id;
  final String activity;
  final String entityCode;
  final String entityName;
  final String teamCode;
  final String teamName;
  final EntityScope scope;
  final AssignmentStatus status;
  final int? startDay;
  final String? startDate;
  final DateTime dueDate;
  final DateTime? rescheduledDate;
  final List<String> forms;
  final Map<String, dynamic> allocatedResources; // E.g., ITNs, Population
  final Map<String, dynamic> reportedResources; // E.g., ITNs, Population

  AssignmentModel copyWith({
    String? id,
    String? activity,
    String? entityCode,
    String? entityName,
    String? teamCode,
    String? teamName,
    EntityScope? scope,
    AssignmentStatus? status,
    int? startDay,
    String? startDate,
    DateTime? dueDate,
    DateTime? rescheduledDate,
    List<String>? forms,
    Map<String, int>? allocatedResources,
    Map<String, int>? reportedResources,
  }) {
    return AssignmentModel(
      id: id ?? this.id,
      activity: activity ?? this.activity,
      entityCode: entityCode ?? this.entityCode,
      entityName: entityName ?? this.entityName,
      teamCode: teamCode ?? this.teamCode,
      teamName: teamName ?? this.teamName,
      scope: scope ?? this.scope,
      status: status ?? this.status,
      startDay: startDay ?? this.startDay,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      rescheduledDate: rescheduledDate ?? this.rescheduledDate,
      forms: forms ?? this.forms,
      allocatedResources: allocatedResources ?? this.allocatedResources,
      reportedResources: reportedResources ?? this.reportedResources,
    );
  }

  static int calculateStartDay(
      String activityStartDate, String assignmentStartDate) {
    final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    final activityStart = dateFormat.parse(activityStartDate);
    final assignmentStart = dateFormat.parse(assignmentStartDate);

    return assignmentStart.difference(activityStart).inDays + 1;
  }
}

class AssignmentFilterQuery with EquatableMixin {
  AssignmentFilterQuery({
    this.searchQuery = '',
    this.selectedStatus,
    this.selectedScope,
    this.isCardView = true,
    Iterable<int>? selectedDays,
  }) : selectedDays = selectedDays?.toIList() ?? const IList<int>.empty();
  final String searchQuery;
  final AssignmentStatus? selectedStatus;
  final EntityScope? selectedScope;
  final IList<int>? selectedDays;
  final bool isCardView;

  bool get hasFilters =>
      searchQuery.isNotEmpty ||
      selectedStatus != null ||
      selectedScope != null ||
      selectedDays?.isNotEmpty == true;

  AssignmentFilterQuery copyWith({
    String? searchQuery,
    AssignmentStatus? selectedStatus,
    EntityScope? selectedScope,
    Iterable<int>? selectedDays,
    bool? isCardView,
  }) {
    return AssignmentFilterQuery(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedScope: selectedScope ?? this.selectedScope,
      selectedDays: selectedDays ?? this.selectedDays,
      isCardView: isCardView ?? this.isCardView,
    );
  }

  @override
  List<Object?> get props =>
      [searchQuery, selectedStatus, selectedScope, selectedDays, isCardView];
}
