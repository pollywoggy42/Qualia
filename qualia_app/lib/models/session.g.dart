// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionImpl _$$SessionImplFromJson(Map<String, dynamic> json) =>
    _$SessionImpl(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastActiveAt: DateTime.parse(json['lastActiveAt'] as String),
      partner: PartnerProfile.fromJson(json['partner'] as Map<String, dynamic>),
      user: UserProfile.fromJson(json['user'] as Map<String, dynamic>),
      worldState:
          WorldState.fromJson(json['worldState'] as Map<String, dynamic>),
      modelPreset: ComfyUIModelPreset.fromJson(
          json['modelPreset'] as Map<String, dynamic>),
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => GeneratedImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      profileImageUrl: json['profileImageUrl'] as String?,
      isNSFWEnabled: json['isNSFWEnabled'] as bool? ?? false,
      currentChoices: (json['currentChoices'] as List<dynamic>?)
          ?.map((e) => StrategyChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SessionImplToJson(_$SessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastActiveAt': instance.lastActiveAt.toIso8601String(),
      'partner': instance.partner,
      'user': instance.user,
      'worldState': instance.worldState,
      'modelPreset': instance.modelPreset,
      'messages': instance.messages,
      'images': instance.images,
      'profileImageUrl': instance.profileImageUrl,
      'isNSFWEnabled': instance.isNSFWEnabled,
      'currentChoices': instance.currentChoices,
    };

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      actions:
          (json['actions'] as List<dynamic>?)?.map((e) => e as String).toList(),
      dialogues: (json['dialogues'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      innerThought: json['innerThought'] as String?,
      narration: json['narration'] as String?,
      imageId: json['imageId'] as String?,
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'type': _$MessageTypeEnumMap[instance.type]!,
      'actions': instance.actions,
      'dialogues': instance.dialogues,
      'innerThought': instance.innerThought,
      'narration': instance.narration,
      'imageId': instance.imageId,
    };

const _$MessageTypeEnumMap = {
  MessageType.partner: 'partner',
  MessageType.user: 'user',
  MessageType.narrator: 'narrator',
};

_$GeneratedImageImpl _$$GeneratedImageImplFromJson(Map<String, dynamic> json) =>
    _$GeneratedImageImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      prompt: json['prompt'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$GeneratedImageImplToJson(
        _$GeneratedImageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'prompt': instance.prompt,
      'createdAt': instance.createdAt.toIso8601String(),
    };
