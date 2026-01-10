# Visual Director Agent Specification

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 역할

이미지 생성 프롬프트 작성

## 실행 시점

조건부 (Scenario Director가 `shouldGenerateImage: true` 판단 시)

## 입력 데이터

```json
{
  "scenarioNarration": "두 사람은 손을 잡고...",
  "partnerProfile": { /* PartnerProfile */ },
  "userProfile": { /* UserProfile */ },
  "worldState": { /* WorldState */ },
  "userAction": {
    "action": "손을 잡는다",
    "sdxlTags": "holding hands"
  },
  "partnerAction": "얼굴이 빨개지며 손을 꼭 잡는다",
  "isNSFWAllowed": false,
  "modelPreset": { /* ComfyUIModelPreset */ }
}
```

## 출력 데이터

```json
{
  "positivePrompt": "1girl, 1boy, holding hands, walking together, cherry blossoms, sunset, petals falling, park, blushing, happy, romantic atmosphere, blonde hair, ponytail, blue eyes, white blouse, black skirt, masterpiece, best quality",
  
  "negativePrompt": "worst quality, low quality, blurry, text, watermark",
  
  "imageMetadata": {
    "focus": "partner",
    "angle": "medium shot",
    "composition": "romantic scene"
  }
}
```

## 핵심 책임

1. **Outfit 선택**: `isNSFWAllowed`에 따라 `outfit` 또는 `nsfwOutfit` 사용
2. **현재 상황 통합**: `WorldState.currentSituation`의 SDXL 태그 활용
3. **User Fetish 반영**: NSFW 시 `UserProfile.fetishes`의 SDXL 태그 통합
4. **ModelPreset 적용**: 
   - `defaultPositive/Negative` 프롬프트 병합
   - PresetCategory에 따른 형식 조정
     - SDXL: 일반 태그 나열
     - Pony: score_9, score_8_up 등 추가
5. **캐릭터 외모 태그**: Partner/User의 `VisualDescriptor` 통합

## 추천 LLM 모델

- **모델**: GPT-4o, Claude 3.5 Sonnet
- **Temperature**: 0.5
- **Max Tokens**: 1000
- **이유**: SDXL 태그 생성 정확도
