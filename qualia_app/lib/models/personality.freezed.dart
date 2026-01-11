// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personality.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Personality _$PersonalityFromJson(Map<String, dynamic> json) {
  return _Personality.fromJson(json);
}

/// @nodoc
mixin _$Personality {
  String get mbti => throw _privateConstructorUsedError;
  String get speechStyle => throw _privateConstructorUsedError;
  List<String> get traits => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PersonalityCopyWith<Personality> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalityCopyWith<$Res> {
  factory $PersonalityCopyWith(
          Personality value, $Res Function(Personality) then) =
      _$PersonalityCopyWithImpl<$Res, Personality>;
  @useResult
  $Res call({String mbti, String speechStyle, List<String> traits});
}

/// @nodoc
class _$PersonalityCopyWithImpl<$Res, $Val extends Personality>
    implements $PersonalityCopyWith<$Res> {
  _$PersonalityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mbti = null,
    Object? speechStyle = null,
    Object? traits = null,
  }) {
    return _then(_value.copyWith(
      mbti: null == mbti
          ? _value.mbti
          : mbti // ignore: cast_nullable_to_non_nullable
              as String,
      speechStyle: null == speechStyle
          ? _value.speechStyle
          : speechStyle // ignore: cast_nullable_to_non_nullable
              as String,
      traits: null == traits
          ? _value.traits
          : traits // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonalityImplCopyWith<$Res>
    implements $PersonalityCopyWith<$Res> {
  factory _$$PersonalityImplCopyWith(
          _$PersonalityImpl value, $Res Function(_$PersonalityImpl) then) =
      __$$PersonalityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String mbti, String speechStyle, List<String> traits});
}

/// @nodoc
class __$$PersonalityImplCopyWithImpl<$Res>
    extends _$PersonalityCopyWithImpl<$Res, _$PersonalityImpl>
    implements _$$PersonalityImplCopyWith<$Res> {
  __$$PersonalityImplCopyWithImpl(
      _$PersonalityImpl _value, $Res Function(_$PersonalityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mbti = null,
    Object? speechStyle = null,
    Object? traits = null,
  }) {
    return _then(_$PersonalityImpl(
      mbti: null == mbti
          ? _value.mbti
          : mbti // ignore: cast_nullable_to_non_nullable
              as String,
      speechStyle: null == speechStyle
          ? _value.speechStyle
          : speechStyle // ignore: cast_nullable_to_non_nullable
              as String,
      traits: null == traits
          ? _value._traits
          : traits // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalityImpl implements _Personality {
  const _$PersonalityImpl(
      {required this.mbti,
      required this.speechStyle,
      required final List<String> traits})
      : _traits = traits;

  factory _$PersonalityImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonalityImplFromJson(json);

  @override
  final String mbti;
  @override
  final String speechStyle;
  final List<String> _traits;
  @override
  List<String> get traits {
    if (_traits is EqualUnmodifiableListView) return _traits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_traits);
  }

  @override
  String toString() {
    return 'Personality(mbti: $mbti, speechStyle: $speechStyle, traits: $traits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalityImpl &&
            (identical(other.mbti, mbti) || other.mbti == mbti) &&
            (identical(other.speechStyle, speechStyle) ||
                other.speechStyle == speechStyle) &&
            const DeepCollectionEquality().equals(other._traits, _traits));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, mbti, speechStyle,
      const DeepCollectionEquality().hash(_traits));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalityImplCopyWith<_$PersonalityImpl> get copyWith =>
      __$$PersonalityImplCopyWithImpl<_$PersonalityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonalityImplToJson(
      this,
    );
  }
}

abstract class _Personality implements Personality {
  const factory _Personality(
      {required final String mbti,
      required final String speechStyle,
      required final List<String> traits}) = _$PersonalityImpl;

  factory _Personality.fromJson(Map<String, dynamic> json) =
      _$PersonalityImpl.fromJson;

  @override
  String get mbti;
  @override
  String get speechStyle;
  @override
  List<String> get traits;
  @override
  @JsonKey(ignore: true)
  _$$PersonalityImplCopyWith<_$PersonalityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
