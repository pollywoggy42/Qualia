# Scene Transition

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 개요

챕터 전환 시 사용되는 장면 전환 정보.

## 데이터 구조

```dart
class SceneTransition {
  // 전환 메타데이터
  String transitionType;        // 전환 유형 ("time_skip", "location_change", "next_day")
  String narration;             // 전환 서술
  
  // 세계 상태 변경
  DateTime? newTime;            // 새로운 시간 (null이면 변경 없음)
  String? newWeather;           // 새로운 날씨
  String? newUserLocation;      // User의 새 위치
  String? newPartnerLocation;   // Partner의 새 위치
  
  // Partner 상태 조정
  PartnerStateAdjustment? partnerAdjustment;
  
  // 효과 정리
  List<String> effectsToRemove; // 제거할 NarrativeEffect ID 목록
  bool clearAllEffects;         // 모든 효과 제거 여부
}

class PartnerStateAdjustment {
  // 감정 수치 조정 (delta 값)
  int? affectionDelta;          // 호감도 변화량
  int? trustDelta;              // 신뢰도 변화량
  int? arousalDelta;            // 흥분도 변화량
  int? lustDelta;               // 성욕 변화량
  int? dominanceDelta;          // Dominance 변화량
  
  // 상태 변경
  String? newMood;              // 새로운 Mood
  String? newOutfit;            // 새로운 의상
  
  // 메모리 추가
  String? memoryToAdd;          // 추가할 기억
  
  // 트라우마 추가
  String? traumaToAdd;          // 추가할 트라우마 (optional)
}
```

## 전환 유형

| 유형 | 시간 변화 | 위치 변화 | 감정 리셋 | 사용 예시 |
|---|---|---|---|---|
| `time_skip` | 몇 시간 경과 | 없음 | arousal/lust 소폭 감소 | "몇 시간 후" |
| `location_change` | 없음 | 새로운 장소 | 유지 | "카페로 이동" |
| `next_day` | 다음 날 | 각자 집으로 리셋 | arousal/lust 대폭 감소 | "다음 날 아침" |

## 사용 시나리오

1. **time_skip**: 같은 날, 같은 장소에서 시간만 경과
2. **location_change**: 즉시 다른 장소로 이동 (시간 변화 최소)
3. **next_day**: 하루 이상 경과, 위치와 상태 리셋
