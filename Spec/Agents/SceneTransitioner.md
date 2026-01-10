# Scene Transitioner Agent Specification

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 역할

챕터 전환 처리 (사용자가 현재 상황을 종료하고 다음 장면으로 넘어가고 싶을 때)

## 실행 시점

사용자가 전략 선택 화면에서 "다음 챕터로" 또는 "장면 전환" 버튼 클릭 시

## 입력 데이터

```json
{
  "currentState": {
    "partnerProfile": { /* PartnerProfile 전체 */ },
    "userProfile": { /* UserProfile */ },
    "worldState": { /* WorldState */ },
    "conversationHistory": [ /* 최근 10턴 */ ]
  },
  "transitionIntent": "next_day",
  "userHint": "다음 날 아침으로"
}
```

## 출력 데이터

```json
{
  "sceneTransition": {
    "transitionType": "next_day",
    "narration": "밤이 깊어지고, 두 사람은 각자의 집으로 돌아갔다. 다음 날 아침, 따스한 햇살이 창문을 통해 들어왔다.",
    
    "newTime": "2024-01-11T08:00:00",
    "newWeather": "sunny",
    "newUserLocation": "user_home",
    "newPartnerLocation": "partner_home",
    
    "partnerAdjustment": {
      "affectionDelta": 0,
      "trustDelta": 0,
      "arousalDelta": -60,
      "lustDelta": -40,
      "dominanceDelta": 0,
      "newMood": "Refreshed",
      "newOutfit": "casual_morning_clothes",
      "memoryToAdd": "어제 공원에서 손을 잡고 걸었던 달콤한 시간",
      "traumaToAdd": null
    },
    
    "currentSituation": null,
    "ongoingEvent": null
  },
  
  "newInitialSituation": "아침 햇살을 받으며 일어난 당신은 어제의 달콤한 기억을 떠올린다."
}
```

## 핵심 책임

1. **맥락 분석**: 최근 대화 히스토리를 분석하여 자연스러운 전환점 찾기
2. **시간/장소 재설정**: 새로운 챕터에 맞는 시간대, 날씨, 위치 설정
3. **감정 상태 조정**: arousal/lust 리셋, affection/trust 유지
4. **메모리 생성**: 이전 챕터의 중요 이벤트 요약
5. **상황/이벤트 리셋**: currentSituation과 ongoingEvent를 null로 설정
6. **새 상황 설정**: 다음 챕터의 시작 상황 생성

## 전환 유형

| 유형 | 시간 변화 | 위치 변화 | 감정 리셋 | 사용 예시 |
|---|---|---|---|---|
| `time_skip` | 몇 시간 경과 | 없음 | arousal/lust 소폭 감소 | "몇 시간 후" |
| `location_change` | 없음 | 새로운 장소 | 유지 | "카페로 이동" |
| `next_day` | 다음 날 | 각자 집으로 리셋 | arousal/lust 대폭 감소 | "다음 날 아침" |

## 추천 LLM 모델

- **모델**: Claude 3.5 Sonnet, GPT-4
- **Temperature**: 0.8
- **Max Tokens**: 2000
- **이유**: 맥락 분석, 자연스러운 전환
