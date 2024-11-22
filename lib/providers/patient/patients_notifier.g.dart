// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patients_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientsNotifierHash() => r'cc6a0cb3c23e99416b5bc1470aee225ddb6f817c';

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

abstract class _$PatientsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<Patient>> {
  late final IPatientRepo? repository;

  FutureOr<List<Patient>> build({
    IPatientRepo? repository,
  });
}

/// See also [PatientsNotifier].
@ProviderFor(PatientsNotifier)
const patientsNotifierProvider = PatientsNotifierFamily();

/// See also [PatientsNotifier].
class PatientsNotifierFamily extends Family<AsyncValue<List<Patient>>> {
  /// See also [PatientsNotifier].
  const PatientsNotifierFamily();

  /// See also [PatientsNotifier].
  PatientsNotifierProvider call({
    IPatientRepo? repository,
  }) {
    return PatientsNotifierProvider(
      repository: repository,
    );
  }

  @override
  PatientsNotifierProvider getProviderOverride(
    covariant PatientsNotifierProvider provider,
  ) {
    return call(
      repository: provider.repository,
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
  String? get name => r'patientsNotifierProvider';
}

/// See also [PatientsNotifier].
class PatientsNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    PatientsNotifier, List<Patient>> {
  /// See also [PatientsNotifier].
  PatientsNotifierProvider({
    IPatientRepo? repository,
  }) : this._internal(
          () => PatientsNotifier()..repository = repository,
          from: patientsNotifierProvider,
          name: r'patientsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientsNotifierHash,
          dependencies: PatientsNotifierFamily._dependencies,
          allTransitiveDependencies:
              PatientsNotifierFamily._allTransitiveDependencies,
          repository: repository,
        );

  PatientsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.repository,
  }) : super.internal();

  final IPatientRepo? repository;

  @override
  FutureOr<List<Patient>> runNotifierBuild(
    covariant PatientsNotifier notifier,
  ) {
    return notifier.build(
      repository: repository,
    );
  }

  @override
  Override overrideWith(PatientsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientsNotifierProvider._internal(
        () => create()..repository = repository,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        repository: repository,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientsNotifier, List<Patient>>
      createElement() {
    return _PatientsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientsNotifierProvider && other.repository == repository;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, repository.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientsNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<Patient>> {
  /// The parameter `repository` of this provider.
  IPatientRepo? get repository;
}

class _PatientsNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientsNotifier,
        List<Patient>> with PatientsNotifierRef {
  _PatientsNotifierProviderElement(super.provider);

  @override
  IPatientRepo? get repository =>
      (origin as PatientsNotifierProvider).repository;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
