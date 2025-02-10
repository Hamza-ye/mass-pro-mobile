// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$submissionIdHash() => r'7b099f455b9679955e638dd644f3ee451a97a9fa';

/// See also [submissionId].
@ProviderFor(submissionId)
final submissionIdProvider = AutoDisposeProvider<String>.internal(
  submissionId,
  name: r'submissionIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$submissionIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SubmissionIdRef = AutoDisposeProviderRef<String>;
String _$parentElementHash() => r'69b313d177171ec8de9f0e2522f2ffa2e98d1b07';

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

/// See also [parentElement].
@ProviderFor(parentElement)
const parentElementProvider = ParentElementFamily();

/// See also [parentElement].
class ParentElementFamily extends Family {
  /// See also [parentElement].
  const ParentElementFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'parentElementProvider';

  /// See also [parentElement].
  ParentElementProvider<T> call<T extends SectionState>() {
    return ParentElementProvider<T>();
  }

  @visibleForOverriding
  @override
  ParentElementProvider<SectionState> getProviderOverride(
    covariant ParentElementProvider<SectionState> provider,
  ) {
    return call();
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      T? Function<T extends SectionState>(ParentElementRef ref) create) {
    return _$ParentElementFamilyOverride(this, create);
  }
}

class _$ParentElementFamilyOverride implements FamilyOverride {
  _$ParentElementFamilyOverride(this.overriddenFamily, this.create);

  final T? Function<T extends SectionState>(ParentElementRef ref) create;

  @override
  final ParentElementFamily overriddenFamily;

  @override
  ParentElementProvider getProviderOverride(
    covariant ParentElementProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [parentElement].
class ParentElementProvider<T extends SectionState>
    extends AutoDisposeProvider<T?> {
  /// See also [parentElement].
  ParentElementProvider()
      : this._internal(
          (ref) => parentElement<T>(
            ref as ParentElementRef<T>,
          ),
          from: parentElementProvider,
          name: r'parentElementProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$parentElementHash,
          dependencies: ParentElementFamily._dependencies,
          allTransitiveDependencies:
              ParentElementFamily._allTransitiveDependencies,
        );

  ParentElementProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
  }) : super.internal();

  @override
  Override overrideWith(
    T? Function(ParentElementRef<T> ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ParentElementProvider<T>._internal(
        (ref) => create(ref as ParentElementRef<T>),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
      ),
    );
  }

  @override
  () get argument {
    return ();
  }

  @override
  AutoDisposeProviderElement<T?> createElement() {
    return _ParentElementProviderElement(this);
  }

  ParentElementProvider _copyWith(
    T? Function<T extends SectionState>(ParentElementRef ref) create,
  ) {
    return ParentElementProvider._internal(
      (ref) => create(ref as ParentElementRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ParentElementProvider && other.runtimeType == runtimeType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, T.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ParentElementRef<T extends SectionState> on AutoDisposeProviderRef<T?> {}

class _ParentElementProviderElement<T extends SectionState>
    extends AutoDisposeProviderElement<T?> with ParentElementRef<T> {
  _ParentElementProviderElement(super.provider);
}

String _$submissionFormTemplateHash() =>
    r'fb8c4a41433a526cd1589980e99792b00c1df3b9';

/// See also [submissionFormTemplate].
@ProviderFor(submissionFormTemplate)
final submissionFormTemplateProvider =
    AutoDisposeFutureProvider<FormFlatTemplate>.internal(
  submissionFormTemplate,
  name: r'submissionFormTemplateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$submissionFormTemplateHash,
  dependencies: <ProviderOrFamily>[submissionIdProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    submissionIdProvider,
    ...?submissionIdProvider.allTransitiveDependencies
  },
);

typedef SubmissionFormTemplateRef
    = AutoDisposeFutureProviderRef<FormFlatTemplate>;
String _$formStateNotifierHash() => r'a6c3a73965ab8599b1721661ef84d237ffce8510';

/// See also [FormStateNotifier].
@ProviderFor(FormStateNotifier)
final formStateNotifierProvider =
    AutoDisposeAsyncNotifierProvider<FormStateNotifier, FormState>.internal(
  FormStateNotifier.new,
  name: r'formStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$formStateNotifierHash,
  dependencies: <ProviderOrFamily>[submissionFormTemplateProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    submissionFormTemplateProvider,
    ...?submissionFormTemplateProvider.allTransitiveDependencies
  },
);

typedef _$FormStateNotifier = AutoDisposeAsyncNotifier<FormState>;
String _$sectionStateNotifierHash() =>
    r'22132157b11feeb5f56e253dd3d73f0a44a9643f';

abstract class _$SectionStateNotifier
    extends BuildlessAutoDisposeAsyncNotifier<SectionState> {
  late final String path;

  FutureOr<SectionState> build(
    String path,
  );
}

/// See also [SectionStateNotifier].
@ProviderFor(SectionStateNotifier)
const sectionStateNotifierProvider = SectionStateNotifierFamily();

/// See also [SectionStateNotifier].
class SectionStateNotifierFamily extends Family {
  /// See also [SectionStateNotifier].
  const SectionStateNotifierFamily();

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    submissionFormTemplateProvider,
    parentElementProvider
  ];

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    submissionFormTemplateProvider,
    ...?submissionFormTemplateProvider.allTransitiveDependencies,
    parentElementProvider,
    ...?parentElementProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sectionStateNotifierProvider';

  /// See also [SectionStateNotifier].
  SectionStateNotifierProvider call(
    String path,
  ) {
    return SectionStateNotifierProvider(
      path,
    );
  }

  @visibleForOverriding
  @override
  SectionStateNotifierProvider getProviderOverride(
    covariant SectionStateNotifierProvider provider,
  ) {
    return call(
      provider.path,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(SectionStateNotifier Function() create) {
    return _$SectionStateNotifierFamilyOverride(this, create);
  }
}

class _$SectionStateNotifierFamilyOverride implements FamilyOverride {
  _$SectionStateNotifierFamilyOverride(this.overriddenFamily, this.create);

  final SectionStateNotifier Function() create;

  @override
  final SectionStateNotifierFamily overriddenFamily;

  @override
  SectionStateNotifierProvider getProviderOverride(
    covariant SectionStateNotifierProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [SectionStateNotifier].
class SectionStateNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    SectionStateNotifier, SectionState> {
  /// See also [SectionStateNotifier].
  SectionStateNotifierProvider(
    String path,
  ) : this._internal(
          () => SectionStateNotifier()..path = path,
          from: sectionStateNotifierProvider,
          name: r'sectionStateNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectionStateNotifierHash,
          dependencies: SectionStateNotifierFamily._dependencies,
          allTransitiveDependencies:
              SectionStateNotifierFamily._allTransitiveDependencies,
          path: path,
        );

  SectionStateNotifierProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
  }) : super.internal();

  final String path;

  @override
  FutureOr<SectionState> runNotifierBuild(
    covariant SectionStateNotifier notifier,
  ) {
    return notifier.build(
      path,
    );
  }

  @override
  Override overrideWith(SectionStateNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SectionStateNotifierProvider._internal(
        () => create()..path = path,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
      ),
    );
  }

  @override
  (String,) get argument {
    return (path,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SectionStateNotifier, SectionState>
      createElement() {
    return _SectionStateNotifierProviderElement(this);
  }

  SectionStateNotifierProvider _copyWith(
    SectionStateNotifier Function() create,
  ) {
    return SectionStateNotifierProvider._internal(
      () => create()..path = path,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      path: path,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SectionStateNotifierProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectionStateNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<SectionState> {
  /// The parameter `path` of this provider.
  String get path;
}

class _SectionStateNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SectionStateNotifier,
        SectionState> with SectionStateNotifierRef {
  _SectionStateNotifierProviderElement(super.provider);

  @override
  String get path => (origin as SectionStateNotifierProvider).path;
}

String _$repeatStateNotifierHash() =>
    r'56b8626032e77ae2b9048dd675958d8abd6a7248';

abstract class _$RepeatStateNotifier
    extends BuildlessAutoDisposeAsyncNotifier<RepeatState> {
  late final String path;

  FutureOr<RepeatState> build(
    String path,
  );
}

/// See also [RepeatStateNotifier].
@ProviderFor(RepeatStateNotifier)
const repeatStateNotifierProvider = RepeatStateNotifierFamily();

/// See also [RepeatStateNotifier].
class RepeatStateNotifierFamily extends Family {
  /// See also [RepeatStateNotifier].
  const RepeatStateNotifierFamily();

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    submissionFormTemplateProvider,
    parentElementProvider
  ];

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    submissionFormTemplateProvider,
    ...?submissionFormTemplateProvider.allTransitiveDependencies,
    parentElementProvider,
    ...?parentElementProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'repeatStateNotifierProvider';

  /// See also [RepeatStateNotifier].
  RepeatStateNotifierProvider call(
    String path,
  ) {
    return RepeatStateNotifierProvider(
      path,
    );
  }

  @visibleForOverriding
  @override
  RepeatStateNotifierProvider getProviderOverride(
    covariant RepeatStateNotifierProvider provider,
  ) {
    return call(
      provider.path,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(RepeatStateNotifier Function() create) {
    return _$RepeatStateNotifierFamilyOverride(this, create);
  }
}

class _$RepeatStateNotifierFamilyOverride implements FamilyOverride {
  _$RepeatStateNotifierFamilyOverride(this.overriddenFamily, this.create);

  final RepeatStateNotifier Function() create;

  @override
  final RepeatStateNotifierFamily overriddenFamily;

  @override
  RepeatStateNotifierProvider getProviderOverride(
    covariant RepeatStateNotifierProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [RepeatStateNotifier].
class RepeatStateNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    RepeatStateNotifier, RepeatState> {
  /// See also [RepeatStateNotifier].
  RepeatStateNotifierProvider(
    String path,
  ) : this._internal(
          () => RepeatStateNotifier()..path = path,
          from: repeatStateNotifierProvider,
          name: r'repeatStateNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$repeatStateNotifierHash,
          dependencies: RepeatStateNotifierFamily._dependencies,
          allTransitiveDependencies:
              RepeatStateNotifierFamily._allTransitiveDependencies,
          path: path,
        );

  RepeatStateNotifierProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
  }) : super.internal();

  final String path;

  @override
  FutureOr<RepeatState> runNotifierBuild(
    covariant RepeatStateNotifier notifier,
  ) {
    return notifier.build(
      path,
    );
  }

  @override
  Override overrideWith(RepeatStateNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: RepeatStateNotifierProvider._internal(
        () => create()..path = path,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
      ),
    );
  }

  @override
  (String,) get argument {
    return (path,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<RepeatStateNotifier, RepeatState>
      createElement() {
    return _RepeatStateNotifierProviderElement(this);
  }

  RepeatStateNotifierProvider _copyWith(
    RepeatStateNotifier Function() create,
  ) {
    return RepeatStateNotifierProvider._internal(
      () => create()..path = path,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      path: path,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RepeatStateNotifierProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RepeatStateNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<RepeatState> {
  /// The parameter `path` of this provider.
  String get path;
}

class _RepeatStateNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RepeatStateNotifier,
        RepeatState> with RepeatStateNotifierRef {
  _RepeatStateNotifierProviderElement(super.provider);

  @override
  String get path => (origin as RepeatStateNotifierProvider).path;
}

String _$repeatRowStateNotifierHash() =>
    r'efd17b26392eb38a58500fdfcf3928c9552f327f';

abstract class _$RepeatRowStateNotifier
    extends BuildlessAutoDisposeAsyncNotifier<RowState> {
  late final String path;
  late final String repeatUid;

  FutureOr<RowState> build(
    String path,
    String repeatUid,
  );
}

/// See also [RepeatRowStateNotifier].
@ProviderFor(RepeatRowStateNotifier)
const repeatRowStateNotifierProvider = RepeatRowStateNotifierFamily();

/// See also [RepeatRowStateNotifier].
class RepeatRowStateNotifierFamily extends Family {
  /// See also [RepeatRowStateNotifier].
  const RepeatRowStateNotifierFamily();

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    submissionFormTemplateProvider,
    parentElementProvider
  ];

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    submissionFormTemplateProvider,
    ...?submissionFormTemplateProvider.allTransitiveDependencies,
    parentElementProvider,
    ...?parentElementProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'repeatRowStateNotifierProvider';

  /// See also [RepeatRowStateNotifier].
  RepeatRowStateNotifierProvider call(
    String path,
    String repeatUid,
  ) {
    return RepeatRowStateNotifierProvider(
      path,
      repeatUid,
    );
  }

  @visibleForOverriding
  @override
  RepeatRowStateNotifierProvider getProviderOverride(
    covariant RepeatRowStateNotifierProvider provider,
  ) {
    return call(
      provider.path,
      provider.repeatUid,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(RepeatRowStateNotifier Function() create) {
    return _$RepeatRowStateNotifierFamilyOverride(this, create);
  }
}

class _$RepeatRowStateNotifierFamilyOverride implements FamilyOverride {
  _$RepeatRowStateNotifierFamilyOverride(this.overriddenFamily, this.create);

  final RepeatRowStateNotifier Function() create;

  @override
  final RepeatRowStateNotifierFamily overriddenFamily;

  @override
  RepeatRowStateNotifierProvider getProviderOverride(
    covariant RepeatRowStateNotifierProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [RepeatRowStateNotifier].
class RepeatRowStateNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<RepeatRowStateNotifier,
        RowState> {
  /// See also [RepeatRowStateNotifier].
  RepeatRowStateNotifierProvider(
    String path,
    String repeatUid,
  ) : this._internal(
          () => RepeatRowStateNotifier()
            ..path = path
            ..repeatUid = repeatUid,
          from: repeatRowStateNotifierProvider,
          name: r'repeatRowStateNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$repeatRowStateNotifierHash,
          dependencies: RepeatRowStateNotifierFamily._dependencies,
          allTransitiveDependencies:
              RepeatRowStateNotifierFamily._allTransitiveDependencies,
          path: path,
          repeatUid: repeatUid,
        );

  RepeatRowStateNotifierProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
    required this.repeatUid,
  }) : super.internal();

  final String path;
  final String repeatUid;

  @override
  FutureOr<RowState> runNotifierBuild(
    covariant RepeatRowStateNotifier notifier,
  ) {
    return notifier.build(
      path,
      repeatUid,
    );
  }

  @override
  Override overrideWith(RepeatRowStateNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: RepeatRowStateNotifierProvider._internal(
        () => create()
          ..path = path
          ..repeatUid = repeatUid,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
        repeatUid: repeatUid,
      ),
    );
  }

  @override
  (
    String,
    String,
  ) get argument {
    return (
      path,
      repeatUid,
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<RepeatRowStateNotifier, RowState>
      createElement() {
    return _RepeatRowStateNotifierProviderElement(this);
  }

  RepeatRowStateNotifierProvider _copyWith(
    RepeatRowStateNotifier Function() create,
  ) {
    return RepeatRowStateNotifierProvider._internal(
      () => create()
        ..path = path
        ..repeatUid = repeatUid,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      path: path,
      repeatUid: repeatUid,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RepeatRowStateNotifierProvider &&
        other.path == path &&
        other.repeatUid == repeatUid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);
    hash = _SystemHash.combine(hash, repeatUid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RepeatRowStateNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<RowState> {
  /// The parameter `path` of this provider.
  String get path;

  /// The parameter `repeatUid` of this provider.
  String get repeatUid;
}

class _RepeatRowStateNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RepeatRowStateNotifier,
        RowState> with RepeatRowStateNotifierRef {
  _RepeatRowStateNotifierProviderElement(super.provider);

  @override
  String get path => (origin as RepeatRowStateNotifierProvider).path;
  @override
  String get repeatUid => (origin as RepeatRowStateNotifierProvider).repeatUid;
}

String _$fieldStateNotifierHash() =>
    r'17ae7745ee446b16276bb75df878461e0f6507f4';

abstract class _$FieldStateNotifier
    extends BuildlessAutoDisposeAsyncNotifier<FieldState> {
  late final String path;

  FutureOr<FieldState> build(
    String path,
  );
}

/// See also [FieldStateNotifier].
@ProviderFor(FieldStateNotifier)
const fieldStateNotifierProvider = FieldStateNotifierFamily();

/// See also [FieldStateNotifier].
class FieldStateNotifierFamily extends Family {
  /// See also [FieldStateNotifier].
  const FieldStateNotifierFamily();

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    submissionFormTemplateProvider,
    parentElementProvider
  ];

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    submissionFormTemplateProvider,
    ...?submissionFormTemplateProvider.allTransitiveDependencies,
    parentElementProvider,
    ...?parentElementProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fieldStateNotifierProvider';

  /// See also [FieldStateNotifier].
  FieldStateNotifierProvider call(
    String path,
  ) {
    return FieldStateNotifierProvider(
      path,
    );
  }

  @visibleForOverriding
  @override
  FieldStateNotifierProvider getProviderOverride(
    covariant FieldStateNotifierProvider provider,
  ) {
    return call(
      provider.path,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(FieldStateNotifier Function() create) {
    return _$FieldStateNotifierFamilyOverride(this, create);
  }
}

class _$FieldStateNotifierFamilyOverride implements FamilyOverride {
  _$FieldStateNotifierFamilyOverride(this.overriddenFamily, this.create);

  final FieldStateNotifier Function() create;

  @override
  final FieldStateNotifierFamily overriddenFamily;

  @override
  FieldStateNotifierProvider getProviderOverride(
    covariant FieldStateNotifierProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [FieldStateNotifier].
class FieldStateNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    FieldStateNotifier, FieldState> {
  /// See also [FieldStateNotifier].
  FieldStateNotifierProvider(
    String path,
  ) : this._internal(
          () => FieldStateNotifier()..path = path,
          from: fieldStateNotifierProvider,
          name: r'fieldStateNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fieldStateNotifierHash,
          dependencies: FieldStateNotifierFamily._dependencies,
          allTransitiveDependencies:
              FieldStateNotifierFamily._allTransitiveDependencies,
          path: path,
        );

  FieldStateNotifierProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
  }) : super.internal();

  final String path;

  @override
  FutureOr<FieldState> runNotifierBuild(
    covariant FieldStateNotifier notifier,
  ) {
    return notifier.build(
      path,
    );
  }

  @override
  Override overrideWith(FieldStateNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FieldStateNotifierProvider._internal(
        () => create()..path = path,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
      ),
    );
  }

  @override
  (String,) get argument {
    return (path,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FieldStateNotifier, FieldState>
      createElement() {
    return _FieldStateNotifierProviderElement(this);
  }

  FieldStateNotifierProvider _copyWith(
    FieldStateNotifier Function() create,
  ) {
    return FieldStateNotifierProvider._internal(
      () => create()..path = path,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      path: path,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FieldStateNotifierProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FieldStateNotifierRef on AutoDisposeAsyncNotifierProviderRef<FieldState> {
  /// The parameter `path` of this provider.
  String get path;
}

class _FieldStateNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FieldStateNotifier,
        FieldState> with FieldStateNotifierRef {
  _FieldStateNotifierProviderElement(super.provider);

  @override
  String get path => (origin as FieldStateNotifierProvider).path;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
