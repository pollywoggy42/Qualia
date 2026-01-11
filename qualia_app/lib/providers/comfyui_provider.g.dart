// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comfyui_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$comfyUIServiceHash() => r'c585b6f3ad29d31b6d2cac5ad3f27ff490d6968c';

/// ComfyUI Service Provider
///
/// Copied from [comfyUIService].
@ProviderFor(comfyUIService)
final comfyUIServiceProvider = AutoDisposeProvider<ComfyUIService>.internal(
  comfyUIService,
  name: r'comfyUIServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$comfyUIServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ComfyUIServiceRef = AutoDisposeProviderRef<ComfyUIService>;
String _$comfyUISystemStatsHash() =>
    r'8130954dc0451f17e5a978b016ac1c5e66b64120';

/// ComfyUI 시스템 정보
///
/// Copied from [comfyUISystemStats].
@ProviderFor(comfyUISystemStats)
final comfyUISystemStatsProvider =
    AutoDisposeFutureProvider<SystemStats?>.internal(
  comfyUISystemStats,
  name: r'comfyUISystemStatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$comfyUISystemStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ComfyUISystemStatsRef = AutoDisposeFutureProviderRef<SystemStats?>;
String _$comfyUIConnectionHash() => r'd6296b52c5919740faa2f09dadd0a39fa4af1f91';

/// ComfyUI 연결 상태
///
/// Copied from [ComfyUIConnection].
@ProviderFor(ComfyUIConnection)
final comfyUIConnectionProvider =
    AutoDisposeAsyncNotifierProvider<ComfyUIConnection, bool>.internal(
  ComfyUIConnection.new,
  name: r'comfyUIConnectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$comfyUIConnectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ComfyUIConnection = AutoDisposeAsyncNotifier<bool>;
String _$modelPresetsHash() => r'232870fbef417c71b346bfb2ec36176ce8f3c5f3';

/// 모델 프리셋 목록
///
/// Copied from [ModelPresets].
@ProviderFor(ModelPresets)
final modelPresetsProvider = AutoDisposeNotifierProvider<ModelPresets,
    List<ComfyUIModelPreset>>.internal(
  ModelPresets.new,
  name: r'modelPresetsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$modelPresetsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ModelPresets = AutoDisposeNotifier<List<ComfyUIModelPreset>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
