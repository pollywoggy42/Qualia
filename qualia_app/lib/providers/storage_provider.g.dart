// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$storageServiceHash() => r'59688abd0fb16e355f55dd53d8827bcf69375a56';

/// Storage Service Provider
///
/// Copied from [storageService].
@ProviderFor(storageService)
final storageServiceProvider = Provider<StorageService>.internal(
  storageService,
  name: r'storageServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$storageServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef StorageServiceRef = ProviderRef<StorageService>;
String _$storageInitializedHash() =>
    r'3c6d137a0bfb3ab2d40c21dca53042527ccbba6f';

/// Storage 초기화 상태
///
/// Copied from [StorageInitialized].
@ProviderFor(StorageInitialized)
final storageInitializedProvider =
    AutoDisposeAsyncNotifierProvider<StorageInitialized, bool>.internal(
  StorageInitialized.new,
  name: r'storageInitializedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$storageInitializedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StorageInitialized = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
