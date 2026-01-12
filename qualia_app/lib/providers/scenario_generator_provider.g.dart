// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scenario_generator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scenarioGeneratorAgentHash() =>
    r'35ca939293f22838ecb1fd52743f35116f378477';

/// ScenarioGenerator Agent Provider
///
/// Copied from [scenarioGeneratorAgent].
@ProviderFor(scenarioGeneratorAgent)
final scenarioGeneratorAgentProvider =
    AutoDisposeProvider<ScenarioGeneratorAgent?>.internal(
  scenarioGeneratorAgent,
  name: r'scenarioGeneratorAgentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$scenarioGeneratorAgentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ScenarioGeneratorAgentRef
    = AutoDisposeProviderRef<ScenarioGeneratorAgent?>;
String _$scenarioGenerationHash() =>
    r'257b6c3ee59003352635e79a392f95301fb80763';

/// 시나리오 생성 상태
///
/// Copied from [ScenarioGeneration].
@ProviderFor(ScenarioGeneration)
final scenarioGenerationProvider = AutoDisposeNotifierProvider<
    ScenarioGeneration, AsyncValue<ScenarioGenerationResult?>>.internal(
  ScenarioGeneration.new,
  name: r'scenarioGenerationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$scenarioGenerationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ScenarioGeneration
    = AutoDisposeNotifier<AsyncValue<ScenarioGenerationResult?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
