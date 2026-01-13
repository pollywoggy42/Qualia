// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strategist_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StrategistResponseImpl _$$StrategistResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$StrategistResponseImpl(
      choices: (json['choices'] as List<dynamic>)
          .map((e) => StrategyChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$StrategistResponseImplToJson(
        _$StrategistResponseImpl instance) =>
    <String, dynamic>{
      'choices': instance.choices,
    };

_$StrategyChoiceImpl _$$StrategyChoiceImplFromJson(Map<String, dynamic> json) =>
    _$StrategyChoiceImpl(
      id: json['id'] as String?,
      action: json['action'] as String?,
      speech: json['speech'] as String?,
      sdxlTags: json['sdxlTags'] as String?,
      successRate: (json['successRate'] as num?)?.toInt() ?? 0,
      reasoning: json['reasoning'] as String?,
      isSpecial: json['isSpecial'] as bool? ?? false,
    );

Map<String, dynamic> _$$StrategyChoiceImplToJson(
        _$StrategyChoiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.action,
      'speech': instance.speech,
      'sdxlTags': instance.sdxlTags,
      'successRate': instance.successRate,
      'reasoning': instance.reasoning,
      'isSpecial': instance.isSpecial,
    };
