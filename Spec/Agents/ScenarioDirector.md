# Scenario Director Agent Specification

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 역할

세계 관리자 + 서사 작가

## 실행 시점

매 턴

## 입력 데이터

```json
{
  "userInput": { /* User 입력 */ },
  "partnerResponse": { /* Partner 응답 */ },
  "worldState": { /* WorldState 전체 */ },
  "partnerProfile": { /* PartnerProfile */ },
  "userProfile": { /* UserProfile */ },
  "conversationHistory": [ /* 최근 3-5턴 */ ]
}
```

## 출력 데이터

```json
{
  "narration": "두 사람은 손을 잡고 석양이 지는 공원을 걷기 시작했다.",
  
  "locationChanges": {
    "userLocation": "park",
    "partnerLocation": "park",
    "reason": "함께 이동"
  },
  
  "timeChange": null,
  "weatherChange": null,
  
  "currentSituation": {
    "description": "벚꽃이 흩날리는 석양 속을 걷는 중",
    "sdxlTags": "cherry blossoms, sunset, petals falling, romantic walk"
  },
  
  "ongoingEvent": null,
  축
  "outfitChanges": {
    "partner": null,
    "user": null
  },
  
  "shouldGenerateImage": true,
  "emotionalAtmosphere": "Romantic"
}
```

## 핵심 책임

1. **위치 변경 감지**: 대화 맥락에서 이동 의도 파악 (보수적 접근)
2. **시간 흐름 관리**: 자연스러운 시간 경과 처리
3. **환경 변화**: 날씨, 분위기 변경
4. **현재 상황 관리**: 
   - 계속되는 상황이면 유지/업데이트
   - 종료되면 null
   - 설명과 SDXL 태그 함께 제공
5. **이벤트 관리**: 중요한 서사 이벤트 추적
6. **이미지 생성 결정**: 시각화 필요 순간 판단
7. **Outfit 변경**: 시간/장소 변화에 따른 의상 변경

## 이미지 생성 판단 기준

- **NSFW 진입 후**: 매 턴 생성
- **NSFW 이전**:
  - 기본: 4턴당 1회 무조건
  - 즉시 생성 조건:
    - 장소 변경
    - 의상 변경
    - 중요한 행동/이벤트
    - 분위기 전환

## 추천 LLM 모델

- **모델**: Grok 4.1 Fast
- **Temperature**: 0.8
- **Max Tokens**: 1500
- **이유**: 복잡한 판단, 세계 관리
