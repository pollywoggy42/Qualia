// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionMessagesHash() => r'6729adb37e89445fdfaed394c2c0203cc4e060ef';

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

/// 세션 메시지 목록
///
/// Copied from [sessionMessages].
@ProviderFor(sessionMessages)
const sessionMessagesProvider = SessionMessagesFamily();

/// 세션 메시지 목록
///
/// Copied from [sessionMessages].
class SessionMessagesFamily extends Family<List<ChatMessage>> {
  /// 세션 메시지 목록
  ///
  /// Copied from [sessionMessages].
  const SessionMessagesFamily();

  /// 세션 메시지 목록
  ///
  /// Copied from [sessionMessages].
  SessionMessagesProvider call(
    String sessionId,
  ) {
    return SessionMessagesProvider(
      sessionId,
    );
  }

  @override
  SessionMessagesProvider getProviderOverride(
    covariant SessionMessagesProvider provider,
  ) {
    return call(
      provider.sessionId,
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
  String? get name => r'sessionMessagesProvider';
}

/// 세션 메시지 목록
///
/// Copied from [sessionMessages].
class SessionMessagesProvider extends AutoDisposeProvider<List<ChatMessage>> {
  /// 세션 메시지 목록
  ///
  /// Copied from [sessionMessages].
  SessionMessagesProvider(
    String sessionId,
  ) : this._internal(
          (ref) => sessionMessages(
            ref as SessionMessagesRef,
            sessionId,
          ),
          from: sessionMessagesProvider,
          name: r'sessionMessagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sessionMessagesHash,
          dependencies: SessionMessagesFamily._dependencies,
          allTransitiveDependencies:
              SessionMessagesFamily._allTransitiveDependencies,
          sessionId: sessionId,
        );

  SessionMessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
  }) : super.internal();

  final String sessionId;

  @override
  Override overrideWith(
    List<ChatMessage> Function(SessionMessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SessionMessagesProvider._internal(
        (ref) => create(ref as SessionMessagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<ChatMessage>> createElement() {
    return _SessionMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionMessagesProvider && other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SessionMessagesRef on AutoDisposeProviderRef<List<ChatMessage>> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _SessionMessagesProviderElement
    extends AutoDisposeProviderElement<List<ChatMessage>>
    with SessionMessagesRef {
  _SessionMessagesProviderElement(super.provider);

  @override
  String get sessionId => (origin as SessionMessagesProvider).sessionId;
}

String _$sessionImagesHash() => r'390fbbdfc9cad9a2ce0aaec170e7f82b10e421f2';

/// 세션 이미지 목록
///
/// Copied from [sessionImages].
@ProviderFor(sessionImages)
const sessionImagesProvider = SessionImagesFamily();

/// 세션 이미지 목록
///
/// Copied from [sessionImages].
class SessionImagesFamily extends Family<List<GeneratedImage>> {
  /// 세션 이미지 목록
  ///
  /// Copied from [sessionImages].
  const SessionImagesFamily();

  /// 세션 이미지 목록
  ///
  /// Copied from [sessionImages].
  SessionImagesProvider call(
    String sessionId,
  ) {
    return SessionImagesProvider(
      sessionId,
    );
  }

  @override
  SessionImagesProvider getProviderOverride(
    covariant SessionImagesProvider provider,
  ) {
    return call(
      provider.sessionId,
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
  String? get name => r'sessionImagesProvider';
}

/// 세션 이미지 목록
///
/// Copied from [sessionImages].
class SessionImagesProvider extends AutoDisposeProvider<List<GeneratedImage>> {
  /// 세션 이미지 목록
  ///
  /// Copied from [sessionImages].
  SessionImagesProvider(
    String sessionId,
  ) : this._internal(
          (ref) => sessionImages(
            ref as SessionImagesRef,
            sessionId,
          ),
          from: sessionImagesProvider,
          name: r'sessionImagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sessionImagesHash,
          dependencies: SessionImagesFamily._dependencies,
          allTransitiveDependencies:
              SessionImagesFamily._allTransitiveDependencies,
          sessionId: sessionId,
        );

  SessionImagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
  }) : super.internal();

  final String sessionId;

  @override
  Override overrideWith(
    List<GeneratedImage> Function(SessionImagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SessionImagesProvider._internal(
        (ref) => create(ref as SessionImagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<GeneratedImage>> createElement() {
    return _SessionImagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionImagesProvider && other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SessionImagesRef on AutoDisposeProviderRef<List<GeneratedImage>> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _SessionImagesProviderElement
    extends AutoDisposeProviderElement<List<GeneratedImage>>
    with SessionImagesRef {
  _SessionImagesProviderElement(super.provider);

  @override
  String get sessionId => (origin as SessionImagesProvider).sessionId;
}

String _$sessionListHash() => r'30be76f814f00f6d8bd66462c5af1f931cb0b961';

/// 세션 목록 Provider
///
/// Copied from [SessionList].
@ProviderFor(SessionList)
final sessionListProvider =
    AutoDisposeNotifierProvider<SessionList, List<Session>>.internal(
  SessionList.new,
  name: r'sessionListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sessionListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SessionList = AutoDisposeNotifier<List<Session>>;
String _$currentSessionHash() => r'00ad8e14c28e2f80e2e372d5a37e0c6b864df007';

abstract class _$CurrentSession extends BuildlessAutoDisposeNotifier<Session?> {
  late final String sessionId;

  Session? build(
    String sessionId,
  );
}

/// 현재 세션 Provider
///
/// Copied from [CurrentSession].
@ProviderFor(CurrentSession)
const currentSessionProvider = CurrentSessionFamily();

/// 현재 세션 Provider
///
/// Copied from [CurrentSession].
class CurrentSessionFamily extends Family<Session?> {
  /// 현재 세션 Provider
  ///
  /// Copied from [CurrentSession].
  const CurrentSessionFamily();

  /// 현재 세션 Provider
  ///
  /// Copied from [CurrentSession].
  CurrentSessionProvider call(
    String sessionId,
  ) {
    return CurrentSessionProvider(
      sessionId,
    );
  }

  @override
  CurrentSessionProvider getProviderOverride(
    covariant CurrentSessionProvider provider,
  ) {
    return call(
      provider.sessionId,
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
  String? get name => r'currentSessionProvider';
}

/// 현재 세션 Provider
///
/// Copied from [CurrentSession].
class CurrentSessionProvider
    extends AutoDisposeNotifierProviderImpl<CurrentSession, Session?> {
  /// 현재 세션 Provider
  ///
  /// Copied from [CurrentSession].
  CurrentSessionProvider(
    String sessionId,
  ) : this._internal(
          () => CurrentSession()..sessionId = sessionId,
          from: currentSessionProvider,
          name: r'currentSessionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentSessionHash,
          dependencies: CurrentSessionFamily._dependencies,
          allTransitiveDependencies:
              CurrentSessionFamily._allTransitiveDependencies,
          sessionId: sessionId,
        );

  CurrentSessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
  }) : super.internal();

  final String sessionId;

  @override
  Session? runNotifierBuild(
    covariant CurrentSession notifier,
  ) {
    return notifier.build(
      sessionId,
    );
  }

  @override
  Override overrideWith(CurrentSession Function() create) {
    return ProviderOverride(
      origin: this,
      override: CurrentSessionProvider._internal(
        () => create()..sessionId = sessionId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CurrentSession, Session?> createElement() {
    return _CurrentSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentSessionProvider && other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CurrentSessionRef on AutoDisposeNotifierProviderRef<Session?> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _CurrentSessionProviderElement
    extends AutoDisposeNotifierProviderElement<CurrentSession, Session?>
    with CurrentSessionRef {
  _CurrentSessionProviderElement(super.provider);

  @override
  String get sessionId => (origin as CurrentSessionProvider).sessionId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
