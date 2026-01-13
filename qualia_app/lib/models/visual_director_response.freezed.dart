// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visual_director_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VisualDirectorResponse _$VisualDirectorResponseFromJson(
    Map<String, dynamic> json) {
  return _VisualDirectorResponse.fromJson(json);
}

/// @nodoc
mixin _$VisualDirectorResponse {
  List<String> get positiveTags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VisualDirectorResponseCopyWith<VisualDirectorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisualDirectorResponseCopyWith<$Res> {
  factory $VisualDirectorResponseCopyWith(VisualDirectorResponse value,
          $Res Function(VisualDirectorResponse) then) =
      _$VisualDirectorResponseCopyWithImpl<$Res, VisualDirectorResponse>;
  @useResult
  $Res call({List<String> positiveTags});
}

/// @nodoc
class _$VisualDirectorResponseCopyWithImpl<$Res,
        $Val extends VisualDirectorResponse>
    implements $VisualDirectorResponseCopyWith<$Res> {
  _$VisualDirectorResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? positiveTags = null,
  }) {
    return _then(_value.copyWith(
      positiveTags: null == positiveTags
          ? _value.positiveTags
          : positiveTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VisualDirectorResponseImplCopyWith<$Res>
    implements $VisualDirectorResponseCopyWith<$Res> {
  factory _$$VisualDirectorResponseImplCopyWith(
          _$VisualDirectorResponseImpl value,
          $Res Function(_$VisualDirectorResponseImpl) then) =
      __$$VisualDirectorResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> positiveTags});
}

/// @nodoc
class __$$VisualDirectorResponseImplCopyWithImpl<$Res>
    extends _$VisualDirectorResponseCopyWithImpl<$Res,
        _$VisualDirectorResponseImpl>
    implements _$$VisualDirectorResponseImplCopyWith<$Res> {
  __$$VisualDirectorResponseImplCopyWithImpl(
      _$VisualDirectorResponseImpl _value,
      $Res Function(_$VisualDirectorResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? positiveTags = null,
  }) {
    return _then(_$VisualDirectorResponseImpl(
      positiveTags: null == positiveTags
          ? _value._positiveTags
          : positiveTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VisualDirectorResponseImpl implements _VisualDirectorResponse {
  const _$VisualDirectorResponseImpl({required final List<String> positiveTags})
      : _positiveTags = positiveTags;

  factory _$VisualDirectorResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisualDirectorResponseImplFromJson(json);

  final List<String> _positiveTags;
  @override
  List<String> get positiveTags {
    if (_positiveTags is EqualUnmodifiableListView) return _positiveTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_positiveTags);
  }

  @override
  String toString() {
    return 'VisualDirectorResponse(positiveTags: $positiveTags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisualDirectorResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._positiveTags, _positiveTags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_positiveTags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VisualDirectorResponseImplCopyWith<_$VisualDirectorResponseImpl>
      get copyWith => __$$VisualDirectorResponseImplCopyWithImpl<
          _$VisualDirectorResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisualDirectorResponseImplToJson(
      this,
    );
  }
}

abstract class _VisualDirectorResponse implements VisualDirectorResponse {
  const factory _VisualDirectorResponse(
          {required final List<String> positiveTags}) =
      _$VisualDirectorResponseImpl;

  factory _VisualDirectorResponse.fromJson(Map<String, dynamic> json) =
      _$VisualDirectorResponseImpl.fromJson;

  @override
  List<String> get positiveTags;
  @override
  @JsonKey(ignore: true)
  _$$VisualDirectorResponseImplCopyWith<_$VisualDirectorResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
