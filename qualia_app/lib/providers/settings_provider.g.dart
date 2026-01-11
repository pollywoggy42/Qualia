// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allAgentSettingsHash() => r'b99943a6a50d354e709303e2c233c99e794eaa73';

/// 모든 Agent 설정
///
/// Copied from [allAgentSettings].
@ProviderFor(allAgentSettings)
final allAgentSettingsProvider =
    AutoDisposeProvider<Map<String, AgentSettings>>.internal(
  allAgentSettings,
  name: r'allAgentSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allAgentSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllAgentSettingsRef
    = AutoDisposeProviderRef<Map<String, AgentSettings>>;
String _$themeModeNotifierHash() => r'b0765ff0f082a12101b1a379eda0ad3b97262407';

/// 테마 모드 Provider
///
/// Copied from [ThemeModeNotifier].
@ProviderFor(ThemeModeNotifier)
final themeModeNotifierProvider =
    AutoDisposeNotifierProvider<ThemeModeNotifier, ThemeMode>.internal(
  ThemeModeNotifier.new,
  name: r'themeModeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeModeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeModeNotifier = AutoDisposeNotifier<ThemeMode>;
String _$agentSettingsNotifierHash() =>
    r'e73b5e6aed97a015913176944ff3d86fb97e1a9d';

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

/// Agent 설정 Provider
///
/// Copied from [AgentSettingsNotifier].
@ProviderFor(AgentSettingsNotifier)
const agentSettingsNotifierProvider = AgentSettingsNotifierFamily();

/// Agent 설정 Provider
///
/// Copied from [AgentSettingsNotifier].
class AgentSettingsNotifierFamily extends Family<AgentSettings> {
  /// Agent 설정 Provider
  ///
  /// Copied from [AgentSettingsNotifier].
  const AgentSettingsNotifierFamily();

  /// Agent 설정 Provider
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

/// Agent 설정 Provider
///
/// Copied from [AgentSettingsNotifier].
class AgentSettingsNotifierProvider extends AutoDisposeNotifierProviderImpl<
    AgentSettingsNotifier, AgentSettings> {
  /// Agent 설정 Provider
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
