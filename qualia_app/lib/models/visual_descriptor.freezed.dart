// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visual_descriptor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VisualDescriptor _$VisualDescriptorFromJson(Map<String, dynamic> json) {
  return _VisualDescriptor.fromJson(json);
}

/// @nodoc
mixin _$VisualDescriptor {
  String get description => throw _privateConstructorUsedError;
  String get sdxlTags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VisualDescriptorCopyWith<VisualDescriptor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisualDescriptorCopyWith<$Res> {
  factory $VisualDescriptorCopyWith(
          VisualDescriptor value, $Res Function(VisualDescriptor) then) =
      _$VisualDescriptorCopyWithImpl<$Res, VisualDescriptor>;
  @useResult
  $Res call({String description, String sdxlTags});
}

/// @nodoc
class _$VisualDescriptorCopyWithImpl<$Res, $Val extends VisualDescriptor>
    implements $VisualDescriptorCopyWith<$Res> {
  _$VisualDescriptorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? sdxlTags = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      sdxlTags: null == sdxlTags
          ? _value.sdxlTags
          : sdxlTags // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VisualDescriptorImplCopyWith<$Res>
    implements $VisualDescriptorCopyWith<$Res> {
  factory _$$VisualDescriptorImplCopyWith(_$VisualDescriptorImpl value,
          $Res Function(_$VisualDescriptorImpl) then) =
      __$$VisualDescriptorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, String sdxlTags});
}

/// @nodoc
class __$$VisualDescriptorImplCopyWithImpl<$Res>
    extends _$VisualDescriptorCopyWithImpl<$Res, _$VisualDescriptorImpl>
    implements _$$VisualDescriptorImplCopyWith<$Res> {
  __$$VisualDescriptorImplCopyWithImpl(_$VisualDescriptorImpl _value,
      $Res Function(_$VisualDescriptorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? sdxlTags = null,
  }) {
    return _then(_$VisualDescriptorImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      sdxlTags: null == sdxlTags
          ? _value.sdxlTags
          : sdxlTags // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VisualDescriptorImpl implements _VisualDescriptor {
  const _$VisualDescriptorImpl(
      {required this.description, required this.sdxlTags});

  factory _$VisualDescriptorImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisualDescriptorImplFromJson(json);

  @override
  final String description;
  @override
  final String sdxlTags;

  @override
  String toString() {
    return 'VisualDescriptor(description: $description, sdxlTags: $sdxlTags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisualDescriptorImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.sdxlTags, sdxlTags) ||
                other.sdxlTags == sdxlTags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description, sdxlTags);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VisualDescriptorImplCopyWith<_$VisualDescriptorImpl> get copyWith =>
      __$$VisualDescriptorImplCopyWithImpl<_$VisualDescriptorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisualDescriptorImplToJson(
      this,
    );
  }
}

abstract class _VisualDescriptor implements VisualDescriptor {
  const factory _VisualDescriptor(
      {required final String description,
      required final String sdxlTags}) = _$VisualDescriptorImpl;

  factory _VisualDescriptor.fromJson(Map<String, dynamic> json) =
      _$VisualDescriptorImpl.fromJson;

  @override
  String get description;
  @override
  String get sdxlTags;
  @override
  @JsonKey(ignore: true)
  _$$VisualDescriptorImplCopyWith<_$VisualDescriptorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
