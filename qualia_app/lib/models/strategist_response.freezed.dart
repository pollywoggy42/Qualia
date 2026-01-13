// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'strategist_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StrategistResponse _$StrategistResponseFromJson(Map<String, dynamic> json) {
  return _StrategistResponse.fromJson(json);
}

/// @nodoc
mixin _$StrategistResponse {
  List<StrategyChoice> get choices => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StrategistResponseCopyWith<StrategistResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StrategistResponseCopyWith<$Res> {
  factory $StrategistResponseCopyWith(
          StrategistResponse value, $Res Function(StrategistResponse) then) =
      _$StrategistResponseCopyWithImpl<$Res, StrategistResponse>;
  @useResult
  $Res call({List<StrategyChoice> choices});
}

/// @nodoc
class _$StrategistResponseCopyWithImpl<$Res, $Val extends StrategistResponse>
    implements $StrategistResponseCopyWith<$Res> {
  _$StrategistResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? choices = null,
  }) {
    return _then(_value.copyWith(
      choices: null == choices
          ? _value.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<StrategyChoice>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StrategistResponseImplCopyWith<$Res>
    implements $StrategistResponseCopyWith<$Res> {
  factory _$$StrategistResponseImplCopyWith(_$StrategistResponseImpl value,
          $Res Function(_$StrategistResponseImpl) then) =
      __$$StrategistResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<StrategyChoice> choices});
}

/// @nodoc
class __$$StrategistResponseImplCopyWithImpl<$Res>
    extends _$StrategistResponseCopyWithImpl<$Res, _$StrategistResponseImpl>
    implements _$$StrategistResponseImplCopyWith<$Res> {
  __$$StrategistResponseImplCopyWithImpl(_$StrategistResponseImpl _value,
      $Res Function(_$StrategistResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? choices = null,
  }) {
    return _then(_$StrategistResponseImpl(
      choices: null == choices
          ? _value._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<StrategyChoice>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StrategistResponseImpl implements _StrategistResponse {
  const _$StrategistResponseImpl({required final List<StrategyChoice> choices})
      : _choices = choices;

  factory _$StrategistResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StrategistResponseImplFromJson(json);

  final List<StrategyChoice> _choices;
  @override
  List<StrategyChoice> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  @override
  String toString() {
    return 'StrategistResponse(choices: $choices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StrategistResponseImpl &&
            const DeepCollectionEquality().equals(other._choices, _choices));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_choices));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StrategistResponseImplCopyWith<_$StrategistResponseImpl> get copyWith =>
      __$$StrategistResponseImplCopyWithImpl<_$StrategistResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StrategistResponseImplToJson(
      this,
    );
  }
}

abstract class _StrategistResponse implements StrategistResponse {
  const factory _StrategistResponse(
      {required final List<StrategyChoice> choices}) = _$StrategistResponseImpl;

  factory _StrategistResponse.fromJson(Map<String, dynamic> json) =
      _$StrategistResponseImpl.fromJson;

  @override
  List<StrategyChoice> get choices;
  @override
  @JsonKey(ignore: true)
  _$$StrategistResponseImplCopyWith<_$StrategistResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StrategyChoice _$StrategyChoiceFromJson(Map<String, dynamic> json) {
  return _StrategyChoice.fromJson(json);
}

/// @nodoc
mixin _$StrategyChoice {
  String? get id => throw _privateConstructorUsedError; // Generated if null
  String? get action => throw _privateConstructorUsedError;
  String? get speech => throw _privateConstructorUsedError;
  String? get sdxlTags => throw _privateConstructorUsedError;
  int get successRate => throw _privateConstructorUsedError;
  String? get reasoning => throw _privateConstructorUsedError;
  bool get isSpecial => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StrategyChoiceCopyWith<StrategyChoice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StrategyChoiceCopyWith<$Res> {
  factory $StrategyChoiceCopyWith(
          StrategyChoice value, $Res Function(StrategyChoice) then) =
      _$StrategyChoiceCopyWithImpl<$Res, StrategyChoice>;
  @useResult
  $Res call(
      {String? id,
      String? action,
      String? speech,
      String? sdxlTags,
      int successRate,
      String? reasoning,
      bool isSpecial});
}

/// @nodoc
class _$StrategyChoiceCopyWithImpl<$Res, $Val extends StrategyChoice>
    implements $StrategyChoiceCopyWith<$Res> {
  _$StrategyChoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? action = freezed,
    Object? speech = freezed,
    Object? sdxlTags = freezed,
    Object? successRate = null,
    Object? reasoning = freezed,
    Object? isSpecial = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      action: freezed == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String?,
      speech: freezed == speech
          ? _value.speech
          : speech // ignore: cast_nullable_to_non_nullable
              as String?,
      sdxlTags: freezed == sdxlTags
          ? _value.sdxlTags
          : sdxlTags // ignore: cast_nullable_to_non_nullable
              as String?,
      successRate: null == successRate
          ? _value.successRate
          : successRate // ignore: cast_nullable_to_non_nullable
              as int,
      reasoning: freezed == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String?,
      isSpecial: null == isSpecial
          ? _value.isSpecial
          : isSpecial // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StrategyChoiceImplCopyWith<$Res>
    implements $StrategyChoiceCopyWith<$Res> {
  factory _$$StrategyChoiceImplCopyWith(_$StrategyChoiceImpl value,
          $Res Function(_$StrategyChoiceImpl) then) =
      __$$StrategyChoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? action,
      String? speech,
      String? sdxlTags,
      int successRate,
      String? reasoning,
      bool isSpecial});
}

/// @nodoc
class __$$StrategyChoiceImplCopyWithImpl<$Res>
    extends _$StrategyChoiceCopyWithImpl<$Res, _$StrategyChoiceImpl>
    implements _$$StrategyChoiceImplCopyWith<$Res> {
  __$$StrategyChoiceImplCopyWithImpl(
      _$StrategyChoiceImpl _value, $Res Function(_$StrategyChoiceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? action = freezed,
    Object? speech = freezed,
    Object? sdxlTags = freezed,
    Object? successRate = null,
    Object? reasoning = freezed,
    Object? isSpecial = null,
  }) {
    return _then(_$StrategyChoiceImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      action: freezed == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String?,
      speech: freezed == speech
          ? _value.speech
          : speech // ignore: cast_nullable_to_non_nullable
              as String?,
      sdxlTags: freezed == sdxlTags
          ? _value.sdxlTags
          : sdxlTags // ignore: cast_nullable_to_non_nullable
              as String?,
      successRate: null == successRate
          ? _value.successRate
          : successRate // ignore: cast_nullable_to_non_nullable
              as int,
      reasoning: freezed == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String?,
      isSpecial: null == isSpecial
          ? _value.isSpecial
          : isSpecial // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StrategyChoiceImpl implements _StrategyChoice {
  const _$StrategyChoiceImpl(
      {this.id,
      this.action,
      this.speech,
      this.sdxlTags,
      this.successRate = 0,
      this.reasoning,
      this.isSpecial = false});

  factory _$StrategyChoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$StrategyChoiceImplFromJson(json);

  @override
  final String? id;
// Generated if null
  @override
  final String? action;
  @override
  final String? speech;
  @override
  final String? sdxlTags;
  @override
  @JsonKey()
  final int successRate;
  @override
  final String? reasoning;
  @override
  @JsonKey()
  final bool isSpecial;

  @override
  String toString() {
    return 'StrategyChoice(id: $id, action: $action, speech: $speech, sdxlTags: $sdxlTags, successRate: $successRate, reasoning: $reasoning, isSpecial: $isSpecial)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StrategyChoiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.speech, speech) || other.speech == speech) &&
            (identical(other.sdxlTags, sdxlTags) ||
                other.sdxlTags == sdxlTags) &&
            (identical(other.successRate, successRate) ||
                other.successRate == successRate) &&
            (identical(other.reasoning, reasoning) ||
                other.reasoning == reasoning) &&
            (identical(other.isSpecial, isSpecial) ||
                other.isSpecial == isSpecial));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, action, speech, sdxlTags,
      successRate, reasoning, isSpecial);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StrategyChoiceImplCopyWith<_$StrategyChoiceImpl> get copyWith =>
      __$$StrategyChoiceImplCopyWithImpl<_$StrategyChoiceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StrategyChoiceImplToJson(
      this,
    );
  }
}

abstract class _StrategyChoice implements StrategyChoice {
  const factory _StrategyChoice(
      {final String? id,
      final String? action,
      final String? speech,
      final String? sdxlTags,
      final int successRate,
      final String? reasoning,
      final bool isSpecial}) = _$StrategyChoiceImpl;

  factory _StrategyChoice.fromJson(Map<String, dynamic> json) =
      _$StrategyChoiceImpl.fromJson;

  @override
  String? get id;
  @override // Generated if null
  String? get action;
  @override
  String? get speech;
  @override
  String? get sdxlTags;
  @override
  int get successRate;
  @override
  String? get reasoning;
  @override
  bool get isSpecial;
  @override
  @JsonKey(ignore: true)
  _$$StrategyChoiceImplCopyWith<_$StrategyChoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
