// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_units_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orgUnitsNotifierHash() => r'fa9e3215616a76121c6992009df3478b4b139aa9';

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

abstract class _$OrgUnitsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<OrgUnit>> {
  late final String form;

  FutureOr<List<OrgUnit>> build(
    String form,
  );
}

/// See also [OrgUnitsNotifier].
@ProviderFor(OrgUnitsNotifier)
const orgUnitsNotifierProvider = OrgUnitsNotifierFamily();

/// See also [OrgUnitsNotifier].
class OrgUnitsNotifierFamily extends Family<AsyncValue<List<OrgUnit>>> {
  /// See also [OrgUnitsNotifier].
  const OrgUnitsNotifierFamily();

  /// See also [OrgUnitsNotifier].
  OrgUnitsNotifierProvider call(
    String form,
  ) {
    return OrgUnitsNotifierProvider(
      form,
    );
  }

  @override
  OrgUnitsNotifierProvider getProviderOverride(
    covariant OrgUnitsNotifierProvider provider,
  ) {
    return call(
      provider.form,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'orgUnitsNotifierProvider';
}

/// See also [OrgUnitsNotifier].
class OrgUnitsNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    OrgUnitsNotifier, List<OrgUnit>> {
  /// See also [OrgUnitsNotifier].
  OrgUnitsNotifierProvider(
    String form,
  ) : this._internal(
          () => OrgUnitsNotifier()..form = form,
          from: orgUnitsNotifierProvider,
          name: r'orgUnitsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$orgUnitsNotifierHash,
          dependencies: OrgUnitsNotifierFamily._dependencies,
          allTransitiveDependencies:
              OrgUnitsNotifierFamily._allTransitiveDependencies,
          form: form,
        );

  OrgUnitsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.form,
  }) : super.internal();

  final String form;

  @override
  FutureOr<List<OrgUnit>> runNotifierBuild(
    covariant OrgUnitsNotifier notifier,
  ) {
    return notifier.build(
      form,
    );
  }

  @override
  Override overrideWith(OrgUnitsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: OrgUnitsNotifierProvider._internal(
        () => create()..form = form,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        form: form,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<OrgUnitsNotifier, List<OrgUnit>>
      createElement() {
    return _OrgUnitsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrgUnitsNotifierProvider && other.form == form;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, form.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OrgUnitsNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<OrgUnit>> {
  /// The parameter `form` of this provider.
  String get form;
}

class _OrgUnitsNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<OrgUnitsNotifier,
        List<OrgUnit>> with OrgUnitsNotifierRef {
  _OrgUnitsNotifierProviderElement(super.provider);

  @override
  String get form => (origin as OrgUnitsNotifierProvider).form;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
