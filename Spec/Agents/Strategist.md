# Strategist Agent Specification

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 역할

유저 선택지 생성

## 실행 시점

매 턴

## 입력 데이터

```json
{
  "currentSituation": "공원에서 손을 잡고 걷는 중",
  "partnerLastResponse": { /* Partner 응답 */ },
  "partnerEmotionalState": { /* PartnerEmotionalState */ },
  "worldState": { /* WorldState */ },
  "userProfile": { /* UserProfile */ },
  "conversationHistory": [ /* 최근 5턴 */ ]
}
```

## 출력 데이터

```json
{
  "choices": [
    {
      "id": "choice_1",
      "action": "파트너의 손을 더 꼭 잡으며",
      "speech": "오늘 정말 좋은 날이다",
      "sdxlTags": "holding hands tighter, smiling",
      "tone": "Affectionate",
      "predictedOutcome": "호감도와 친밀감 상승"
    },
    {
      "id": "choice_2",
      "action": "벤치를 가리키며",
      "speech": "잠깐 앉아서 쉴까?",
      "sdxlTags": "pointing at bench, suggesting rest",
      "tone": "Casual",
      "predictedOutcome": "대화 깊이 증가, 시간 경과"
    },
    {
      "id": "choice_3",
      "action": "파트너의 얼굴을 바라보며",
      "speech": "너 정말 예쁘다",
      "sdxlTags": "looking at face, compliment",
      "tone": "Romantic",
      "predictedOutcome": "호감도 및 흥분도 상승"
    }
  ]
}
```

## 핵심 책임

1. **상황 적합성**: 현재 위치, 분위기, 관계 단계에 맞는 선택지
2. **다양성 제공**: 감정적/논리적/행동적 선택지 균형
3. **User Fetish 반영**: 적절한 타이밍에 유저 취향 반영
4. **SDXL 태그 생성**: 각 선택지마다 이미지 생성용 태그

## 추천 LLM 모델

- **모델**: GPT-4o-mini, Claude 3 Haiku
- **Temperature**: 0.7
- **Max Tokens**: 1500
- **이유**: 빠른 응답, 비용 절감
