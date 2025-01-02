import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/data_run/d_assignment/model/extract_and_sum_allocated_actual.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_provider.g.dart';

// @riverpod
// class ScopedAssignments extends _$ScopedAssignments {
//   @override
//   Future<List<AssignmentModel>> build() async {
//     final List<DAssignment> assignments =
//     await D2Remote.assignmentModuleD.assignment.get();
//     List<AssignmentModel> assignmentModels = [];
//     for (final assignment in assignments) {
//       logDebug('assignment: ${assignment.id}');
//       try {
//         assignmentModels
//             .add(await ref.watch(assignmentProvider(assignment.id!).future));
//       } catch (e) {
//         logError('Error loading assignment ${assignment.id}',
//             data: {'error': e});
//       }
//     }
//
//     return assignmentModels;
//   }
// }

/// a notifier that retrieves all assignments with their data populated
@riverpod
class Assignments extends _$Assignments {
  @override
  Future<List<AssignmentModel>> build() async {
    final List<DAssignment> assignments =
        await D2Remote.assignmentModuleD.assignment.get();
    List<AssignmentModel> assignmentModels = [];
    for (final assignment in assignments) {
      logDebug('assignment: ${assignment.id}');
      try {
        assignmentModels
            .add(await ref.watch(assignmentProvider(assignment.id!).future));
      } catch (e) {
        logError('Error loading assignment ${assignment.id}',
            data: {'error': e});
      }
    }

    return assignmentModels;
  }
}

/// retrieve a single assignmetn by id populated with data
@riverpod
Future<AssignmentModel> assignment(AssignmentRef ref, String id) async {
  final DAssignment assignment =
      await D2Remote.assignmentModuleD.assignment.byId(id).getOne();
  final activityEntity = await D2Remote.activityModuleD.activity
      .byId(assignment.activity!)
      .getOne();
  final orgUnitEntity = await D2Remote.organisationUnitModuleD.orgUnit
      .byId(assignment.orgUnit!)
      .getOne();
  final teamEntity =
      await D2Remote.teamModuleD.team.byId(assignment.team!).getOne();

  final DTeam userTeam = await D2Remote.teamModuleD.team
      // .where(attribute: 'activity', value: activityEntity.id!)
      .where(attribute: 'scope', value: EntityScope.Assigned.name)
      .getOne();
  final userForms = userTeam.formPermissions.map((fp) => fp.form).toList();

  //
  // final userAssignmentForms = assignment.forms.where((f) => userForms.contains(f)).toList();

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
      activityId: activityEntity?.id,
      activity: activityEntity?.name,
      entityId: orgUnitEntity.id!,
      entityCode: orgUnitEntity.code!,
      entityName: orgUnitEntity.name!,
      teamId: teamEntity.id,
      teamCode: teamEntity.code,
      teamName: teamEntity.name,
      scope: assignment.scope!,
      status: status,
      dueDate: activityEntity.startDate != null
          ? AssignmentModel.calculateAssignmentDate(
              activityEntity.startDate, assignment.startDay)
          : null,
      startDay: assignment.startDay,
      rescheduledDate: assignment.startDate != null
          ? DateTime.parse(assignment.startDate!)
          : null,
      allocatedResources: assignment.allocatedResources
          .map((key, value) => MapEntry(key, value ?? 0)),
      reportedResources: sumActualResources(
          submissions, assignment.allocatedResources.keys.toList()),
      forms: assignment.forms.where((f) => userForms.contains(f)).toList());
}

/// retrieve a managed teams
@riverpod
Future<List<DTeam>> teams(TeamsRef ref,
    {EntityScope scope = EntityScope.Managed}) async {
  final List<DTeam> teams = await D2Remote.teamModuleD.team
      .where(attribute: 'scope', value: scope.name)
      .get();
  return teams
      .map((t) => t..name = '${Intl.message('team')} ${t.code}')
      .toList();
}

@riverpod
Future<DTeam> team(TeamRef ref, String id) async {
  final team = await D2Remote.teamModuleD.team.byId(id).getOne();
  return team..name = '${Intl.message('team')} ${team.code}';
}

/// retrieve a certain assignment forms submissions
@riverpod
Future<List<DataFormSubmission>> assignmentSubmissions(
    AssignmentSubmissionsRef ref, String assignmentId, {String? form}) async {
  final query = D2Remote
      .formModule.dataFormSubmission
      .where(attribute: 'assignment', value: assignmentId);
  if (form != null) {
    query.where(attribute: 'form', value: form);
  }
  final List<DataFormSubmission> submissions = await query
      .get();

  // final futures = submissions.map((submission) async {
  //   return submission
  //     ..formVersion = await D2Remote.formModule.formTemplateV
  //         .byId(submission.formVersion)
  //         .getOne();
  // }).toList();
  //
  // final submissionsWithTemplate =
  //     await Future.wait<DataFormSubmission>(futures);
  return submissions;
}

/// filters the list of assignmnet by certain cretiria
@riverpod
Future<List<AssignmentModel>> filterAssignments(
    FilterAssignmentsRef ref) async {
  final assignments = await ref.watch(assignmentsProvider.future);
  final query = ref.watch(filterQueryProvider);

  final lowerCaseQuery = query.searchQuery.toLowerCase();

  final filteredAssignments = assignments.where((assignment) {
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
          (assignment.teamId == null || !value.contains(assignment.teamId))) {
        return false;
      }
    }

    if (query.searchQuery.isNotEmpty) {
      // final lowerCaseActivity = assignment.activity?.toLowerCase();
      final lowerCaseEntityCode = assignment.entityCode.toLowerCase();
      final lowerCaseEntityName = assignment.entityName.toLowerCase();
      final lowerCaseTeamName = assignment.teamName.toLowerCase();

      if (/*!lowerCaseActivity.contains(lowerCaseQuery) &&*/
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

// @riverpod
// Future<List<FormVersion>> assignmentForms(
//     AssignmentFormsRef ref, String assignmentId) async {
//   final assignments = await ref.watch(assignmentsProvider.future);
//
//   if (assignments.isNotEmpty) {
//     final assignmentForms = assignments
//             .firstOrNullWhere((element) => element.id == assignmentId)
//             ?.forms ??
//         [];
//
//     /// by form Id get the form template, template might has more than one version
//     /// retrieve latest version formTemplate
//     final formVersions = await ref.watch(
//         submissionVersionFormTemplateProvider(formIds: assignmentForms).future);
//     return formVersions;
//   }
//   return [];
// }

class AssignmentModel {
  AssignmentModel({
    required this.id,
    this.activityId,
    this.activity,
    required this.entityId,
    required this.entityCode,
    required this.entityName,
    required this.teamId,
    required this.teamCode,
    required this.teamName,
    required this.scope,
    required this.status,
    this.startDay,
    this.startDate,
    this.dueDate,
    this.rescheduledDate,
    this.allocatedResources = const {},
    this.reportedResources = const {},
    required this.forms,
  });

  final String id;
  String? activityId;
  String? activity;
  final String entityId;
  final String entityCode;
  final String entityName;
  final String teamId;
  final String teamCode;
  final String teamName;
  final EntityScope scope;
  final AssignmentStatus status;
  final int? startDay;
  final String? startDate;
  final DateTime? dueDate;
  final DateTime? rescheduledDate;
  final List<String> forms;
  final Map<String, dynamic> allocatedResources; // E.g., ITNs, Population
  final Map<String, dynamic> reportedResources; // E.g., ITNs, Population

  AssignmentModel copyWith({
    String? id,
    String? activityId,
    String? activity,
    String? entityId,
    String? entityCode,
    String? entityName,
    String? teamId,
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
      activityId: activityId ?? this.activityId,
      activity: activity ?? this.activity,
      entityId: entityId ?? this.entityId,
      entityCode: entityCode ?? this.entityCode,
      entityName: entityName ?? this.entityName,
      teamCode: teamCode ?? this.teamCode,
      teamId: teamId ?? this.teamId,
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

  static DateTime calculateAssignmentDate(
      String activityStartDate, int? startDay) {
    final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", 'en_US');
    final activityStart = dateFormat.parse(activityStartDate);
    return activityStart.add(Duration(days: (startDay ?? 1) - 1));
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
