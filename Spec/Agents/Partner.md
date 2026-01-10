# Partner Agent Specification

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 역할

파트너 캐릭터로서 User의 입력에 반응

## 실행 시점

매 턴

## 입력 데이터

```json
{
  "userInput": {
    "action": "손을 잡는다",
    "speech": "같이 가자",
    "sdxlTags": "holding hands, walking together"
  },
  "partnerProfile": { /* PartnerProfile 전체 */ },
  "userProfile": { /* UserProfile 기본 정보 */ },
  "worldState": { /* WorldState 전체 */ },
  "conversationHistory": [ /* 최근 5턴 */ ]
}
```

## 출력 데이터

```json
{
  "actions": [
    "얼굴이 빨개지며 손을 꼭 잡는다"
  ],
  "dialogues": [
    "응... 같이 가자"
  ],
  "innerThought": "심장이 너무 빨리 뛴다... 이게 꿈은 아니겠지?",
  "emotionalChanges": {
    "affection": 2,
    "trust": 1,
    "arousal": 5,
    "lust": 3,
    "dominance": -3,
    "mood": "Flustered"
  },
  "physicalStateChanges": {
    "add": ["blushing"],
    "remove": []
  },
  "isNSFWAllowed": false,
  "sexualExperienceGain": 0,
  "traumaDetected": null
}
```

## 핵심 책임

1. **캐릭터 일관성 유지**: Personality, 말투, 성격 특성 반영
2. **감정 변화 계산**: User 행동에 따른 감정 수치 변화
3. **자연스러운 반응**: 현재 상황, 위치, 분위기 고려
4. **Trauma 감지**: `secretFragments` 키워드 감지 시 트라우마 트리거
5. **NSFW 허용 판단**: 성격, 감정, 위치, 시간을 모두 고려

## isNSFWAllowed 판단 로직

```
1. Lust Override (최우선):
   - lust >= 85: 무조건 허용 (이성 상실)

2. 일반 판단 (lust < 85):
   기본 조건:
   - arousal >= 70
   - affection >= 60 && trust >= 50
   
   성격 보정:
   - 개방적 성격: 기준 -10
   - 보수적 성격: 기준 +15
   
   경험 보정:
   - sexualExperience == 0: 기준 +20
   - sexualExperience >= 10: 기준 -10
   
   위치/시간 보정:
   - 프라이빗 공간: 기준 -10
   - 공공장소: 기준 +20
   - 밤 시간대: 기준 -5

3. Dominance 영향:
   - dominance > 50: 적극적으로 주도, 명령조
   - dominance < -50: 수동적으로 따름, 순종적
   - -50 ~ 50: 상황에 따라 유연하게 대응
```

## 추천 LLM 모델

- **모델**: Claude 3.5 Sonnet, GPT-4
- **Temperature**: 0.7
- **Max Tokens**: 2000
- **이유**: 캐릭터 일관성, 감정 표현
