import 'package:freezed_annotation/freezed_annotation.dart';

import 'partner_profile.dart';
import 'user_profile.dart';
import 'world_state.dart';
import 'comfyui_model_preset.dart';

part 'session.freezed.dart';
part 'session.g.dart';

/// Session - 게임 세션 전체 상태
@freezed
class Session with _$Session {
  const factory Session({
    required String id,
    required DateTime createdAt,
    required DateTime lastActiveAt,

    // Profiles
    required PartnerProfile partner,
    required UserProfile user,

    // World State
    required WorldState worldState,

    // Model Preset
    required ComfyUIModelPreset modelPreset,

    // Chat History
    @Default([]) List<ChatMessage> messages,

    // Generated Images
    @Default([]) List<GeneratedImage> images,

    // Session Settings
    @Default(false) bool isNSFWEnabled,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}

/// Chat Message - 채팅 메시지
@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required DateTime timestamp,
    required MessageType type,

    // Content
    List<String>? actions,
    List<String>? dialogues,
    String? innerThought,
    String? narration,

    // Associated Image
    String? imageId,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

/// Message Type - 메시지 유형
enum MessageType {
  partner,    // 파트너 메시지
  user,       // 유저 메시지
  narrator,   // 나레이터 (시스템)
}

/// Generated Image - 생성된 이미지
@freezed
class GeneratedImage with _$GeneratedImage {
  const factory GeneratedImage({
    required String id,
    required String url,
    required String prompt,
    required DateTime createdAt,
  }) = _GeneratedImage;

  factory GeneratedImage.fromJson(Map<String, dynamic> json) =>
      _$GeneratedImageFromJson(json);
}


