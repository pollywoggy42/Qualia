import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner_emotional_state.freezed.dart';
part 'partner_emotional_state.g.dart';

/// Partner Emotional State - 파트너의 감정 상태 (정량적 + 정성적)
@freezed
class PartnerEmotionalState with _$PartnerEmotionalState {
  const factory PartnerEmotionalState({
    /// 호감도 (0-100), 관계 진전도 - 느린 변화
    @Default(50) int affection,

    /// 신뢰도 (0-100), 대화 깊이 및 비밀 공유 - 느린 변화
    @Default(50) int trust,

    /// 성적 흥분도 (0-100), NSFW 상황 트리거 - 빠른 변화
    @Default(0) int arousal,

    /// 성욕 (0-100), 매우 높으면 이성을 잃고 NSFW 허용 - 빠른 변화
    @Default(0) int lust,

    /// S/M 성향 (-100 ~ +100), 음수: Submissive, 양수: Dominant, 0: Switch
    @Default(0) int dominance,

    /// 현재 감정 (예: "Happy", "Anxious", "Horny", "Jealous")
    @Default('Neutral') String mood,
  }) = _PartnerEmotionalState;

  factory PartnerEmotionalState.fromJson(Map<String, dynamic> json) =>
      _$PartnerEmotionalStateFromJson(json);
}
