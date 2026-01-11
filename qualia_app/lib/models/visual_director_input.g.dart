// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visual_director_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisualDirectorInputImpl _$$VisualDirectorInputImplFromJson(
        Map<String, dynamic> json) =>
    _$VisualDirectorInputImpl(
      focusPoint:
          FocusPoint.fromJson(json['focusPoint'] as Map<String, dynamic>),
      sceneContext:
          SceneContext.fromJson(json['sceneContext'] as Map<String, dynamic>),
      characters:
          CharacterVisuals.fromJson(json['characters'] as Map<String, dynamic>),
      modelPreset: ComfyUIModelPreset.fromJson(
          json['modelPreset'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$VisualDirectorInputImplToJson(
        _$VisualDirectorInputImpl instance) =>
    <String, dynamic>{
      'focusPoint': instance.focusPoint,
      'sceneContext': instance.sceneContext,
      'characters': instance.characters,
      'modelPreset': instance.modelPreset,
    };

_$FocusPointImpl _$$FocusPointImplFromJson(Map<String, dynamic> json) =>
    _$FocusPointImpl(
      userAction:
          UserAction.fromJson(json['userAction'] as Map<String, dynamic>),
      partnerReaction: PartnerReaction.fromJson(
          json['partnerReaction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FocusPointImplToJson(_$FocusPointImpl instance) =>
    <String, dynamic>{
      'userAction': instance.userAction,
      'partnerReaction': instance.partnerReaction,
    };

_$UserActionImpl _$$UserActionImplFromJson(Map<String, dynamic> json) =>
    _$UserActionImpl(
      action: json['action'] as String,
      sdxlTags: json['sdxlTags'] as String,
    );

Map<String, dynamic> _$$UserActionImplToJson(_$UserActionImpl instance) =>
    <String, dynamic>{
      'action': instance.action,
      'sdxlTags': instance.sdxlTags,
    };

_$PartnerReactionImpl _$$PartnerReactionImplFromJson(
        Map<String, dynamic> json) =>
    _$PartnerReactionImpl(
      action: json['action'] as String,
      physicalState: (json['physicalState'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      mood: json['mood'] as String,
    );

Map<String, dynamic> _$$PartnerReactionImplToJson(
        _$PartnerReactionImpl instance) =>
    <String, dynamic>{
      'action': instance.action,
      'physicalState': instance.physicalState,
      'mood': instance.mood,
    };

_$SceneContextImpl _$$SceneContextImplFromJson(Map<String, dynamic> json) =>
    _$SceneContextImpl(
      currentSituation: json['currentSituation'] == null
          ? null
          : VisualDescriptor.fromJson(
              json['currentSituation'] as Map<String, dynamic>),
      emotionalAtmosphere: json['emotionalAtmosphere'] as String,
      location: json['location'] as String,
      timeOfDay: json['timeOfDay'] as String,
      weather: json['weather'] as String,
    );

Map<String, dynamic> _$$SceneContextImplToJson(_$SceneContextImpl instance) =>
    <String, dynamic>{
      'currentSituation': instance.currentSituation,
      'emotionalAtmosphere': instance.emotionalAtmosphere,
      'location': instance.location,
      'timeOfDay': instance.timeOfDay,
      'weather': instance.weather,
    };

_$CharacterVisualsImpl _$$CharacterVisualsImplFromJson(
        Map<String, dynamic> json) =>
    _$CharacterVisualsImpl(
      partner: PartnerVisuals.fromJson(json['partner'] as Map<String, dynamic>),
      user: UserVisuals.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CharacterVisualsImplToJson(
        _$CharacterVisualsImpl instance) =>
    <String, dynamic>{
      'partner': instance.partner,
      'user': instance.user,
    };

_$PartnerVisualsImpl _$$PartnerVisualsImplFromJson(Map<String, dynamic> json) =>
    _$PartnerVisualsImpl(
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
      isNSFWAllowed: json['isNSFWAllowed'] as bool? ?? false,
    );

Map<String, dynamic> _$$PartnerVisualsImplToJson(
        _$PartnerVisualsImpl instance) =>
    <String, dynamic>{
      'face': instance.face,
      'hairstyle': instance.hairstyle,
      'body': instance.body,
      'accessories': instance.accessories,
      'outfit': instance.outfit,
      'nsfwOutfit': instance.nsfwOutfit,
      'isNSFWAllowed': instance.isNSFWAllowed,
    };

_$UserVisualsImpl _$$UserVisualsImplFromJson(Map<String, dynamic> json) =>
    _$UserVisualsImpl(
      face: VisualDescriptor.fromJson(json['face'] as Map<String, dynamic>),
      hairstyle:
          VisualDescriptor.fromJson(json['hairstyle'] as Map<String, dynamic>),
      body: VisualDescriptor.fromJson(json['body'] as Map<String, dynamic>),
      accessories: VisualDescriptor.fromJson(
          json['accessories'] as Map<String, dynamic>),
      outfit: VisualDescriptor.fromJson(json['outfit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserVisualsImplToJson(_$UserVisualsImpl instance) =>
    <String, dynamic>{
      'face': instance.face,
      'hairstyle': instance.hairstyle,
      'body': instance.body,
      'accessories': instance.accessories,
      'outfit': instance.outfit,
    };
