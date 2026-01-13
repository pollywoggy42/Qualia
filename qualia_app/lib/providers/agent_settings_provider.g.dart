// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$agentSettingsNotifierHash() =>
    r'1676d78cb1854b7be75323d1c333d8c742284e18';

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

abstract class _$AgentSettingsNotifier
    extends BuildlessAutoDisposeNotifier<AgentSettings> {
  late final String agentName;

  AgentSettings build(
    String agentName,
  );
}

/// Agent Settings Provider Family
/// 각 에이전트별 설정을 관리하는 프로바이더
///
/// Copied from [AgentSettingsNotifier].
@ProviderFor(AgentSettingsNotifier)
const agentSettingsNotifierProvider = AgentSettingsNotifierFamily();

/// Agent Settings Provider Family
/// 각 에이전트별 설정을 관리하는 프로바이더
///
/// Copied from [AgentSettingsNotifier].
class AgentSettingsNotifierFamily extends Family<AgentSettings> {
  /// Agent Settings Provider Family
  /// 각 에이전트별 설정을 관리하는 프로바이더
  ///
  /// Copied from [AgentSettingsNotifier].
  const AgentSettingsNotifierFamily();

  /// Agent Settings Provider Family
  /// 각 에이전트별 설정을 관리하는 프로바이더
  ///
  /// Copied from [AgentSettingsNotifier].
  AgentSettingsNotifierProvider call(
    String agentName,
  ) {
    return AgentSettingsNotifierProvider(
      agentName,
    );
  }

  @override
  AgentSettingsNotifierProvider getProviderOverride(
    covariant AgentSettingsNotifierProvider provider,
  ) {
    return call(
      provider.agentName,
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
  String? get name => r'agentSettingsNotifierProvider';
}

/// Agent Settings Provider Family
/// 각 에이전트별 설정을 관리하는 프로바이더
///
/// Copied from [AgentSettingsNotifier].
class AgentSettingsNotifierProvider extends AutoDisposeNotifierProviderImpl<
    AgentSettingsNotifier, AgentSettings> {
  /// Agent Settings Provider Family
  /// 각 에이전트별 설정을 관리하는 프로바이더
  ///
  /// Copied from [AgentSettingsNotifier].
  AgentSettingsNotifierProvider(
    String agentName,
  ) : this._internal(
          () => AgentSettingsNotifier()..agentName = agentName,
          from: agentSettingsNotifierProvider,
          name: r'agentSettingsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$agentSettingsNotifierHash,
          dependencies: AgentSettingsNotifierFamily._dependencies,
          allTransitiveDependencies:
              AgentSettingsNotifierFamily._allTransitiveDependencies,
          agentName: agentName,
        );

  AgentSettingsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.agentName,
  }) : super.internal();

  final String agentName;

  @override
  AgentSettings runNotifierBuild(
    covariant AgentSettingsNotifier notifier,
  ) {
    return notifier.build(
      agentName,
    );
  }

  @override
  Override overrideWith(AgentSettingsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: AgentSettingsNotifierProvider._internal(
        () => create()..agentName = agentName,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        agentName: agentName,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<AgentSettingsNotifier, AgentSettings>
      createElement() {
    return _AgentSettingsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AgentSettingsNotifierProvider &&
        other.agentName == agentName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, agentName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AgentSettingsNotifierRef
    on AutoDisposeNotifierProviderRef<AgentSettings> {
  /// The parameter `agentName` of this provider.
  String get agentName;
}

class _AgentSettingsNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<AgentSettingsNotifier,
        AgentSettings> with AgentSettingsNotifierRef {
  _AgentSettingsNotifierProviderElement(super.provider);

  @override
  String get agentName => (origin as AgentSettingsNotifierProvider).agentName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
