// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_emotional_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartnerEmotionalState _$PartnerEmotionalStateFromJson(
    Map<String, dynamic> json) {
  return _PartnerEmotionalState.fromJson(json);
}

/// @nodoc
mixin _$PartnerEmotionalState {
  /// 호감도 (0-100), 관계 진전도 - 느린 변화
  int get affection => throw _privateConstructorUsedError;

  /// 신뢰도 (0-100), 대화 깊이 및 비밀 공유 - 느린 변화
  int get trust => throw _privateConstructorUsedError;

  /// 성적 흥분도 (0-100), NSFW 상황 트리거 - 빠른 변화
  int get arousal => throw _privateConstructorUsedError;

  /// 성욕 (0-100), 매우 높으면 이성을 잃고 NSFW 허용 - 빠른 변화
  int get lust => throw _privateConstructorUsedError;

  /// S/M 성향 (-100 ~ +100), 음수: Submissive, 양수: Dominant, 0: Switch
  int get dominance => throw _privateConstructorUsedError;

  /// 현재 감정 (예: "Happy", "Anxious", "Horny", "Jealous")
  String get mood => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PartnerEmotionalStateCopyWith<PartnerEmotionalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerEmotionalStateCopyWith<$Res> {
  factory $PartnerEmotionalStateCopyWith(PartnerEmotionalState value,
          $Res Function(PartnerEmotionalState) then) =
      _$PartnerEmotionalStateCopyWithImpl<$Res, PartnerEmotionalState>;
  @useResult
  $Res call(
      {int affection,
      int trust,
      int arousal,
      int lust,
      int dominance,
      String mood});
}

/// @nodoc
class _$PartnerEmotionalStateCopyWithImpl<$Res,
        $Val extends PartnerEmotionalState>
    implements $PartnerEmotionalStateCopyWith<$Res> {
  _$PartnerEmotionalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? affection = null,
    Object? trust = null,
    Object? arousal = null,
    Object? lust = null,
    Object? dominance = null,
    Object? mood = null,
  }) {
    return _then(_value.copyWith(
      affection: null == affection
          ? _value.affection
          : affection // ignore: cast_nullable_to_non_nullable
              as int,
      trust: null == trust
          ? _value.trust
          : trust // ignore: cast_nullable_to_non_nullable
              as int,
      arousal: null == arousal
          ? _value.arousal
          : arousal // ignore: cast_nullable_to_non_nullable
              as int,
      lust: null == lust
          ? _value.lust
          : lust // ignore: cast_nullable_to_non_nullable
              as int,
      dominance: null == dominance
          ? _value.dominance
          : dominance // ignore: cast_nullable_to_non_nullable
              as int,
      mood: null == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartnerEmotionalStateImplCopyWith<$Res>
    implements $PartnerEmotionalStateCopyWith<$Res> {
  factory _$$PartnerEmotionalStateImplCopyWith(
          _$PartnerEmotionalStateImpl value,
          $Res Function(_$PartnerEmotionalStateImpl) then) =
      __$$PartnerEmotionalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int affection,
      int trust,
      int arousal,
      int lust,
      int dominance,
      String mood});
}

/// @nodoc
class __$$PartnerEmotionalStateImplCopyWithImpl<$Res>
    extends _$PartnerEmotionalStateCopyWithImpl<$Res,
        _$PartnerEmotionalStateImpl>
    implements _$$PartnerEmotionalStateImplCopyWith<$Res> {
  __$$PartnerEmotionalStateImplCopyWithImpl(_$PartnerEmotionalStateImpl _value,
      $Res Function(_$PartnerEmotionalStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? affection = null,
    Object? trust = null,
    Object? arousal = null,
    Object? lust = null,
    Object? dominance = null,
    Object? mood = null,
  }) {
    return _then(_$PartnerEmotionalStateImpl(
      affection: null == affection
          ? _value.affection
          : affection // ignore: cast_nullable_to_non_nullable
              as int,
      trust: null == trust
          ? _value.trust
          : trust // ignore: cast_nullable_to_non_nullable
              as int,
      arousal: null == arousal
          ? _value.arousal
          : arousal // ignore: cast_nullable_to_non_nullable
              as int,
      lust: null == lust
          ? _value.lust
          : lust // ignore: cast_nullable_to_non_nullable
              as int,
      dominance: null == dominance
          ? _value.dominance
          : dominance // ignore: cast_nullable_to_non_nullable
              as int,
      mood: null == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerEmotionalStateImpl implements _PartnerEmotionalState {
  const _$PartnerEmotionalStateImpl(
      {this.affection = 50,
      this.trust = 50,
      this.arousal = 0,
      this.lust = 0,
      this.dominance = 0,
      this.mood = 'Neutral'});

  factory _$PartnerEmotionalStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerEmotionalStateImplFromJson(json);

  /// 호감도 (0-100), 관계 진전도 - 느린 변화
  @override
  @JsonKey()
  final int affection;

  /// 신뢰도 (0-100), 대화 깊이 및 비밀 공유 - 느린 변화
  @override
  @JsonKey()
  final int trust;

  /// 성적 흥분도 (0-100), NSFW 상황 트리거 - 빠른 변화
  @override
  @JsonKey()
  final int arousal;

  /// 성욕 (0-100), 매우 높으면 이성을 잃고 NSFW 허용 - 빠른 변화
  @override
  @JsonKey()
  final int lust;

  /// S/M 성향 (-100 ~ +100), 음수: Submissive, 양수: Dominant, 0: Switch
  @override
  @JsonKey()
  final int dominance;

  /// 현재 감정 (예: "Happy", "Anxious", "Horny", "Jealous")
  @override
  @JsonKey()
  final String mood;

  @override
  String toString() {
    return 'PartnerEmotionalState(affection: $affection, trust: $trust, arousal: $arousal, lust: $lust, dominance: $dominance, mood: $mood)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerEmotionalStateImpl &&
            (identical(other.affection, affection) ||
                other.affection == affection) &&
            (identical(other.trust, trust) || other.trust == trust) &&
            (identical(other.arousal, arousal) || other.arousal == arousal) &&
            (identical(other.lust, lust) || other.lust == lust) &&
            (identical(other.dominance, dominance) ||
                other.dominance == dominance) &&
            (identical(other.mood, mood) || other.mood == mood));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, affection, trust, arousal, lust, dominance, mood);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerEmotionalStateImplCopyWith<_$PartnerEmotionalStateImpl>
      get copyWith => __$$PartnerEmotionalStateImplCopyWithImpl<
          _$PartnerEmotionalStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerEmotionalStateImplToJson(
      this,
    );
  }
}

abstract class _PartnerEmotionalState implements PartnerEmotionalState {
  const factory _PartnerEmotionalState(
      {final int affection,
      final int trust,
      final int arousal,
      final int lust,
      final int dominance,
      final String mood}) = _$PartnerEmotionalStateImpl;

  factory _PartnerEmotionalState.fromJson(Map<String, dynamic> json) =
      _$PartnerEmotionalStateImpl.fromJson;

  @override

  /// 호감도 (0-100), 관계 진전도 - 느린 변화
  int get affection;
  @override

  /// 신뢰도 (0-100), 대화 깊이 및 비밀 공유 - 느린 변화
  int get trust;
  @override

  /// 성적 흥분도 (0-100), NSFW 상황 트리거 - 빠른 변화
  int get arousal;
  @override

  /// 성욕 (0-100), 매우 높으면 이성을 잃고 NSFW 허용 - 빠른 변화
  int get lust;
  @override

  /// S/M 성향 (-100 ~ +100), 음수: Submissive, 양수: Dominant, 0: Switch
  int get dominance;
  @override

  /// 현재 감정 (예: "Happy", "Anxious", "Horny", "Jealous")
  String get mood;
  @override
  @JsonKey(ignore: true)
  _$$PartnerEmotionalStateImplCopyWith<_$PartnerEmotionalStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
