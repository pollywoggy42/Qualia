// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comfyui_model_preset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ComfyUIModelPreset _$ComfyUIModelPresetFromJson(Map<String, dynamic> json) {
  return _ComfyUIModelPreset.fromJson(json);
}

/// @nodoc
mixin _$ComfyUIModelPreset {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  PresetCategory get category =>
      throw _privateConstructorUsedError; // Model Configuration
  String get checkpointModel => throw _privateConstructorUsedError;
  String? get vae => throw _privateConstructorUsedError;
  String? get upscaleModel => throw _privateConstructorUsedError; // Image Size
  ImageSize get latentImageSize =>
      throw _privateConstructorUsedError; // Generation Parameters
  double get cfgScale => throw _privateConstructorUsedError;
  int get steps => throw _privateConstructorUsedError;
  String get sampler => throw _privateConstructorUsedError;
  String get scheduler => throw _privateConstructorUsedError; // Default Prompts
  String get defaultPositive => throw _privateConstructorUsedError;
  String get defaultNegative => throw _privateConstructorUsedError; // Metadata
  bool get isBuiltIn => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get modifiedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComfyUIModelPresetCopyWith<ComfyUIModelPreset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComfyUIModelPresetCopyWith<$Res> {
  factory $ComfyUIModelPresetCopyWith(
          ComfyUIModelPreset value, $Res Function(ComfyUIModelPreset) then) =
      _$ComfyUIModelPresetCopyWithImpl<$Res, ComfyUIModelPreset>;
  @useResult
  $Res call(
      {String id,
      String name,
      PresetCategory category,
      String checkpointModel,
      String? vae,
      String? upscaleModel,
      ImageSize latentImageSize,
      double cfgScale,
      int steps,
      String sampler,
      String scheduler,
      String defaultPositive,
      String defaultNegative,
      bool isBuiltIn,
      DateTime createdAt,
      DateTime? modifiedAt});
}

/// @nodoc
class _$ComfyUIModelPresetCopyWithImpl<$Res, $Val extends ComfyUIModelPreset>
    implements $ComfyUIModelPresetCopyWith<$Res> {
  _$ComfyUIModelPresetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? checkpointModel = null,
    Object? vae = freezed,
    Object? upscaleModel = freezed,
    Object? latentImageSize = null,
    Object? cfgScale = null,
    Object? steps = null,
    Object? sampler = null,
    Object? scheduler = null,
    Object? defaultPositive = null,
    Object? defaultNegative = null,
    Object? isBuiltIn = null,
    Object? createdAt = null,
    Object? modifiedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as PresetCategory,
      checkpointModel: null == checkpointModel
          ? _value.checkpointModel
          : checkpointModel // ignore: cast_nullable_to_non_nullable
              as String,
      vae: freezed == vae
          ? _value.vae
          : vae // ignore: cast_nullable_to_non_nullable
              as String?,
      upscaleModel: freezed == upscaleModel
          ? _value.upscaleModel
          : upscaleModel // ignore: cast_nullable_to_non_nullable
              as String?,
      latentImageSize: null == latentImageSize
          ? _value.latentImageSize
          : latentImageSize // ignore: cast_nullable_to_non_nullable
              as ImageSize,
      cfgScale: null == cfgScale
          ? _value.cfgScale
          : cfgScale // ignore: cast_nullable_to_non_nullable
              as double,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      sampler: null == sampler
          ? _value.sampler
          : sampler // ignore: cast_nullable_to_non_nullable
              as String,
      scheduler: null == scheduler
          ? _value.scheduler
          : scheduler // ignore: cast_nullable_to_non_nullable
              as String,
      defaultPositive: null == defaultPositive
          ? _value.defaultPositive
          : defaultPositive // ignore: cast_nullable_to_non_nullable
              as String,
      defaultNegative: null == defaultNegative
          ? _value.defaultNegative
          : defaultNegative // ignore: cast_nullable_to_non_nullable
              as String,
      isBuiltIn: null == isBuiltIn
          ? _value.isBuiltIn
          : isBuiltIn // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComfyUIModelPresetImplCopyWith<$Res>
    implements $ComfyUIModelPresetCopyWith<$Res> {
  factory _$$ComfyUIModelPresetImplCopyWith(_$ComfyUIModelPresetImpl value,
          $Res Function(_$ComfyUIModelPresetImpl) then) =
      __$$ComfyUIModelPresetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      PresetCategory category,
      String checkpointModel,
      String? vae,
      String? upscaleModel,
      ImageSize latentImageSize,
      double cfgScale,
      int steps,
      String sampler,
      String scheduler,
      String defaultPositive,
      String defaultNegative,
      bool isBuiltIn,
      DateTime createdAt,
      DateTime? modifiedAt});
}

/// @nodoc
class __$$ComfyUIModelPresetImplCopyWithImpl<$Res>
    extends _$ComfyUIModelPresetCopyWithImpl<$Res, _$ComfyUIModelPresetImpl>
    implements _$$ComfyUIModelPresetImplCopyWith<$Res> {
  __$$ComfyUIModelPresetImplCopyWithImpl(_$ComfyUIModelPresetImpl _value,
      $Res Function(_$ComfyUIModelPresetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? checkpointModel = null,
    Object? vae = freezed,
    Object? upscaleModel = freezed,
    Object? latentImageSize = null,
    Object? cfgScale = null,
    Object? steps = null,
    Object? sampler = null,
    Object? scheduler = null,
    Object? defaultPositive = null,
    Object? defaultNegative = null,
    Object? isBuiltIn = null,
    Object? createdAt = null,
    Object? modifiedAt = freezed,
  }) {
    return _then(_$ComfyUIModelPresetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as PresetCategory,
      checkpointModel: null == checkpointModel
          ? _value.checkpointModel
          : checkpointModel // ignore: cast_nullable_to_non_nullable
              as String,
      vae: freezed == vae
          ? _value.vae
          : vae // ignore: cast_nullable_to_non_nullable
              as String?,
      upscaleModel: freezed == upscaleModel
          ? _value.upscaleModel
          : upscaleModel // ignore: cast_nullable_to_non_nullable
              as String?,
      latentImageSize: null == latentImageSize
          ? _value.latentImageSize
          : latentImageSize // ignore: cast_nullable_to_non_nullable
              as ImageSize,
      cfgScale: null == cfgScale
          ? _value.cfgScale
          : cfgScale // ignore: cast_nullable_to_non_nullable
              as double,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      sampler: null == sampler
          ? _value.sampler
          : sampler // ignore: cast_nullable_to_non_nullable
              as String,
      scheduler: null == scheduler
          ? _value.scheduler
          : scheduler // ignore: cast_nullable_to_non_nullable
              as String,
      defaultPositive: null == defaultPositive
          ? _value.defaultPositive
          : defaultPositive // ignore: cast_nullable_to_non_nullable
              as String,
      defaultNegative: null == defaultNegative
          ? _value.defaultNegative
          : defaultNegative // ignore: cast_nullable_to_non_nullable
              as String,
      isBuiltIn: null == isBuiltIn
          ? _value.isBuiltIn
          : isBuiltIn // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComfyUIModelPresetImpl implements _ComfyUIModelPreset {
  const _$ComfyUIModelPresetImpl(
      {required this.id,
      required this.name,
      required this.category,
      required this.checkpointModel,
      this.vae,
      this.upscaleModel,
      required this.latentImageSize,
      required this.cfgScale,
      required this.steps,
      required this.sampler,
      required this.scheduler,
      required this.defaultPositive,
      required this.defaultNegative,
      this.isBuiltIn = false,
      required this.createdAt,
      this.modifiedAt});

  factory _$ComfyUIModelPresetImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComfyUIModelPresetImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final PresetCategory category;
// Model Configuration
  @override
  final String checkpointModel;
  @override
  final String? vae;
  @override
  final String? upscaleModel;
// Image Size
  @override
  final ImageSize latentImageSize;
// Generation Parameters
  @override
  final double cfgScale;
  @override
  final int steps;
  @override
  final String sampler;
  @override
  final String scheduler;
// Default Prompts
  @override
  final String defaultPositive;
  @override
  final String defaultNegative;
// Metadata
  @override
  @JsonKey()
  final bool isBuiltIn;
  @override
  final DateTime createdAt;
  @override
  final DateTime? modifiedAt;

  @override
  String toString() {
    return 'ComfyUIModelPreset(id: $id, name: $name, category: $category, checkpointModel: $checkpointModel, vae: $vae, upscaleModel: $upscaleModel, latentImageSize: $latentImageSize, cfgScale: $cfgScale, steps: $steps, sampler: $sampler, scheduler: $scheduler, defaultPositive: $defaultPositive, defaultNegative: $defaultNegative, isBuiltIn: $isBuiltIn, createdAt: $createdAt, modifiedAt: $modifiedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComfyUIModelPresetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.checkpointModel, checkpointModel) ||
                other.checkpointModel == checkpointModel) &&
            (identical(other.vae, vae) || other.vae == vae) &&
            (identical(other.upscaleModel, upscaleModel) ||
                other.upscaleModel == upscaleModel) &&
            (identical(other.latentImageSize, latentImageSize) ||
                other.latentImageSize == latentImageSize) &&
            (identical(other.cfgScale, cfgScale) ||
                other.cfgScale == cfgScale) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.sampler, sampler) || other.sampler == sampler) &&
            (identical(other.scheduler, scheduler) ||
                other.scheduler == scheduler) &&
            (identical(other.defaultPositive, defaultPositive) ||
                other.defaultPositive == defaultPositive) &&
            (identical(other.defaultNegative, defaultNegative) ||
                other.defaultNegative == defaultNegative) &&
            (identical(other.isBuiltIn, isBuiltIn) ||
                other.isBuiltIn == isBuiltIn) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      category,
      checkpointModel,
      vae,
      upscaleModel,
      latentImageSize,
      cfgScale,
      steps,
      sampler,
      scheduler,
      defaultPositive,
      defaultNegative,
      isBuiltIn,
      createdAt,
      modifiedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComfyUIModelPresetImplCopyWith<_$ComfyUIModelPresetImpl> get copyWith =>
      __$$ComfyUIModelPresetImplCopyWithImpl<_$ComfyUIModelPresetImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComfyUIModelPresetImplToJson(
      this,
    );
  }
}

abstract class _ComfyUIModelPreset implements ComfyUIModelPreset {
  const factory _ComfyUIModelPreset(
      {required final String id,
      required final String name,
      required final PresetCategory category,
      required final String checkpointModel,
      final String? vae,
      final String? upscaleModel,
      required final ImageSize latentImageSize,
      required final double cfgScale,
      required final int steps,
      required final String sampler,
      required final String scheduler,
      required final String defaultPositive,
      required final String defaultNegative,
      final bool isBuiltIn,
      required final DateTime createdAt,
      final DateTime? modifiedAt}) = _$ComfyUIModelPresetImpl;

  factory _ComfyUIModelPreset.fromJson(Map<String, dynamic> json) =
      _$ComfyUIModelPresetImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  PresetCategory get category;
  @override // Model Configuration
  String get checkpointModel;
  @override
  String? get vae;
  @override
  String? get upscaleModel;
  @override // Image Size
  ImageSize get latentImageSize;
  @override // Generation Parameters
  double get cfgScale;
  @override
  int get steps;
  @override
  String get sampler;
  @override
  String get scheduler;
  @override // Default Prompts
  String get defaultPositive;
  @override
  String get defaultNegative;
  @override // Metadata
  bool get isBuiltIn;
  @override
  DateTime get createdAt;
  @override
  DateTime? get modifiedAt;
  @override
  @JsonKey(ignore: true)
  _$$ComfyUIModelPresetImplCopyWith<_$ComfyUIModelPresetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
