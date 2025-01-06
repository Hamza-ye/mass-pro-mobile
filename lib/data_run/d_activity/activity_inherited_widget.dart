import 'package:d2_remote/modules/auth/user/entities/d_user.entity.dart';
import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
import 'package:d2_remote/modules/metadatarun/org_unit/entities/org_unit.entity.dart';
import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
import 'package:d2_remote/shared/entities/identifiable.entity.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

class ActivityInheritedWidget extends InheritedWidget {
  const ActivityInheritedWidget({
    super.key,
    required this.activityModel,
    required super.child,
  });

  final ActivityModel activityModel;

  static ActivityModel of(BuildContext context) {
    final ActivityInheritedWidget? inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<ActivityInheritedWidget>();
    if (inheritedWidget == null) {
      throw 'No ActivityInheritedWidget found in context.';
    }
    return inheritedWidget.activityModel;
  }

  @override
  bool updateShouldNotify(covariant ActivityInheritedWidget oldWidget) {
    return oldWidget.activityModel != activityModel;
  }
}

class ActivityModel with EquatableMixin {
  ActivityModel(
      {Iterable<DRunEntity> managedTeams = const [],
      Iterable<DRunEntity> orgUnits = const [],
      Iterable<String> assignedForms = const [],
      this.assignedAssignments = 0,
      this.managedAssignments = 0,
      required this.user,
      this.assignedTeam,
      this.activity})
      : this.managedTeams = IList(managedTeams),
        this.orgUnits = IList(orgUnits),
        this.assignedForms = IList(assignedForms);

  factory ActivityModel.fromIdentifiable(
      {Iterable<DTeam> managedTeams = const [],
      Iterable<OrgUnit> orgUnits = const [],
      Iterable<String> assignedForms = const [],
      DUser? user,
      DTeam? userTeam,
      DActivity? activity,
      int assignedAssignments = 0,
      int managedAssignments = 0}) {
    return ActivityModel(
      assignedAssignments: assignedAssignments,
      managedAssignments: managedAssignments,
      assignedForms: assignedForms,
      managedTeams: managedTeams.map((e) => DRunEntity(
            id: e.id,
            code: e.code,
            name: e.name,
          )),
      orgUnits: orgUnits.map((e) => DRunEntity(
            id: e.id,
            code: e.code,
            name: e.name,
          )),
      user: DRunEntity(
        id: user!.id,
        code: user.code,
        name: user.name,
      ),
      assignedTeam: userTeam != null
          ? DRunEntity(
              id: userTeam.id,
              code: userTeam.code,
              name: userTeam.name,
            )
          : null,
      activity: activity != null
          ? DRunEntity(
              id: activity.id,
              code: activity.code,
              name: activity.name,
            )
          : null,
    );
  }

  final IList<DRunEntity> managedTeams;
  final IList<DRunEntity> orgUnits;
  final IList<String> assignedForms;
  final DRunEntity user;
  final DRunEntity? assignedTeam;
  final DRunEntity? activity;

  final int assignedAssignments;
  final int managedAssignments;

  ActivityModel copyWith({
    Iterable<DRunEntity>? managedTeams,
    Iterable<DRunEntity>? orgUnits,
    Iterable<String>? assignedForms,
    DRunEntity? user,
    DRunEntity? userTeam,
    DRunEntity? activity,
  }) {
    return ActivityModel(
      assignedForms: assignedForms ?? this.assignedForms,
      managedTeams: managedTeams ?? this.managedTeams,
      orgUnits: orgUnits ?? this.orgUnits,
      user: user ?? this.user,
      assignedTeam: userTeam ?? this.assignedTeam,
      activity: activity ?? this.activity,
    );
  }

  @override
  List<Object?> get props =>
      [managedTeams, orgUnits, user, assignedTeam, activity, assignedForms];
}

class DRunEntity with EquatableMixin {
  DRunEntity(
      {this.id,
      this.code,
      this.name,
      IMap<String, dynamic> label = const IMapConst({}),
      IMap<String, dynamic> properties = const IMapConst({})})
      : this.label = label,
        this.properties = properties;

  factory DRunEntity.fromIdentifiable(
      {required IdentifiableEntity identifiableEntity,
      IMap<String, dynamic> label = const IMapConst({}),
      IMap<String, dynamic> properties = const IMapConst({})}) {
    return DRunEntity(
      id: identifiableEntity.id,
      code: identifiableEntity.code,
      name: identifiableEntity.name,
      label: label,
      properties: properties,
    );
  }

  final String? id;
  final String? code;
  final String? name;
  final IMap<String, dynamic> label;
  final IMap<String, dynamic> properties;

  DRunEntity copyWith({
    String? id,
    String? code,
    String? name,
    IMap<String, dynamic>? label,
    IMap<String, dynamic>? properties,
  }) {
    return DRunEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      label: label ?? this.label,
      properties: properties ?? this.properties,
    );
  }

  @override
  List<Object?> get props => [id, code, name, label, properties];
}
