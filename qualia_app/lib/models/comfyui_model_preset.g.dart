// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comfyui_model_preset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ComfyUIModelPresetImpl _$$ComfyUIModelPresetImplFromJson(
        Map<String, dynamic> json) =>
    _$ComfyUIModelPresetImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      category: $enumDecode(_$PresetCategoryEnumMap, json['category']),
      checkpointModel: json['checkpointModel'] as String,
      vae: json['vae'] as String?,
      upscaleModel: json['upscaleModel'] as String?,
      latentImageSize: $enumDecode(_$ImageSizeEnumMap, json['latentImageSize']),
      cfgScale: (json['cfgScale'] as num).toDouble(),
      steps: (json['steps'] as num).toInt(),
      sampler: json['sampler'] as String,
      scheduler: json['scheduler'] as String,
      defaultPositive: json['defaultPositive'] as String,
      defaultNegative: json['defaultNegative'] as String,
      isBuiltIn: json['isBuiltIn'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
    );

Map<String, dynamic> _$$ComfyUIModelPresetImplToJson(
        _$ComfyUIModelPresetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': _$PresetCategoryEnumMap[instance.category]!,
      'checkpointModel': instance.checkpointModel,
      'vae': instance.vae,
      'upscaleModel': instance.upscaleModel,
      'latentImageSize': _$ImageSizeEnumMap[instance.latentImageSize]!,
      'cfgScale': instance.cfgScale,
      'steps': instance.steps,
      'sampler': instance.sampler,
      'scheduler': instance.scheduler,
      'defaultPositive': instance.defaultPositive,
      'defaultNegative': instance.defaultNegative,
      'isBuiltIn': instance.isBuiltIn,
      'createdAt': instance.createdAt.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
    };

const _$PresetCategoryEnumMap = {
  PresetCategory.sdxl: 'sdxl',
  PresetCategory.pony: 'pony',
  PresetCategory.flux: 'flux',
};

const _$ImageSizeEnumMap = {
  ImageSize.portrait: 'portrait',
  ImageSize.square: 'square',
  ImageSize.landscape: 'landscape',
};
