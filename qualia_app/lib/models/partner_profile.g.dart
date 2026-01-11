// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartnerProfileImpl _$$PartnerProfileImplFromJson(Map<String, dynamic> json) =>
    _$PartnerProfileImpl(
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
      nsfwOutfit: json['nsfwOutfit'] == null
          ? null
          : VisualDescriptor.fromJson(
              json['nsfwOutfit'] as Map<String, dynamic>),
      personality:
          Personality.fromJson(json['personality'] as Map<String, dynamic>),
      secret: json['secret'] as String?,
      secretFragments: (json['secretFragments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      traumas: (json['traumas'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      emotionalState: PartnerEmotionalState.fromJson(
          json['emotionalState'] as Map<String, dynamic>),
      physicalState: (json['physicalState'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sexualExperience: (json['sexualExperience'] as num?)?.toInt() ?? 0,
      isNSFWAllowed: json['isNSFWAllowed'] as bool? ?? false,
      memorySnapshots: (json['memorySnapshots'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PartnerProfileImplToJson(
        _$PartnerProfileImpl instance) =>
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
      'nsfwOutfit': instance.nsfwOutfit,
      'personality': instance.personality,
      'secret': instance.secret,
      'secretFragments': instance.secretFragments,
      'traumas': instance.traumas,
      'emotionalState': instance.emotionalState,
      'physicalState': instance.physicalState,
      'sexualExperience': instance.sexualExperience,
      'isNSFWAllowed': instance.isNSFWAllowed,
      'memorySnapshots': instance.memorySnapshots,
    };
