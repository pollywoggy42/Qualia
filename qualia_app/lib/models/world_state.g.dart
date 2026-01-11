// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorldStateImpl _$$WorldStateImplFromJson(Map<String, dynamic> json) =>
    _$WorldStateImpl(
      currentTime: DateTime.parse(json['currentTime'] as String),
      weather: json['weather'] as String,
      currentSituation: json['currentSituation'] == null
          ? null
          : VisualDescriptor.fromJson(
              json['currentSituation'] as Map<String, dynamic>),
      ongoingEvent: json['ongoingEvent'] as String?,
      emotionalAtmosphere: json['emotionalAtmosphere'] as String? ?? 'Neutral',
      turnCount: (json['turnCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$WorldStateImplToJson(_$WorldStateImpl instance) =>
    <String, dynamic>{
      'currentTime': instance.currentTime.toIso8601String(),
      'weather': instance.weather,
      'currentSituation': instance.currentSituation,
      'ongoingEvent': instance.ongoingEvent,
      'emotionalAtmosphere': instance.emotionalAtmosphere,
      'turnCount': instance.turnCount,
    };
