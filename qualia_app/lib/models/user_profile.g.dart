// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      gender: json['gender'] as String,
      occupation: json['occupation'] as String,
      location: json['location'] as String,
      face: VisualDescriptor.fromJson(json['face'] as Map<String, dynamic>),
      hairstyle:
          VisualDescriptor.fromJson(json['hairstyle'] as Map<String, dynamic>),
      body: VisualDescriptor.fromJson(json['body'] as Map<String, dynamic>),
      accessories: VisualDescriptor.fromJson(
          json['accessories'] as Map<String, dynamic>),
      outfit: VisualDescriptor.fromJson(json['outfit'] as Map<String, dynamic>),
      personality:
          Personality.fromJson(json['personality'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'occupation': instance.occupation,
      'location': instance.location,
      'face': instance.face,
      'hairstyle': instance.hairstyle,
      'body': instance.body,
      'accessories': instance.accessories,
      'outfit': instance.outfit,
      'personality': instance.personality,
    };
