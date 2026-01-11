// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_transition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SceneTransitionImpl _$$SceneTransitionImplFromJson(
        Map<String, dynamic> json) =>
    _$SceneTransitionImpl(
      transitionType: json['transitionType'] as String,
      narration: json['narration'] as String,
      newTime: json['newTime'] == null
          ? null
          : DateTime.parse(json['newTime'] as String),
      newWeather: json['newWeather'] as String?,
      newUserLocation: json['newUserLocation'] as String?,
      newPartnerLocation: json['newPartnerLocation'] as String?,
      partnerAdjustment: json['partnerAdjustment'] == null
          ? null
          : PartnerStateAdjustment.fromJson(
              json['partnerAdjustment'] as Map<String, dynamic>),
      effectsToRemove: (json['effectsToRemove'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      clearAllEffects: json['clearAllEffects'] as bool? ?? false,
    );

Map<String, dynamic> _$$SceneTransitionImplToJson(
        _$SceneTransitionImpl instance) =>
    <String, dynamic>{
      'transitionType': instance.transitionType,
      'narration': instance.narration,
      'newTime': instance.newTime?.toIso8601String(),
      'newWeather': instance.newWeather,
      'newUserLocation': instance.newUserLocation,
      'newPartnerLocation': instance.newPartnerLocation,
      'partnerAdjustment': instance.partnerAdjustment,
      'effectsToRemove': instance.effectsToRemove,
      'clearAllEffects': instance.clearAllEffects,
    };

_$PartnerStateAdjustmentImpl _$$PartnerStateAdjustmentImplFromJson(
        Map<String, dynamic> json) =>
    _$PartnerStateAdjustmentImpl(
      affectionDelta: (json['affectionDelta'] as num?)?.toInt(),
      trustDelta: (json['trustDelta'] as num?)?.toInt(),
      arousalDelta: (json['arousalDelta'] as num?)?.toInt(),
      lustDelta: (json['lustDelta'] as num?)?.toInt(),
      dominanceDelta: (json['dominanceDelta'] as num?)?.toInt(),
      newMood: json['newMood'] as String?,
      newOutfit: json['newOutfit'] as String?,
      memoryToAdd: json['memoryToAdd'] as String?,
      traumaToAdd: json['traumaToAdd'] as String?,
    );

Map<String, dynamic> _$$PartnerStateAdjustmentImplToJson(
        _$PartnerStateAdjustmentImpl instance) =>
    <String, dynamic>{
      'affectionDelta': instance.affectionDelta,
      'trustDelta': instance.trustDelta,
      'arousalDelta': instance.arousalDelta,
      'lustDelta': instance.lustDelta,
      'dominanceDelta': instance.dominanceDelta,
      'newMood': instance.newMood,
      'newOutfit': instance.newOutfit,
      'memoryToAdd': instance.memoryToAdd,
      'traumaToAdd': instance.traumaToAdd,
    };
