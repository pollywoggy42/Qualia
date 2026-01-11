import 'package:freezed_annotation/freezed_annotation.dart';

import 'visual_descriptor.dart';
import 'comfyui_model_preset.dart';

part 'visual_director_input.freezed.dart';
part 'visual_director_input.g.dart';

/// Visual Director Input - Visual Director의 입력 데이터 구조
@freezed
class VisualDirectorInput with _$VisualDirectorInput {
  const factory VisualDirectorInput({
    required FocusPoint focusPoint,
    required SceneContext sceneContext,
    required CharacterVisuals characters,
    required ComfyUIModelPreset modelPreset,
  }) = _VisualDirectorInput;

  factory VisualDirectorInput.fromJson(Map<String, dynamic> json) =>
      _$VisualDirectorInputFromJson(json);
}

/// Focus Point - 이미지의 핵심 초점
@freezed
class FocusPoint with _$FocusPoint {
  const factory FocusPoint({
    required UserAction userAction,
    required PartnerReaction partnerReaction,
  }) = _FocusPoint;

  factory FocusPoint.fromJson(Map<String, dynamic> json) =>
      _$FocusPointFromJson(json);
}

/// User Action - User가 선택한 행위
@freezed
class UserAction with _$UserAction {
  const factory UserAction({
    required String action,
    required String sdxlTags,
  }) = _UserAction;

  factory UserAction.fromJson(Map<String, dynamic> json) =>
      _$UserActionFromJson(json);
}

/// Partner Reaction - Partner의 즉각 반응
@freezed
class PartnerReaction with _$PartnerReaction {
  const factory PartnerReaction({
    required String action,
    required List<String> physicalState,
    required String mood,
  }) = _PartnerReaction;

  factory PartnerReaction.fromJson(Map<String, dynamic> json) =>
      _$PartnerReactionFromJson(json);
}

/// Scene Context - 장면 맥락
@freezed
class SceneContext with _$SceneContext {
  const factory SceneContext({
    VisualDescriptor? currentSituation,
    required String emotionalAtmosphere,
    required String location,
    required String timeOfDay,
    required String weather,
  }) = _SceneContext;

  factory SceneContext.fromJson(Map<String, dynamic> json) =>
      _$SceneContextFromJson(json);
}

/// Character Visuals - 캐릭터 외모
@freezed
class CharacterVisuals with _$CharacterVisuals {
  const factory CharacterVisuals({
    required PartnerVisuals partner,
    required UserVisuals user,
  }) = _CharacterVisuals;

  factory CharacterVisuals.fromJson(Map<String, dynamic> json) =>
      _$CharacterVisualsFromJson(json);
}

/// Partner Visuals - 파트너 외모
@freezed
class PartnerVisuals with _$PartnerVisuals {
  const factory PartnerVisuals({
    required VisualDescriptor face,
    required VisualDescriptor hairstyle,
    required VisualDescriptor body,
    required VisualDescriptor accessories,
    required VisualDescriptor outfit,
    VisualDescriptor? nsfwOutfit,
    @Default(false) bool isNSFWAllowed,
  }) = _PartnerVisuals;

  factory PartnerVisuals.fromJson(Map<String, dynamic> json) =>
      _$PartnerVisualsFromJson(json);
}

/// User Visuals - 유저 외모
@freezed
class UserVisuals with _$UserVisuals {
  const factory UserVisuals({
    required VisualDescriptor face,
    required VisualDescriptor hairstyle,
    required VisualDescriptor body,
    required VisualDescriptor accessories,
    required VisualDescriptor outfit,
  }) = _UserVisuals;

  factory UserVisuals.fromJson(Map<String, dynamic> json) =>
      _$UserVisualsFromJson(json);
}
