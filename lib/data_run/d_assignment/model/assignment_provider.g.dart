// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$assignmentHash() => r'209c8fbfc8518f2f170c800a502a9d04a8c43af6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// retrieve a single assignmetn by id populated with data
///
/// Copied from [assignment].
@ProviderFor(assignment)
const assignmentProvider = AssignmentFamily();

/// retrieve a single assignmetn by id populated with data
///
/// Copied from [assignment].
class AssignmentFamily extends Family {
  /// retrieve a single assignmetn by id populated with data
  ///
  /// Copied from [assignment].
  const AssignmentFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'assignmentProvider';

  /// retrieve a single assignmetn by id populated with data
  ///
  /// Copied from [assignment].
  AssignmentProvider call(
    String id,
  ) {
    return AssignmentProvider(
      id,
    );
  }

  @visibleForOverriding
  @override
  AssignmentProvider getProviderOverride(
    covariant AssignmentProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<AssignmentModel> Function(AssignmentRef ref) create) {
    return _$AssignmentFamilyOverride(this, create);
  }
}

class _$AssignmentFamilyOverride implements FamilyOverride {
  _$AssignmentFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<AssignmentModel> Function(AssignmentRef ref) create;

  @override
  final AssignmentFamily overriddenFamily;

  @override
  AssignmentProvider getProviderOverride(
    covariant AssignmentProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// retrieve a single assignmetn by id populated with data
///
/// Copied from [assignment].
class AssignmentProvider extends AutoDisposeFutureProvider<AssignmentModel> {
  /// retrieve a single assignmetn by id populated with data
  ///
  /// Copied from [assignment].
  AssignmentProvider(
    String id,
  ) : this._internal(
          (ref) => assignment(
            ref as AssignmentRef,
            id,
          ),
          from: assignmentProvider,
          name: r'assignmentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$assignmentHash,
          dependencies: AssignmentFamily._dependencies,
          allTransitiveDependencies:
              AssignmentFamily._allTransitiveDependencies,
          id: id,
        );

  AssignmentProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<AssignmentModel> Function(AssignmentRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AssignmentProvider._internal(
        (ref) => create(ref as AssignmentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  (String,) get argument {
    return (id,);
  }

  @override
  AutoDisposeFutureProviderElement<AssignmentModel> createElement() {
    return _AssignmentProviderElement(this);
  }

  AssignmentProvider _copyWith(
    FutureOr<AssignmentModel> Function(AssignmentRef ref) create,
  ) {
    return AssignmentProvider._internal(
      (ref) => create(ref as AssignmentRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      id: id,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AssignmentProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AssignmentRef on AutoDisposeFutureProviderRef<AssignmentModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _AssignmentProviderElement
    extends AutoDisposeFutureProviderElement<AssignmentModel>
    with AssignmentRef {
  _AssignmentProviderElement(super.provider);

  @override
  String get id => (origin as AssignmentProvider).id;
}

String _$teamsHash() => r'fe6a349f014610e5e8b1c8fea2c302c4668e29cd';

/// retrieve a managed teams
///
/// Copied from [teams].
@ProviderFor(teams)
const teamsProvider = TeamsFamily();

/// retrieve a managed teams
///
/// Copied from [teams].
class TeamsFamily extends Family {
  /// retrieve a managed teams
  ///
  /// Copied from [teams].
  const TeamsFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'teamsProvider';

  /// retrieve a managed teams
  ///
  /// Copied from [teams].
  TeamsProvider call({
    EntityScope scope = EntityScope.Managed,
  }) {
    return TeamsProvider(
      scope: scope,
    );
  }

  @visibleForOverriding
  @override
  TeamsProvider getProviderOverride(
    covariant TeamsProvider provider,
  ) {
    return call(
      scope: provider.scope,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(FutureOr<List<DTeam>> Function(TeamsRef ref) create) {
    return _$TeamsFamilyOverride(this, create);
  }
}

class _$TeamsFamilyOverride implements FamilyOverride {
  _$TeamsFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<DTeam>> Function(TeamsRef ref) create;

  @override
  final TeamsFamily overriddenFamily;

  @override
  TeamsProvider getProviderOverride(
    covariant TeamsProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// retrieve a managed teams
///
/// Copied from [teams].
class TeamsProvider extends AutoDisposeFutureProvider<List<DTeam>> {
  /// retrieve a managed teams
  ///
  /// Copied from [teams].
  TeamsProvider({
    EntityScope scope = EntityScope.Managed,
  }) : this._internal(
          (ref) => teams(
            ref as TeamsRef,
            scope: scope,
          ),
          from: teamsProvider,
          name: r'teamsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$teamsHash,
          dependencies: TeamsFamily._dependencies,
          allTransitiveDependencies: TeamsFamily._allTransitiveDependencies,
          scope: scope,
        );

  TeamsProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.scope,
  }) : super.internal();

  final EntityScope scope;

  @override
  Override overrideWith(
    FutureOr<List<DTeam>> Function(TeamsRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeamsProvider._internal(
        (ref) => create(ref as TeamsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        scope: scope,
      ),
    );
  }

  @override
  ({
    EntityScope scope,
  }) get argument {
    return (scope: scope,);
  }

  @override
  AutoDisposeFutureProviderElement<List<DTeam>> createElement() {
    return _TeamsProviderElement(this);
  }

  TeamsProvider _copyWith(
    FutureOr<List<DTeam>> Function(TeamsRef ref) create,
  ) {
    return TeamsProvider._internal(
      (ref) => create(ref as TeamsRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      scope: scope,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TeamsProvider && other.scope == scope;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, scope.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TeamsRef on AutoDisposeFutureProviderRef<List<DTeam>> {
  /// The parameter `scope` of this provider.
  EntityScope get scope;
}

class _TeamsProviderElement
    extends AutoDisposeFutureProviderElement<List<DTeam>> with TeamsRef {
  _TeamsProviderElement(super.provider);

  @override
  EntityScope get scope => (origin as TeamsProvider).scope;
}

String _$teamHash() => r'b2950ba1544381a31afcc2bc8d0623c924d3459a';

/// See also [team].
@ProviderFor(team)
const teamProvider = TeamFamily();

/// See also [team].
class TeamFamily extends Family {
  /// See also [team].
  const TeamFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'teamProvider';

  /// See also [team].
  TeamProvider call(
    String id,
  ) {
    return TeamProvider(
      id,
    );
  }

  @visibleForOverriding
  @override
  TeamProvider getProviderOverride(
    covariant TeamProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(FutureOr<DTeam> Function(TeamRef ref) create) {
    return _$TeamFamilyOverride(this, create);
  }
}

class _$TeamFamilyOverride implements FamilyOverride {
  _$TeamFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<DTeam> Function(TeamRef ref) create;

  @override
  final TeamFamily overriddenFamily;

  @override
  TeamProvider getProviderOverride(
    covariant TeamProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [team].
class TeamProvider extends AutoDisposeFutureProvider<DTeam> {
  /// See also [team].
  TeamProvider(
    String id,
  ) : this._internal(
          (ref) => team(
            ref as TeamRef,
            id,
          ),
          from: teamProvider,
          name: r'teamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$teamHash,
          dependencies: TeamFamily._dependencies,
          allTransitiveDependencies: TeamFamily._allTransitiveDependencies,
          id: id,
        );

  TeamProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<DTeam> Function(TeamRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeamProvider._internal(
        (ref) => create(ref as TeamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  (String,) get argument {
    return (id,);
  }

  @override
  AutoDisposeFutureProviderElement<DTeam> createElement() {
    return _TeamProviderElement(this);
  }

  TeamProvider _copyWith(
    FutureOr<DTeam> Function(TeamRef ref) create,
  ) {
    return TeamProvider._internal(
      (ref) => create(ref as TeamRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      id: id,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TeamProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TeamRef on AutoDisposeFutureProviderRef<DTeam> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TeamProviderElement extends AutoDisposeFutureProviderElement<DTeam>
    with TeamRef {
  _TeamProviderElement(super.provider);

  @override
  String get id => (origin as TeamProvider).id;
}

String _$assignmentSubmissionsHash() =>
    r'e11403098d858244ae5c33837879a90cdedd377c';

/// retrieve a certain assignment forms submissions
///
/// Copied from [assignmentSubmissions].
@ProviderFor(assignmentSubmissions)
const assignmentSubmissionsProvider = AssignmentSubmissionsFamily();

/// retrieve a certain assignment forms submissions
///
/// Copied from [assignmentSubmissions].
class AssignmentSubmissionsFamily extends Family {
  /// retrieve a certain assignment forms submissions
  ///
  /// Copied from [assignmentSubmissions].
  const AssignmentSubmissionsFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'assignmentSubmissionsProvider';

  /// retrieve a certain assignment forms submissions
  ///
  /// Copied from [assignmentSubmissions].
  AssignmentSubmissionsProvider call(
    String assignmentId, {
    String? form,
  }) {
    return AssignmentSubmissionsProvider(
      assignmentId,
      form: form,
    );
  }

  @visibleForOverriding
  @override
  AssignmentSubmissionsProvider getProviderOverride(
    covariant AssignmentSubmissionsProvider provider,
  ) {
    return call(
      provider.assignmentId,
      form: provider.form,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<DataFormSubmission>> Function(AssignmentSubmissionsRef ref)
          create) {
    return _$AssignmentSubmissionsFamilyOverride(this, create);
  }
}

class _$AssignmentSubmissionsFamilyOverride implements FamilyOverride {
  _$AssignmentSubmissionsFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<DataFormSubmission>> Function(
      AssignmentSubmissionsRef ref) create;

  @override
  final AssignmentSubmissionsFamily overriddenFamily;

  @override
  AssignmentSubmissionsProvider getProviderOverride(
    covariant AssignmentSubmissionsProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// retrieve a certain assignment forms submissions
///
/// Copied from [assignmentSubmissions].
class AssignmentSubmissionsProvider
    extends AutoDisposeFutureProvider<List<DataFormSubmission>> {
  /// retrieve a certain assignment forms submissions
  ///
  /// Copied from [assignmentSubmissions].
  AssignmentSubmissionsProvider(
    String assignmentId, {
    String? form,
  }) : this._internal(
          (ref) => assignmentSubmissions(
            ref as AssignmentSubmissionsRef,
            assignmentId,
            form: form,
          ),
          from: assignmentSubmissionsProvider,
          name: r'assignmentSubmissionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$assignmentSubmissionsHash,
          dependencies: AssignmentSubmissionsFamily._dependencies,
          allTransitiveDependencies:
              AssignmentSubmissionsFamily._allTransitiveDependencies,
          assignmentId: assignmentId,
          form: form,
        );

  AssignmentSubmissionsProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.assignmentId,
    required this.form,
  }) : super.internal();

  final String assignmentId;
  final String? form;

  @override
  Override overrideWith(
    FutureOr<List<DataFormSubmission>> Function(AssignmentSubmissionsRef ref)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AssignmentSubmissionsProvider._internal(
        (ref) => create(ref as AssignmentSubmissionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        assignmentId: assignmentId,
        form: form,
      ),
    );
  }

  @override
  (
    String, {
    String? form,
  }) get argument {
    return (
      assignmentId,
      form: form,
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DataFormSubmission>> createElement() {
    return _AssignmentSubmissionsProviderElement(this);
  }

  AssignmentSubmissionsProvider _copyWith(
    FutureOr<List<DataFormSubmission>> Function(AssignmentSubmissionsRef ref)
        create,
  ) {
    return AssignmentSubmissionsProvider._internal(
      (ref) => create(ref as AssignmentSubmissionsRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      assignmentId: assignmentId,
      form: form,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AssignmentSubmissionsProvider &&
        other.assignmentId == assignmentId &&
        other.form == form;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, assignmentId.hashCode);
    hash = _SystemHash.combine(hash, form.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AssignmentSubmissionsRef
    on AutoDisposeFutureProviderRef<List<DataFormSubmission>> {
  /// The parameter `assignmentId` of this provider.
  String get assignmentId;

  /// The parameter `form` of this provider.
  String? get form;
}

class _AssignmentSubmissionsProviderElement
    extends AutoDisposeFutureProviderElement<List<DataFormSubmission>>
    with AssignmentSubmissionsRef {
  _AssignmentSubmissionsProviderElement(super.provider);

  @override
  String get assignmentId =>
      (origin as AssignmentSubmissionsProvider).assignmentId;
  @override
  String? get form => (origin as AssignmentSubmissionsProvider).form;
}

String _$filterAssignmentsHash() => r'269bebba4a45155f33e4f4dbed186c525df820eb';

/// filters the list of assignmnet by certain cretiria
///
/// Copied from [filterAssignments].
@ProviderFor(filterAssignments)
final filterAssignmentsProvider =
    AutoDisposeFutureProvider<List<AssignmentModel>>.internal(
  filterAssignments,
  name: r'filterAssignmentsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filterAssignmentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilterAssignmentsRef
    = AutoDisposeFutureProviderRef<List<AssignmentModel>>;
String _$assignmentsHash() => r'338a008ce7feabf4f153d5420301f3ccb7cc9a1e';

/// a notifier that retrieves all assignments with their data populated
///
/// Copied from [Assignments].
@ProviderFor(Assignments)
final assignmentsProvider = AutoDisposeAsyncNotifierProvider<Assignments,
    List<AssignmentModel>>.internal(
  Assignments.new,
  name: r'assignmentsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$assignmentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Assignments = AutoDisposeAsyncNotifier<List<AssignmentModel>>;
String _$filterQueryHash() => r'e9b231b7ab451bc9d6ab4286075ad15934b2773f';

/// filter query model notifier that store filtering cretirias
///
/// Copied from [FilterQuery].
@ProviderFor(FilterQuery)
final filterQueryProvider =
    AutoDisposeNotifierProvider<FilterQuery, AssignmentFilterQuery>.internal(
  FilterQuery.new,
  name: r'filterQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$filterQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FilterQuery = AutoDisposeNotifier<AssignmentFilterQuery>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
