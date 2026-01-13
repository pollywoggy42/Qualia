// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartnerResponseImpl _$$PartnerResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PartnerResponseImpl(
      actions: (json['actions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      dialogues: (json['dialogues'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      innerThought: json['innerThought'] as String,
      emotionalChanges: PartnerEmotionalState.fromJson(
          json['emotionalChanges'] as Map<String, dynamic>),
      physicalStateChanges: PhysicalStateChange.fromJson(
          json['physicalStateChanges'] as Map<String, dynamic>),
      isNSFWAllowed: json['isNSFWAllowed'] as bool? ?? false,
      sexualExperienceGain:
          (json['sexualExperienceGain'] as num?)?.toInt() ?? 0,
      traumaDetected: json['traumaDetected'] as String?,
    );

Map<String, dynamic> _$$PartnerResponseImplToJson(
        _$PartnerResponseImpl instance) =>
    <String, dynamic>{
      'actions': instance.actions,
      'dialogues': instance.dialogues,
      'innerThought': instance.innerThought,
      'emotionalChanges': instance.emotionalChanges,
      'physicalStateChanges': instance.physicalStateChanges,
      'isNSFWAllowed': instance.isNSFWAllowed,
      'sexualExperienceGain': instance.sexualExperienceGain,
      'traumaDetected': instance.traumaDetected,
    };

_$PhysicalStateChangeImpl _$$PhysicalStateChangeImplFromJson(
        Map<String, dynamic> json) =>
    _$PhysicalStateChangeImpl(
      add: (json['add'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      remove: (json['remove'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PhysicalStateChangeImplToJson(
        _$PhysicalStateChangeImpl instance) =>
    <String, dynamic>{
      'add': instance.add,
      'remove': instance.remove,
    };
