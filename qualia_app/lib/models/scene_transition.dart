import 'package:freezed_annotation/freezed_annotation.dart';

part 'scene_transition.freezed.dart';
part 'scene_transition.g.dart';

/// Scene Transition - 챕터 전환 시 사용되는 장면 전환 정보
@freezed
class SceneTransition with _$SceneTransition {
  const factory SceneTransition({
    /// 전환 유형 ("time_skip", "location_change", "next_day")
    required String transitionType,

    /// 전환 서술
    required String narration,

    // 세계 상태 변경
    DateTime? newTime,
    String? newWeather,
    String? newUserLocation,
    String? newPartnerLocation,

    // Partner 상태 조정
    PartnerStateAdjustment? partnerAdjustment,

    // 효과 정리
    @Default([]) List<String> effectsToRemove,
    @Default(false) bool clearAllEffects,
  }) = _SceneTransition;

  factory SceneTransition.fromJson(Map<String, dynamic> json) =>
      _$SceneTransitionFromJson(json);
}

/// Partner State Adjustment - 전환 시 파트너 상태 조정
@freezed
class PartnerStateAdjustment with _$PartnerStateAdjustment {
  const factory PartnerStateAdjustment({
    // 감정 수치 조정 (delta 값)
    int? affectionDelta,
    int? trustDelta,
    int? arousalDelta,
    int? lustDelta,
    int? dominanceDelta,

    // 상태 변경
    String? newMood,
    String? newOutfit,

    // 메모리 추가
    String? memoryToAdd,

    // 트라우마 추가
    String? traumaToAdd,
  }) = _PartnerStateAdjustment;

  factory PartnerStateAdjustment.fromJson(Map<String, dynamic> json) =>
      _$PartnerStateAdjustmentFromJson(json);
}
