import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/models.dart';

/// Storage Service - Hive를 사용한 로컬 스토리지
class StorageService {
  static const String _settingsBox = 'settings';
  static const String _sessionsBox = 'sessions';
  static const String _presetsBox = 'presets';

  late Box _settings;
  late Box _sessions;
  late Box _presets;

  bool _initialized = false;

  /// 초기화
  Future<void> initialize() async {
    if (_initialized) return;

    await Hive.initFlutter();

    // Check if boxes are already open to avoid type conflicts
    _settings = Hive.isBoxOpen(_settingsBox)
        ? Hive.box(_settingsBox)
        : await Hive.openBox(_settingsBox);
    _sessions = Hive.isBoxOpen(_sessionsBox)
        ? Hive.box(_sessionsBox)
        : await Hive.openBox(_sessionsBox);
    _presets = Hive.isBoxOpen(_presetsBox)
        ? Hive.box(_presetsBox)
        : await Hive.openBox(_presetsBox);

    _initialized = true;
  }

  // ==================== Settings ====================

  /// OpenRouter API 키 저장
  Future<void> setOpenRouterApiKey(String apiKey) async {
    if (!_initialized) {
      throw StateError('StorageService not initialized. Call initialize() first.');
    }
    await _settings.put('openrouter_api_key', apiKey);
  }

  /// OpenRouter API 키 조회
  String? getOpenRouterApiKey() {
    if (!_initialized) return null;
    return _settings.get('openrouter_api_key');
  }

  /// ComfyUI 설정 저장
  Future<void> setComfyUISettings({
    required String host,
    required int port,
  }) async {
    await _settings.put('comfyui_host', host);
    await _settings.put('comfyui_port', port.toString());
  }

  /// ComfyUI 호스트 조회
  String getComfyUIHost() {
    return _settings.get('comfyui_host') ?? '127.0.0.1';
  }

  /// ComfyUI 포트 조회
  int getComfyUIPort() {
    final port = _settings.get('comfyui_port');
    return port != null ? int.tryParse(port) ?? 8188 : 8188;
  }

  /// 테마 모드 저장
  Future<void> setThemeMode(String mode) async {
    if (!_initialized) {
      throw StateError('StorageService not initialized. Call initialize() first.');
    }
    await _settings.put('theme_mode', mode);
  }

  /// 테마 모드 조회
  String getThemeMode() {
    if (!_initialized) return 'system';
    return _settings.get('theme_mode') ?? 'system';
  }

  // ==================== Sessions ====================

  /// 세션 저장
  Future<void> saveSession(Session session) async {
    final json = jsonEncode(session.toJson());
    await _sessions.put(session.id, json);
  }

  /// 세션 조회
  Session? getSession(String id) {
    final json = _sessions.get(id);
    if (json == null) return null;

    final map = jsonDecode(json) as Map<String, dynamic>;
    return Session.fromJson(map);
  }

  /// 모든 세션 조회
  List<Session> getAllSessions() {
    final sessions = <Session>[];

    for (final key in _sessions.keys) {
      final session = getSession(key as String);
      if (session != null) {
        sessions.add(session);
      }
    }

    // Sort by lastActiveAt descending
    sessions.sort((a, b) => b.lastActiveAt.compareTo(a.lastActiveAt));
    return sessions;
  }

  /// 세션 삭제
  Future<void> deleteSession(String id) async {
    await _sessions.delete(id);
  }

  // ==================== Presets ====================

  /// 프리셋 저장
  Future<void> savePreset(ComfyUIModelPreset preset) async {
    final json = jsonEncode(preset.toJson());
    await _presets.put(preset.id, json);
  }

  /// 프리셋 조회
  ComfyUIModelPreset? getPreset(String id) {
    final json = _presets.get(id);
    if (json == null) return null;

    final map = jsonDecode(json) as Map<String, dynamic>;
    return ComfyUIModelPreset.fromJson(map);
  }

  /// 모든 프리셋 조회 (기본 + 사용자)
  List<ComfyUIModelPreset> getAllPresets() {
    final presets = <ComfyUIModelPreset>[];

    // Add built-in presets
    presets.addAll(BuiltInPresets.all);

    // Add user presets
    for (final key in _presets.keys) {
      final preset = getPreset(key as String);
      if (preset != null && !preset.isBuiltIn) {
        presets.add(preset);
      }
    }

    return presets;
  }

  /// 프리셋 삭제
  Future<void> deletePreset(String id) async {
    await _presets.delete(id);
  }

  // ==================== Agent Settings ====================

  /// Agent 설정 저장
  Future<void> setAgentSettings(String agentName, AgentSettings settings) async {
    final json = jsonEncode(settings.toJson());
    await _settings.put('agent_$agentName', json);
  }

  /// Agent 설정 조회
  AgentSettings getAgentSettings(String agentName) {
    if (!_initialized) {
      return AgentSettings.defaultFor(agentName);
    }
    final json = _settings.get('agent_$agentName');
    if (json == null) {
      return AgentSettings.defaultFor(agentName);
    }

    final map = jsonDecode(json) as Map<String, dynamic>;
    return AgentSettings.fromJson(map);
  }

  /// 모든 데이터 삭제
  Future<void> clearAll() async {
    await _settings.clear();
    await _sessions.clear();
    await _presets.clear();
  }
}

/// Agent Settings - OpenRouter API 호출 파라미터
class AgentSettings {
  final String model;
  final double temperature;
  final int maxTokens;
  final double? topP;
  final double? frequencyPenalty;
  final double? presencePenalty;

  AgentSettings({
    required this.model,
    required this.temperature,
    this.maxTokens = 2048,
    this.topP,
    this.frequencyPenalty,
    this.presencePenalty,
  });

  factory AgentSettings.defaultFor(String agentName) {
    switch (agentName) {
      case 'partner':
        return AgentSettings(
          model: 'x-ai/grok-beta',
          temperature: 0.7,
          maxTokens: 2048,
          topP: 0.9,
          frequencyPenalty: 0.0,
          presencePenalty: 0.0,
        );
      case 'scenario_director':
        return AgentSettings(
          model: 'x-ai/grok-beta',
          temperature: 0.8,
          maxTokens: 4096,
          topP: 0.95,
          frequencyPenalty: 0.0,
          presencePenalty: 0.0,
        );
      case 'visual_director':
        return AgentSettings(
          model: 'x-ai/grok-beta',
          temperature: 0.5,
          maxTokens: 1024,
          topP: 0.8,
          frequencyPenalty: 0.0,
          presencePenalty: 0.0,
        );
      case 'strategist':
        return AgentSettings(
          model: 'x-ai/grok-beta',
          temperature: 0.7,
          maxTokens: 2048,
          topP: 0.9,
          frequencyPenalty: 0.0,
          presencePenalty: 0.0,
        );
      case 'scenario_generator':
        return AgentSettings(
          model: 'x-ai/grok-beta',
          temperature: 0.9,
          maxTokens: 8192,
          topP: 0.95,
          frequencyPenalty: 0.0,
          presencePenalty: 0.0,
        );
      case 'sdxl_transformer':
        return AgentSettings(
          model: 'openai/gpt-4o-mini',
          temperature: 0.3,
          maxTokens: 512,
          topP: 0.8,
          frequencyPenalty: 0.0,
          presencePenalty: 0.0,
        );
      default:
        return AgentSettings(
          model: 'x-ai/grok-3-fast',
          temperature: 0.7,
          maxTokens: 2048,
          topP: 0.9,
          frequencyPenalty: 0.0,
          presencePenalty: 0.0,
        );
    }
  }

  factory AgentSettings.fromJson(Map<String, dynamic> json) {
    return AgentSettings(
      model: json['model'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      maxTokens: json['maxTokens'] as int? ?? 2048,
      topP: (json['topP'] as num?)?.toDouble(),
      frequencyPenalty: (json['frequencyPenalty'] as num?)?.toDouble(),
      presencePenalty: (json['presencePenalty'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'model': model,
    'temperature': temperature,
    'maxTokens': maxTokens,
    if (topP != null) 'topP': topP,
    if (frequencyPenalty != null) 'frequencyPenalty': frequencyPenalty,
    if (presencePenalty != null) 'presencePenalty': presencePenalty,
  };

  AgentSettings copyWith({
    String? model,
    double? temperature,
    int? maxTokens,
    double? topP,
    double? frequencyPenalty,
    double? presencePenalty,
  }) {
    return AgentSettings(
      model: model ?? this.model,
      temperature: temperature ?? this.temperature,
      maxTokens: maxTokens ?? this.maxTokens,
      topP: topP ?? this.topP,
      frequencyPenalty: frequencyPenalty ?? this.frequencyPenalty,
      presencePenalty: presencePenalty ?? this.presencePenalty,
    );
  }
}
