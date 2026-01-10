# Initial Partner Image Generator Specification

> **Version**: 1.0  
> **Last Updated**: 2026-01-11

## 역할

세션 생성 시 Partner의 첫 프로필 이미지 생성 (얼굴 중심)

## 실행 시점

Scenario Generator 실행 직후, 세션 생성 완료 전

## 입력 데이터

```json
{
  "partner": {
    "face": {
      "description": "큰 눈과 부드러운 미소를 가진 귀여운 얼굴",
      "sdxlTags": "cute face, large eyes, soft smile, gentle expression"
    },
    "hairstyle": {
      "description": "금발의 긴 생머리를 포니테일로 묶음",
      "sdxlTags": "blonde hair, long hair, straight hair, ponytail"
    }
  },
  "modelPreset": {
    "name": "Realistic Style",
    "category": "SDXL",
    "positivePrompt": "masterpiece, best quality, highly detailed",
    "negativePrompt": "low quality, worst quality, blurry"
  }
}
```

## 출력 데이터

```json
{
  "imageUrl": "https://...",
  "prompt": "cute face, large eyes, soft smile, gentle expression, blonde hair, long hair, straight hair, ponytail, portrait, close-up, masterpiece, best quality, highly detailed",
  "latentImageSize": "square"
}
```

## 핵심 로직

### 1. 프롬프트 구성

**사용 태그**:
- `partner.face.sdxlTags`
- `partner.hairstyle.sdxlTags`
- **추가 고정 태그**: `portrait`, `close-up`, `face focus`

**제외 태그**:
- ❌ body (몸매는 제외)
- ❌ outfit (의상은 제외)
- ❌ accessories (액세서리는 제외)

**최종 프롬프트 구조**:
```
{face.sdxlTags}, {hairstyle.sdxlTags}, portrait, close-up, face focus, {modelPreset.positivePrompt}
```

### 2. 이미지 크기

**고정값**: `square` (1:1 비율)

이유:
- 프로필 이미지로 사용
- 얼굴 중심 구도에 최적
- UI에서 원형/정사각형으로 표시

### 3. ComfyUI 워크플로우

```json
{
  "workflow": "text2img",
  "latentImageSize": "square",
  "positivePrompt": "...",
  "negativePrompt": "...",
  "modelConfig": {
    "checkpoint": "...",
    "vae": "...",
    "upscaleModel": "..."
  }
}
```

## 예시

### 입력
```json
{
  "partner": {
    "face": {
      "sdxlTags": "beautiful face, sharp eyes, confident expression"
    },
    "hairstyle": {
      "sdxlTags": "black hair, short hair, messy"
    }
  },
  "modelPreset": {
    "positivePrompt": "masterpiece, best quality",
    "negativePrompt": "low quality"
  }
}
```

### 생성된 프롬프트
```
beautiful face, sharp eyes, confident expression, black hair, short hair, messy, portrait, close-up, face focus, masterpiece, best quality
```

### Negative 프롬프트
```
low quality, full body, multiple people, background focus
```

## 에러 처리

### 생성 실패 시
1. 재시도 (최대 3회)
2. 실패 시 기본 플레이스홀더 이미지 사용
3. 사용자에게 알림

### 타임아웃
- 최대 대기 시간: 30초
- 초과 시 플레이스홀더 사용

## 성능 고려사항

- **비동기 처리**: 세션 생성과 병렬 실행 가능
- **캐싱**: 동일 설정 재생성 시 이전 결과 재사용 고려
- **우선순위**: 다른 이미지 생성보다 높은 우선순위

## 차이점: Visual Director와 비교

| 항목 | Initial Partner Image | Visual Director |
|---|---|---|
| 목적 | 프로필 이미지 | 상황 이미지 |
| 크기 | square (고정) | portrait/square/landscape |
| 태그 | face + hair만 | 전체 (body, outfit, situation 등) |
| 인물 수 | 1명 (Partner만) | 1-2명 (상황에 따라) |
| 배경 | 최소화 | 상황에 맞게 |

## 구현 클래스

```dart
class InitialPartnerImageGenerator {
  final ComfyUIService comfyUIService;
  
  Future<GeneratedImage> generate({
    required PartnerProfile partner,
    required ComfyUIModelPreset modelPreset,
  }) async {
    // 1. 프롬프트 구성
    final prompt = _buildPrompt(partner, modelPreset);
    
    // 2. ComfyUI 호출
    final imageUrl = await comfyUIService.generateImage(
      positivePrompt: prompt.positive,
      negativePrompt: prompt.negative,
      latentImageSize: LatentImageSize.square,
      modelPreset: modelPreset,
    );
    
    return GeneratedImage(
      url: imageUrl,
      prompt: prompt.positive,
      size: LatentImageSize.square,
    );
  }
  
  PromptPair _buildPrompt(
    PartnerProfile partner,
    ComfyUIModelPreset modelPreset,
  ) {
    final faceTags = partner.face.sdxlTags;
    final hairTags = partner.hairstyle.sdxlTags;
    
    final positive = [
      faceTags,
      hairTags,
      'portrait',
      'close-up',
      'face focus',
      modelPreset.positivePrompt,
    ].join(', ');
    
    final negative = [
      modelPreset.negativePrompt,
      'full body',
      'multiple people',
      'background focus',
    ].join(', ');
    
    return PromptPair(positive: positive, negative: negative);
  }
}
```

## 변경 이력

| 날짜 | 변경 내용 |
|---|---|
| 2026-01-11 | 초안 작성: 초기 파트너 이미지 생성 로직 정의 |
