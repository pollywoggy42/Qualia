# Scenario Generator Agent Specification

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 역할

세션 초기 설정 생성 (AI 가챠)

## 실행 시점

세션 생성 시

## 입력 데이터

```json
{
  "userGender": "male",
  "partnerGender": "female",
  "preferences": {
    "genre": "romance",
    "setting": "modern"
  }
}
```

## 출력 데이터

완전한 Partner, User, WorldState, 초기 시나리오 생성

```json
{
  "partner": {
    "name": "사쿠라",
    "age": 22,
    "gender": "female",
    "occupation": "대학생",
    "location": "university_library",
    "face": {
      "description": "큰 눈과 부드러운 미소를 가진 귀여운 얼굴",
      "sdxlTags": "cute face, large eyes, soft smile"
    },
    "personality": {
      "mbti": "INFP",
      "speechStyle": "존댓말",
      "traits": ["내향적", "감성적", "배려심 많음"]
    },
    "secret": "실은 유명 작가의 딸이지만 숨기고 있다",
    "secretFragments": ["유명 작가", "아버지", "숨기다", "비밀"]
  },
  
  "user": { /* UserProfile */ },
  "worldState": { /* WorldState */ },
  "initialSituation": "당신은 도서관에서 책을 찾다가 우연히 사쿠라와 같은 책을 집으려다 손이 마주쳤다.",
  "suggestedGenre": "Pure Romance"
}
```

## 핵심 책임

1. **창의적 설정 생성**: 매번 다른 흥미로운 시나리오
2. **성별 조합 최적화**: 성별에 맞는 캐릭터 아키타입
3. **일관성 유지**: Partner/User/World 설정이 서로 맞아떨어지도록
4. **SDXL 태그 자동 생성**: 모든 VisualDescriptor에 태그 포함
5. **Secret & Fragments 생성**: 트라우마 시스템을 위한 비밀과 트리거 키워드

## 추천 LLM 모델

- **모델**: Claude 3.5 Sonnet, GPT-4
- **Temperature**: 0.9
- **Max Tokens**: 3000
- **이유**: 창의성
