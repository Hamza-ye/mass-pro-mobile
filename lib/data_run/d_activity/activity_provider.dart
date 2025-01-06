import 'package:d2_remote/core/utilities/list_extensions.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/auth/user/entities/d_user.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
import 'package:datarun/data_run/d_activity/activity_inherited_widget.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_provider.g.dart';

@riverpod
Future<List<DTeam>> teams(TeamsRef ref,
    [EntityScope scope = EntityScope.Managed]) async {
  final List<DTeam> teams = await D2Remote.teamModuleD.team
      .where(attribute: 'scope', value: scope.name)
      .get();

  return teams
      .where((t) => !t.disabled)
      .map((t) => t..name = '${Intl.message('team')} ${t.code}')
      .toList();
}

@riverpod
Future<DTeam?> team(TeamRef ref, String id) async {
  final teams = await ref.watch(teamsProvider().future);
  return teams.firstOrNullWhere((t) => t.id == id);
}

@riverpod
Future<List<ActivityModel>> activities(ActivitiesRef ref) async {
  final List<DTeam> managedTeams =
      await ref.watch(teamsProvider(EntityScope.Managed).future);
  final List<DTeam> assignedTeams =
      await ref.watch(teamsProvider(EntityScope.Assigned).future);
  final DUser? user = await D2Remote.userModule.user.getOne();
  final List<ActivityModel> activities = [];
  for (var assigned in assignedTeams) {
    final DActivity? activity = await D2Remote.activityModuleD.activity
        .byId(assigned.activity!)
        .getOne();
    final activityManagedTeams = managedTeams
        .where((t) => t.activity == activity?.id && activity!.disabled == false)
        .toList();
    final List<DAssignment> assignedAssignment = await D2Remote
        .assignmentModuleD.assignment
        .where(attribute: 'team', value: assigned.id)
        .get();

    final List<DAssignment> managedAssignments = await D2Remote
        .assignmentModuleD.assignment
        .whereIn(
            attribute: 'team',
            values: managedTeams.map((t) => t.id!).toList(),
            merge: true)
        .get();

    final assignedOrgUnits = await D2Remote.organisationUnitModuleD.orgUnit
        .byIds(assignedAssignment.map((a) => a.orgUnit as String).toList())
        .get();

    final managedOrgUnits = await D2Remote.organisationUnitModuleD.orgUnit
        .byIds(managedAssignments.map((a) => a.orgUnit as String).toList())
        .get();

    final assignedTeam =
        assignedTeams.where((t) => t.activity == activity?.id).firstOrNull;
    activities.add(
      ActivityModel(
        user: DRunEntity.fromIdentifiable(identifiableEntity: user!),
        assignedTeam: assignedTeam != null
            ? DRunEntity.fromIdentifiable(identifiableEntity: assignedTeam)
            : null,
        activity: activity != null
            ? DRunEntity.fromIdentifiable(
                identifiableEntity: activity,
                properties: IMap({
                  'startDate': activity.startDate,
                  'endDate': activity.endDate,
                }))
            : null,
        managedAssignments: managedAssignments.length,
        assignedAssignments: assignedAssignment.length,
        assignedForms: assignedTeam?.formPermissions.map((f) => f.form) ?? [],
        managedTeams: activityManagedTeams
            .map((t) => DRunEntity.fromIdentifiable(identifiableEntity: t)),
        orgUnits: [...managedOrgUnits, ...assignedOrgUnits]
            .map((o) => DRunEntity.fromIdentifiable(identifiableEntity: o)),
      ),
    );
  }

  return activities;
}
