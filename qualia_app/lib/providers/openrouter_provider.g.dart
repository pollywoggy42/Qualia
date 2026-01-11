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
String _$availableModelsHash() => r'acae5dd5847b4b170cbe4b906096ad36b40ae0c8';

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
String _$openRouterAuthHash() => r'fb7c28e82e862bde8c9e7c5185366ce066e856b1';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
