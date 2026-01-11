// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalityImpl _$$PersonalityImplFromJson(Map<String, dynamic> json) =>
    _$PersonalityImpl(
      mbti: json['mbti'] as String,
      speechStyle: json['speechStyle'] as String,
      traits:
          (json['traits'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$PersonalityImplToJson(_$PersonalityImpl instance) =>
    <String, dynamic>{
      'mbti': instance.mbti,
      'speechStyle': instance.speechStyle,
      'traits': instance.traits,
    };
