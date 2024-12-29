// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filterAssignmentsHash() => r'962646026ac6bfc2136171264764d9bc47394fe6';

/// See also [filterAssignments].
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
String _$assignmentsHash() => r'c198ca5969302bc819153095004493241849be37';

/// See also [Assignments].
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
String _$assignmentSubmissionsHash() =>
    r'f52fb43fb987076c3e02bbec5216374c31b10188';

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

abstract class _$AssignmentSubmissions
    extends BuildlessAutoDisposeAsyncNotifier<List<DataFormSubmission>> {
  late final String assignmentId;

  FutureOr<List<DataFormSubmission>> build(
    String assignmentId,
  );
}

/// See also [AssignmentSubmissions].
@ProviderFor(AssignmentSubmissions)
const assignmentSubmissionsProvider = AssignmentSubmissionsFamily();

/// See also [AssignmentSubmissions].
class AssignmentSubmissionsFamily extends Family {
  /// See also [AssignmentSubmissions].
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

  /// See also [AssignmentSubmissions].
  AssignmentSubmissionsProvider call(
    String assignmentId,
  ) {
    return AssignmentSubmissionsProvider(
      assignmentId,
    );
  }

  @visibleForOverriding
  @override
  AssignmentSubmissionsProvider getProviderOverride(
    covariant AssignmentSubmissionsProvider provider,
  ) {
    return call(
      provider.assignmentId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(AssignmentSubmissions Function() create) {
    return _$AssignmentSubmissionsFamilyOverride(this, create);
  }
}

class _$AssignmentSubmissionsFamilyOverride implements FamilyOverride {
  _$AssignmentSubmissionsFamilyOverride(this.overriddenFamily, this.create);

  final AssignmentSubmissions Function() create;

  @override
  final AssignmentSubmissionsFamily overriddenFamily;

  @override
  AssignmentSubmissionsProvider getProviderOverride(
    covariant AssignmentSubmissionsProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [AssignmentSubmissions].
class AssignmentSubmissionsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AssignmentSubmissions,
        List<DataFormSubmission>> {
  /// See also [AssignmentSubmissions].
  AssignmentSubmissionsProvider(
    String assignmentId,
  ) : this._internal(
          () => AssignmentSubmissions()..assignmentId = assignmentId,
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
        );

  AssignmentSubmissionsProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.assignmentId,
  }) : super.internal();

  final String assignmentId;

  @override
  FutureOr<List<DataFormSubmission>> runNotifierBuild(
    covariant AssignmentSubmissions notifier,
  ) {
    return notifier.build(
      assignmentId,
    );
  }

  @override
  Override overrideWith(AssignmentSubmissions Function() create) {
    return ProviderOverride(
      origin: this,
      override: AssignmentSubmissionsProvider._internal(
        () => create()..assignmentId = assignmentId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        assignmentId: assignmentId,
      ),
    );
  }

  @override
  (String,) get argument {
    return (assignmentId,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AssignmentSubmissions,
      List<DataFormSubmission>> createElement() {
    return _AssignmentSubmissionsProviderElement(this);
  }

  AssignmentSubmissionsProvider _copyWith(
    AssignmentSubmissions Function() create,
  ) {
    return AssignmentSubmissionsProvider._internal(
      () => create()..assignmentId = assignmentId,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      assignmentId: assignmentId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AssignmentSubmissionsProvider &&
        other.assignmentId == assignmentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, assignmentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AssignmentSubmissionsRef
    on AutoDisposeAsyncNotifierProviderRef<List<DataFormSubmission>> {
  /// The parameter `assignmentId` of this provider.
  String get assignmentId;
}

class _AssignmentSubmissionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AssignmentSubmissions,
        List<DataFormSubmission>> with AssignmentSubmissionsRef {
  _AssignmentSubmissionsProviderElement(super.provider);

  @override
  String get assignmentId =>
      (origin as AssignmentSubmissionsProvider).assignmentId;
}

String _$filterQueryHash() => r'4bc1ecc63f188d2f1f85ed7d233ab11815cfe07a';

/// See also [FilterQuery].
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
