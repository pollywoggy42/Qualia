import 'package:freezed_annotation/freezed_annotation.dart';

part 'comfyui_model_preset.freezed.dart';
part 'comfyui_model_preset.g.dart';

/// Preset Category - 워크플로우 결정
enum PresetCategory {
  sdxl,   // SDXL 기반 모델 (일반적인 워크플로우)
  pony,   // Pony Diffusion 계열 (score 기반 프롬프트)
  flux,   // Flux 계열 (향후 확장)
}

/// Image Size - 이미지 크기
enum ImageSize {
  portrait,   // 832x1216 (세로)
  square,     // 1024x1024 (정사각형)
  landscape,  // 1216x832 (가로)
}

/// ComfyUI Model Preset - 세션별 이미지 생성 모델 설정
@freezed
class ComfyUIModelPreset with _$ComfyUIModelPreset {
  const factory ComfyUIModelPreset({
    required String id,
    required String name,
    required PresetCategory category,

    // Model Configuration
    required String checkpointModel,
    String? vae,
    String? upscaleModel,

    // Image Size
    required ImageSize latentImageSize,

    // Generation Parameters
    required double cfgScale,
    required int steps,
    required String sampler,
    required String scheduler,

    // Default Prompts
    required String defaultPositive,
    required String defaultNegative,

    // Metadata
    @Default(false) bool isBuiltIn,
    required DateTime createdAt,
    DateTime? modifiedAt,
  }) = _ComfyUIModelPreset;

  factory ComfyUIModelPreset.fromJson(Map<String, dynamic> json) =>
      _$ComfyUIModelPresetFromJson(json);
}

/// 기본 제공 프리셋들
class BuiltInPresets {
  static final realisticStyle = ComfyUIModelPreset(
    id: 'preset_sdxl_realistic',
    name: 'Realistic Style',
    category: PresetCategory.sdxl,
    checkpointModel: 'realisticVisionV60B1_v51VAE.safetensors',
    upscaleModel: '4x-AnimeSharp',
    latentImageSize: ImageSize.portrait,
    cfgScale: 1.0,
    steps: 20,
    sampler: 'euler_cfg_pp',
    scheduler: 'kl_optimal',
    defaultPositive: 'masterpiece, best quality, ultra detailed, photorealistic, 8k uhd, dslr, soft lighting, high quality',
    defaultNegative: 'cartoon, anime, illustration, (worst quality, low quality:1.4), lowres, blurry, text, watermark',
    isBuiltIn: true,
    createdAt: DateTime(2026, 1, 1),
  );

  static final animeStyle = ComfyUIModelPreset(
    id: 'preset_sdxl_anime',
    name: 'Anime Style',
    category: PresetCategory.sdxl,
    checkpointModel: 'zenijiMixKWebtoon_v10.safetensors',
    upscaleModel: '4x-AnimeSharp.pth',
    latentImageSize: ImageSize.portrait,
    cfgScale: 1.0,
    steps: 20,
    sampler: 'euler_cfg_pp',
    scheduler: 'kl_optimal',
    defaultPositive: 'masterpiece, best quality, ultra-detailed, illustration, Korean idol style, young Korean beauty, 18-23 years old, delicate youthful face, large eyes, aegyo-sal, subtle blush, glossy full lips, flawless smooth skin, soft lighting, detailed hair, intricate eyes',
    defaultNegative: 'low quality, blurry, artifact, painting, 3d render, sparkling eyes, glowing eyes, overexposed, underexposed, deformed face, bad anatomy, extra fingers, watermark, text',
    isBuiltIn: true,
    createdAt: DateTime(2026, 1, 1),
  );

  static final semiRealisticPony = ComfyUIModelPreset(
    id: 'preset_pony_semi_realistic',
    name: 'Semi-Realistic (Pony)',
    category: PresetCategory.pony,
    checkpointModel: 'ponyDiffusionV6XL_v6.safetensors',
    upscaleModel: '4x-AnimeSharp',
    latentImageSize: ImageSize.portrait,
    cfgScale: 1.0,
    steps: 20,
    sampler: 'euler_cfg_pp',
    scheduler: 'kl_optimal',
    defaultPositive: 'score_9, score_8_up, score_7_up, masterpiece, best quality, detailed',
    defaultNegative: 'score_6, score_5, score_4, worst quality, low quality, text, censored',
    isBuiltIn: true,
    createdAt: DateTime(2026, 1, 1),
  );

  static List<ComfyUIModelPreset> get all => [
    realisticStyle,
    animeStyle,
    semiRealisticPony,
  ];
}
