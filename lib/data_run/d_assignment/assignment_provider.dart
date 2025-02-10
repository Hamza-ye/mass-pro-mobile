import 'package:d2_remote/core/datarun/utilities/date_utils.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:d2_remote/shared/utilities/save_option.util.dart';
import 'package:datarun/commons/helpers/map.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarun/data_run/d_assignment/model/extract_and_sum_allocated_actual.dart';
import 'package:datarun/data_run/d_team/team_model.dart';
import 'package:datarun/data_run/d_team/team_provider.dart';
import 'package:datarun/data_run/form/form_submission/submission_list.provider.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_provider.g.dart';

/// a notifier that retrieves all assignments with their data populated
@riverpod
class Assignments extends _$Assignments {
  @override
  Future<List<AssignmentModel>> build() async {
    final query = D2Remote.assignmentModuleD.assignment;
    final List<DAssignment> assignments = await query.get();
    final futures =
        assignments.map<Future<AssignmentModel>>((assignment) async {
      final activityEntity = await D2Remote.activityModuleD.activity
          .byId(assignment.activity!)
          .getOne();
      final orgUnitEntity = await D2Remote.organisationUnitModuleD.orgUnit
          .byId(assignment.orgUnit!)
          .getOne();

      final teamEntity =
          await D2Remote.teamModuleD.team.byId(assignment.team!).getOne();

      final IList<TeamModel> assignedTeams =
          await ref.watch(teamsProvider(EntityScope.Assigned).future);

      final IList<TeamModel> managedTeams =
          await ref.watch(teamsProvider(EntityScope.Managed).future);

      final assignedForms = assignedTeams
          .expand((t) => t.formPermissions)
          .map((f) => f.form)
          .toList();

      final assignmentForms =
          assignment.forms.where((f) => assignedForms.contains(f)).toList();
      List<DataFormSubmission> submissions = [];

      for (var form in assignmentForms) {
        submissions.addAll(await ref.watch(
            assignmentSubmissionsProvider(assignment.id!, form: form).future));
      }

      AssignmentStatus status;

      // if (submissions.isEmpty) {
      //   status = AssignmentStatus.NOT_STARTED;
      // } else {
      //   final sortedSubmissions = submissions.toList()
      //     ..sort((a, b) => b.lastModifiedDate!.compareTo(a.lastModifiedDate!));
      //   status = sortedSubmissions.first.status!;
      status = assignment.status ?? AssignmentStatus.NOT_STARTED;
      // }

      return AssignmentModel(
        id: assignment.id!,
        activityId: activityEntity.id,
        activity: activityEntity.name,
        entityId: orgUnitEntity.id!,
        entityCode: orgUnitEntity.code!,
        entityName: orgUnitEntity.name!,
        teamId: teamEntity.id,
        teamCode: teamEntity.code,
        teamName: teamEntity.name,
        scope: assignment.scope ?? EntityScope.Assigned,
        status: status,
        dueDate: activityEntity.startDate != null
            ? AssignmentModel.calculateAssignmentDate(
                activityEntity.startDate, assignment.startDay)
            : null,
        // DateTime.parse(assignment.startDate!)
        startDay: assignment.startDay,
        rescheduledDate: assignment.startDate != null
            ? DateTime.parse(assignment.startDate!)
            : null,
        allocatedResources: managedTeams.length > 0
            ? assignment.allocatedResources
                .filter((entry) =>
                    entry.key != 'Latitude' && entry.key != 'Longitude')
                .map((key, value) => MapEntry(key, value ?? 0))
            : {'ITNs': 0, 'Population': 0, 'Households': 0},
        reportedResources: sumActualResources(
            submissions, assignment.allocatedResources.keys.toList()),
        forms: assignment.forms,
      );
    }).toList();

    final assignmentModels = await Future.wait<AssignmentModel>(futures);
    return assignmentModels;
  }

  void updateStatus(AssignmentStatus? status, String assignmentId) async {
    // final previousState = await future;

    DAssignment? assignment =
        await D2Remote.assignmentModuleD.assignment.byId(assignmentId).getOne();
    if (assignment != null) {
      assignment.status = status;
      assignment.lastModifiedDate =
          DDateUtils.databaseDateFormat().format(DateTime.now().toUtc());
      await D2Remote.assignmentModuleD.assignment
          .setData(assignment)
          .save(saveOptions: SaveOptions(skipLocalSyncStatus: false));
    }

    ref.invalidateSelf();
    await future;
  }
}

/// retrieve a certain assignment forms submissions
@riverpod
class AssignmentSubmissions extends _$AssignmentSubmissions {
  @override
  Future<List<DataFormSubmission>> build(String assignmentId,
      {required String form}) async {
    final submissions = await ref.watch(formSubmissionsProvider(form).future);

    final futures = submissions
        .where((s) => s.assignment == assignmentId)
        .map((submission) async {
      return submission
        ..formVersion = await D2Remote.formModule.formTemplateV
            .byId(submission.formVersion is String
                ? submission.formVersion
                : submission.formVersion.id)
            .getOne();
    }).toList();

    final submissionsWithTemplate =
        await Future.wait<DataFormSubmission>(futures);
    return submissionsWithTemplate;
  }
}

/// filters the list of assignmnet by certain cretiria
@riverpod
Future<List<AssignmentModel>> filterAssignments(FilterAssignmentsRef ref,
    [EntityScope? scope]) async {
  final assignments = await ref.watch(assignmentsProvider.future);
  final query = ref.watch(filterQueryProvider);

  final lowerCaseQuery = query.searchQuery.toLowerCase();
  assignments.sort((a, b) => (a.startDay ?? 11).compareTo((b.startDay ?? 11)));
  final filteredAssignments = assignments
      .where((a) => scope != null && a.scope == scope)
      .where((assignment) {
    for (var entry in query.filters.entries) {
      final key = entry.key;
      final value = entry.value;

      if (key == 'status' && assignment.status != value) {
        return false;
      }
      if (key == 'scope' && assignment.scope != value) {
        return false;
      }
      if (key == 'days' &&
          value is Iterable &&
          value.isNotEmpty &&
          (assignment.startDay == null ||
              !value.contains(assignment.startDay))) {
        return false;
      }
      if (key == 'teams' &&
          value is Iterable &&
          value.isNotEmpty &&
          (!value.contains(assignment.teamId))) {
        return false;
      }
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

  // Apply sorting
  if (query.sortBy != null) {
    filteredAssignments.sort((a, b) {
      final aValue = _getAssignmentFieldValue(a, query.sortBy!);
      final bValue = _getAssignmentFieldValue(b, query.sortBy!);

      if (aValue == null || bValue == null) return 0;
      return query.ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
  }

  return filteredAssignments;
}

// Helper function to get field values dynamically
dynamic _getAssignmentFieldValue(AssignmentModel assignment, String field) {
  switch (field) {
    case 'dueDate':
      return assignment.dueDate;
    case 'status':
      return assignment.status.index; // Assuming `AssignmentStatus` is an enum
    case 'teamName':
      return assignment.teamName;
    // Add more fields as needed
    default:
      return null;
  }
}

/// filter query model notifier that store filtering cretirias
@riverpod
class FilterQuery extends _$FilterQuery {
  @override
  AssignmentFilterQuery build() {
    return AssignmentFilterQuery();
  }

  // Update the sorting parameter and order
  void updateSortBy(String? sortBy, {bool ascending = true}) {
    state = state.copyWith(sortBy: sortBy, ascending: ascending);
  }

  // Update the search query
  void updateSearchQuery(String searchQuery) {
    state = state.copyWith(searchQuery: searchQuery);
  }

  // Update or add a filter
  void updateFilter(String filterKey, dynamic filterValue) {
    final updatedFilters = Map.of(state.filters);
    if (filterValue == null ||
        (filterValue is Iterable && filterValue.isEmpty)) {
      updatedFilters.remove(filterKey); // Remove filter if null or empty
    } else {
      updatedFilters[filterKey] = filterValue; // Update or add filter
    }
    state = state.copyWith(filters: updatedFilters);
  }

  // Remove a specific filter
  void removeFilter(String filterKey) {
    final updatedFilters = Map.of(state.filters)..remove(filterKey);
    state = state.copyWith(filters: updatedFilters);
  }

  // Clear all filters
  void clearAllFilters() {
    state = state.copyWith(filters: {}, sortBy: null, ascending: true);
  }

  // Toggle card/table view
  void toggleCardTableView() {
    state = state.copyWith(isCardView: !state.isCardView);
  }
}

class AssignmentFilterQuery with EquatableMixin {
  AssignmentFilterQuery({
    this.searchQuery = '',
    Map<String, dynamic>? filters,
    this.sortBy,
    this.ascending = true,
    this.isCardView = true,
  }) : filters = filters ?? {};

  final String searchQuery;
  final Map<String, dynamic> filters;
  final String? sortBy; // Sorting field, e.g., "dueDate"
  final bool ascending; // Sorting order
  final bool isCardView;

  bool get hasFilters => filters.isNotEmpty || searchQuery.isNotEmpty;

  AssignmentFilterQuery copyWith({
    String? searchQuery,
    Map<String, dynamic>? filters,
    String? sortBy,
    bool? ascending,
    bool? isCardView,
  }) {
    return AssignmentFilterQuery(
      searchQuery: searchQuery ?? this.searchQuery,
      filters: filters ?? this.filters,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
      isCardView: isCardView ?? this.isCardView,
    );
  }

  @override
  List<Object?> get props =>
      [searchQuery, filters, sortBy, ascending, isCardView];
}
