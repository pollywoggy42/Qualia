// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_emotional_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartnerEmotionalStateImpl _$$PartnerEmotionalStateImplFromJson(
        Map<String, dynamic> json) =>
    _$PartnerEmotionalStateImpl(
      affection: (json['affection'] as num?)?.toInt() ?? 50,
      trust: (json['trust'] as num?)?.toInt() ?? 50,
      arousal: (json['arousal'] as num?)?.toInt() ?? 0,
      lust: (json['lust'] as num?)?.toInt() ?? 0,
      dominance: (json['dominance'] as num?)?.toInt() ?? 0,
      mood: json['mood'] as String? ?? 'Neutral',
    );

Map<String, dynamic> _$$PartnerEmotionalStateImplToJson(
        _$PartnerEmotionalStateImpl instance) =>
    <String, dynamic>{
      'affection': instance.affection,
      'trust': instance.trust,
      'arousal': instance.arousal,
      'lust': instance.lust,
      'dominance': instance.dominance,
      'mood': instance.mood,
    };
