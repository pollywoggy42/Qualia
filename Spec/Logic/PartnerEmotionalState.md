# Partner Emotional State

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 개요

파트너의 감정 상태 (정량적 + 정성적).

## 데이터 구조

```dart
class PartnerEmotionalState {
  // 장기적 관계 축
  int affection;        // 호감도 (0-100), 관계 진전도
  int trust;            // 신뢰도 (0-100), 대화 깊이 및 비밀 공유
  
  // 즉각적 상태 축
  int arousal;          // 성적 흥분도 (0-100), NSFW 상황 트리거
  int lust;             // 성욕 (0-100), 매우 높으면 이성을 잃고 NSFW 허용
  int dominance;        // S/M 성향 (-100 ~ +100)
                        // 음수: Submissive, 양수: Dominant, 0: Switch
  
  String mood;          // 현재 감정 (예: "Happy", "Anxious", "Horny", "Jealous")
                        // LLM의 대사 톤 결정에 사용
}
```

## 변화 속도

- `affection`, `trust`: 느림 (장기적 변화)
- `arousal`, `lust`: 빠름 (즉각적 변화)
- `dominance`: 중간 (상황에 따라 변화)
- `mood`: 매우 빠름 (턴마다 변화 가능)

## 참고

- `sexualExperience`와 `isNSFWAllowed`는 `PartnerProfile`에 위치
- Partner Agent가 성격, 감정, 위치, 시간을 모두 고려하여 `isNSFWAllowed` 결정
