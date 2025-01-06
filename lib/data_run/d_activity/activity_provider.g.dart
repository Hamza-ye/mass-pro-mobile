// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$teamsHash() => r'042ff8926449013492e043208c9f53a4fcd2c91c';

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

/// See also [teams].
@ProviderFor(teams)
const teamsProvider = TeamsFamily();

/// See also [teams].
class TeamsFamily extends Family {
  /// See also [teams].
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

  /// See also [teams].
  TeamsProvider call([
    EntityScope scope = EntityScope.Managed,
  ]) {
    return TeamsProvider(
      scope,
    );
  }

  @visibleForOverriding
  @override
  TeamsProvider getProviderOverride(
    covariant TeamsProvider provider,
  ) {
    return call(
      provider.scope,
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

/// See also [teams].
class TeamsProvider extends AutoDisposeFutureProvider<List<DTeam>> {
  /// See also [teams].
  TeamsProvider([
    EntityScope scope = EntityScope.Managed,
  ]) : this._internal(
          (ref) => teams(
            ref as TeamsRef,
            scope,
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
  (EntityScope,) get argument {
    return (scope,);
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

String _$teamHash() => r'665ce88ec77c2ac26ca18fbdcc035c1d35aff48f';

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
  Override overrideWith(FutureOr<DTeam?> Function(TeamRef ref) create) {
    return _$TeamFamilyOverride(this, create);
  }
}

class _$TeamFamilyOverride implements FamilyOverride {
  _$TeamFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<DTeam?> Function(TeamRef ref) create;

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
class TeamProvider extends AutoDisposeFutureProvider<DTeam?> {
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
    FutureOr<DTeam?> Function(TeamRef ref) create,
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
  AutoDisposeFutureProviderElement<DTeam?> createElement() {
    return _TeamProviderElement(this);
  }

  TeamProvider _copyWith(
    FutureOr<DTeam?> Function(TeamRef ref) create,
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

mixin TeamRef on AutoDisposeFutureProviderRef<DTeam?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TeamProviderElement extends AutoDisposeFutureProviderElement<DTeam?>
    with TeamRef {
  _TeamProviderElement(super.provider);

  @override
  String get id => (origin as TeamProvider).id;
}

String _$activitiesHash() => r'fa774abb13fed14625349613711c2cd7a46aacb6';

/// See also [activities].
@ProviderFor(activities)
final activitiesProvider =
    AutoDisposeFutureProvider<List<ActivityModel>>.internal(
  activities,
  name: r'activitiesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$activitiesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ActivitiesRef = AutoDisposeFutureProviderRef<List<ActivityModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
