// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openrouter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$openRouterServiceHash() => r'4bcbef4ba1e8681239c7b55e57c168fdc26317ae';

/// OpenRouter Service Provider
///
/// Copied from [openRouterService].
@ProviderFor(openRouterService)
final openRouterServiceProvider =
    AutoDisposeProvider<OpenRouterService?>.internal(
  openRouterService,
  name: r'openRouterServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$openRouterServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OpenRouterServiceRef = AutoDisposeProviderRef<OpenRouterService?>;
String _$availableModelsHash() => r'db872b1491b8ec3accc108e4a500a9aff121896a';

/// 사용 가능한 모델 목록
///
/// Copied from [availableModels].
@ProviderFor(availableModels)
final availableModelsProvider =
    AutoDisposeFutureProvider<List<ModelInfo>>.internal(
  availableModels,
  name: r'availableModelsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$availableModelsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AvailableModelsRef = AutoDisposeFutureProviderRef<List<ModelInfo>>;
String _$openRouterAuthHash() => r'58dea2e921afa4757ea0935eac6d0a01f89b4d81';

/// OpenRouter 인증 상태
///
/// Copied from [OpenRouterAuth].
@ProviderFor(OpenRouterAuth)
final openRouterAuthProvider =
    AutoDisposeAsyncNotifierProvider<OpenRouterAuth, AccountInfo?>.internal(
  OpenRouterAuth.new,
  name: r'openRouterAuthProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$openRouterAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OpenRouterAuth = AutoDisposeAsyncNotifier<AccountInfo?>;
String _$openRouterCreditsHash() => r'c7badfe8e3e7bf4d3cdfd71d3d8a3d5296df3372';

/// 크레딧 잔액 정보
///
/// Copied from [OpenRouterCredits].
@ProviderFor(OpenRouterCredits)
final openRouterCreditsProvider = AutoDisposeAsyncNotifierProvider<
    OpenRouterCredits, CreditBalance?>.internal(
  OpenRouterCredits.new,
  name: r'openRouterCreditsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$openRouterCreditsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OpenRouterCredits = AutoDisposeAsyncNotifier<CreditBalance?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
