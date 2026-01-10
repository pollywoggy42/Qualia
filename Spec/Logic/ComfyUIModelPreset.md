# ComfyUI Model Preset

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 개요

세션별 이미지 생성 모델 설정. 카테고리별로 다른 워크플로우를 사용.

## Preset Category

```dart
enum PresetCategory {
  sdxl,           // SDXL 기반 모델 (일반적인 워크플로우)
  pony,           // Pony Diffusion 계열 (score 기반 프롬프트)
  flux,           // Flux 계열 (향후 확장)
}
```

## Image Size

```dart
enum ImageSize {
  portrait,     // 832x1216 (세로)
  square,       // 1024x1024 (정사각형)
  landscape,    // 1216x832 (가로)
}
```

## ComfyUI Model Preset

```dart
class ComfyUIModelPreset {
  String id;                    // 프리셋 고유 ID
  String name;                  // 프리셋 이름 (예: "Realistic Style")
  PresetCategory category;      // 프리셋 카테고리 (워크플로우 결정)
  
  // Model Configuration
  String checkpointModel;       // 체크포인트 파일명
  String? vae;                  // VAE 파일명 (optional)
  String? upscaleModel;         // 업스케일 모델 (예: "4x-AnimeSharp")
  
  // Image Size
  ImageSize latentImageSize;    // 이미지 크기
  
  // Generation Parameters
  double cfgScale;              // CFG Scale (1.0 ~ 20.0)
  int steps;                    // Sampling steps (20 ~ 50)
  String sampler;               // Sampler 이름
  String scheduler;             // Scheduler
  
  // Default Prompts
  String defaultPositive;       // 기본 Positive Prompt
  String defaultNegative;       // 기본 Negative Prompt
  
  // Metadata
  bool isBuiltIn;               // 기본 제공 템플릿 여부
  DateTime createdAt;           // 생성 시간
  DateTime? modifiedAt;         // 수정 시간
}
```

## 기본 템플릿

### SDXL Category

```dart
// Realistic Style
ComfyUIModelPreset(
  id: 'preset_sdxl_realistic',
  name: 'Realistic Style',
  category: PresetCategory.sdxl,
  checkpointModel: 'realisticVisionV60B1_v51VAE.safetensors',
  vae: null,
  upscaleModel: '4x-AnimeSharp',
  latentImageSize: ImageSize.portrait,
  cfgScale: 7.0,
  steps: 30,
  sampler: 'DPM++ 2M Karras',
  scheduler: 'karras',
  defaultPositive: 'masterpiece, best quality, ultra detailed, photorealistic, 8k uhd, dslr, soft lighting, high quality',
  defaultNegative: 'cartoon, anime, illustration, (worst quality, low quality:1.4), lowres, blurry, text, watermark',
  isBuiltIn: true,
);

// Anime Style
ComfyUIModelPreset(
  id: 'preset_sdxl_anime',
  name: 'Anime Style',
  category: PresetCategory.sdxl,
  checkpointModel: 'animagineXLV3_v30.safetensors',
  vae: null,
  upscaleModel: '4x-AnimeSharp',
  latentImageSize: ImageSize.portrait,
  cfgScale: 7.0,
  steps: 28,
  sampler: 'Euler a',
  scheduler: 'normal',
  defaultPositive: 'masterpiece, best quality, very aesthetic, absurdres, newest, anime coloring',
  defaultNegative: '(worst quality, low quality:1.4), greyscale, zombie, sketch, interlocked fingers, comic',
  isBuiltIn: true,
);
```

### Pony Category

```dart
// Semi-Realistic
ComfyUIModelPreset(
  id: 'preset_pony_semi_realistic',
  name: 'Semi-Realistic (Pony)',
  category: PresetCategory.pony,
  checkpointModel: 'ponyDiffusionV6XL_v6.safetensors',
  vae: null,
  upscaleModel: '4x-AnimeSharp',
  latentImageSize: ImageSize.portrait,
  cfgScale: 6.0,
  steps: 25,
  sampler: 'Euler a',
  scheduler: 'normal',
  defaultPositive: 'score_9, score_8_up, score_7_up, masterpiece, best quality, detailed',
  defaultNegative: 'score_6, score_5, score_4, worst quality, low quality, text, censored',
  isBuiltIn: true,
);
```

## 카테고리별 워크플로우 차이

| Category | Prompt Format | Workflow | 특징 |
|---|---|---|---|
| `sdxl` | 일반 태그 나열 | 표준 SDXL | 범용적, 다양한 모델 |
| `pony` | score 기반 | Pony 전용 | score_9, score_8_up 등 필수 |
| `flux` | 자연어 + 태그 | Flux 전용 | 향후 지원 예정 |

## 사용자 카테고리 전환

사용자는 세션 생성 시 카테고리를 선택:

1. 카테고리 선택: SDXL / Pony / Flux
2. 해당 카테고리의 프리셋 목록 표시
3. 프리셋 선택 또는 커스텀 생성

**참고**: 세션 중간 카테고리 변경 불가 (워크플로우가 완전히 다름)
