// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scene_transition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SceneTransition _$SceneTransitionFromJson(Map<String, dynamic> json) {
  return _SceneTransition.fromJson(json);
}

/// @nodoc
mixin _$SceneTransition {
  /// 전환 유형 ("time_skip", "location_change", "next_day")
  String get transitionType => throw _privateConstructorUsedError;

  /// 전환 서술
  String get narration => throw _privateConstructorUsedError; // 세계 상태 변경
  DateTime? get newTime => throw _privateConstructorUsedError;
  String? get newWeather => throw _privateConstructorUsedError;
  String? get newUserLocation => throw _privateConstructorUsedError;
  String? get newPartnerLocation =>
      throw _privateConstructorUsedError; // Partner 상태 조정
  PartnerStateAdjustment? get partnerAdjustment =>
      throw _privateConstructorUsedError; // 효과 정리
  List<String> get effectsToRemove => throw _privateConstructorUsedError;
  bool get clearAllEffects => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SceneTransitionCopyWith<SceneTransition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SceneTransitionCopyWith<$Res> {
  factory $SceneTransitionCopyWith(
          SceneTransition value, $Res Function(SceneTransition) then) =
      _$SceneTransitionCopyWithImpl<$Res, SceneTransition>;
  @useResult
  $Res call(
      {String transitionType,
      String narration,
      DateTime? newTime,
      String? newWeather,
      String? newUserLocation,
      String? newPartnerLocation,
      PartnerStateAdjustment? partnerAdjustment,
      List<String> effectsToRemove,
      bool clearAllEffects});

  $PartnerStateAdjustmentCopyWith<$Res>? get partnerAdjustment;
}

/// @nodoc
class _$SceneTransitionCopyWithImpl<$Res, $Val extends SceneTransition>
    implements $SceneTransitionCopyWith<$Res> {
  _$SceneTransitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transitionType = null,
    Object? narration = null,
    Object? newTime = freezed,
    Object? newWeather = freezed,
    Object? newUserLocation = freezed,
    Object? newPartnerLocation = freezed,
    Object? partnerAdjustment = freezed,
    Object? effectsToRemove = null,
    Object? clearAllEffects = null,
  }) {
    return _then(_value.copyWith(
      transitionType: null == transitionType
          ? _value.transitionType
          : transitionType // ignore: cast_nullable_to_non_nullable
              as String,
      narration: null == narration
          ? _value.narration
          : narration // ignore: cast_nullable_to_non_nullable
              as String,
      newTime: freezed == newTime
          ? _value.newTime
          : newTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      newWeather: freezed == newWeather
          ? _value.newWeather
          : newWeather // ignore: cast_nullable_to_non_nullable
              as String?,
      newUserLocation: freezed == newUserLocation
          ? _value.newUserLocation
          : newUserLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      newPartnerLocation: freezed == newPartnerLocation
          ? _value.newPartnerLocation
          : newPartnerLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      partnerAdjustment: freezed == partnerAdjustment
          ? _value.partnerAdjustment
          : partnerAdjustment // ignore: cast_nullable_to_non_nullable
              as PartnerStateAdjustment?,
      effectsToRemove: null == effectsToRemove
          ? _value.effectsToRemove
          : effectsToRemove // ignore: cast_nullable_to_non_nullable
              as List<String>,
      clearAllEffects: null == clearAllEffects
          ? _value.clearAllEffects
          : clearAllEffects // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PartnerStateAdjustmentCopyWith<$Res>? get partnerAdjustment {
    if (_value.partnerAdjustment == null) {
      return null;
    }

    return $PartnerStateAdjustmentCopyWith<$Res>(_value.partnerAdjustment!,
        (value) {
      return _then(_value.copyWith(partnerAdjustment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SceneTransitionImplCopyWith<$Res>
    implements $SceneTransitionCopyWith<$Res> {
  factory _$$SceneTransitionImplCopyWith(_$SceneTransitionImpl value,
          $Res Function(_$SceneTransitionImpl) then) =
      __$$SceneTransitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String transitionType,
      String narration,
      DateTime? newTime,
      String? newWeather,
      String? newUserLocation,
      String? newPartnerLocation,
      PartnerStateAdjustment? partnerAdjustment,
      List<String> effectsToRemove,
      bool clearAllEffects});

  @override
  $PartnerStateAdjustmentCopyWith<$Res>? get partnerAdjustment;
}

/// @nodoc
class __$$SceneTransitionImplCopyWithImpl<$Res>
    extends _$SceneTransitionCopyWithImpl<$Res, _$SceneTransitionImpl>
    implements _$$SceneTransitionImplCopyWith<$Res> {
  __$$SceneTransitionImplCopyWithImpl(
      _$SceneTransitionImpl _value, $Res Function(_$SceneTransitionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transitionType = null,
    Object? narration = null,
    Object? newTime = freezed,
    Object? newWeather = freezed,
    Object? newUserLocation = freezed,
    Object? newPartnerLocation = freezed,
    Object? partnerAdjustment = freezed,
    Object? effectsToRemove = null,
    Object? clearAllEffects = null,
  }) {
    return _then(_$SceneTransitionImpl(
      transitionType: null == transitionType
          ? _value.transitionType
          : transitionType // ignore: cast_nullable_to_non_nullable
              as String,
      narration: null == narration
          ? _value.narration
          : narration // ignore: cast_nullable_to_non_nullable
              as String,
      newTime: freezed == newTime
          ? _value.newTime
          : newTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      newWeather: freezed == newWeather
          ? _value.newWeather
          : newWeather // ignore: cast_nullable_to_non_nullable
              as String?,
      newUserLocation: freezed == newUserLocation
          ? _value.newUserLocation
          : newUserLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      newPartnerLocation: freezed == newPartnerLocation
          ? _value.newPartnerLocation
          : newPartnerLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      partnerAdjustment: freezed == partnerAdjustment
          ? _value.partnerAdjustment
          : partnerAdjustment // ignore: cast_nullable_to_non_nullable
              as PartnerStateAdjustment?,
      effectsToRemove: null == effectsToRemove
          ? _value._effectsToRemove
          : effectsToRemove // ignore: cast_nullable_to_non_nullable
              as List<String>,
      clearAllEffects: null == clearAllEffects
          ? _value.clearAllEffects
          : clearAllEffects // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SceneTransitionImpl implements _SceneTransition {
  const _$SceneTransitionImpl(
      {required this.transitionType,
      required this.narration,
      this.newTime,
      this.newWeather,
      this.newUserLocation,
      this.newPartnerLocation,
      this.partnerAdjustment,
      final List<String> effectsToRemove = const [],
      this.clearAllEffects = false})
      : _effectsToRemove = effectsToRemove;

  factory _$SceneTransitionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SceneTransitionImplFromJson(json);

  /// 전환 유형 ("time_skip", "location_change", "next_day")
  @override
  final String transitionType;

  /// 전환 서술
  @override
  final String narration;
// 세계 상태 변경
  @override
  final DateTime? newTime;
  @override
  final String? newWeather;
  @override
  final String? newUserLocation;
  @override
  final String? newPartnerLocation;
// Partner 상태 조정
  @override
  final PartnerStateAdjustment? partnerAdjustment;
// 효과 정리
  final List<String> _effectsToRemove;
// 효과 정리
  @override
  @JsonKey()
  List<String> get effectsToRemove {
    if (_effectsToRemove is EqualUnmodifiableListView) return _effectsToRemove;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_effectsToRemove);
  }

  @override
  @JsonKey()
  final bool clearAllEffects;

  @override
  String toString() {
    return 'SceneTransition(transitionType: $transitionType, narration: $narration, newTime: $newTime, newWeather: $newWeather, newUserLocation: $newUserLocation, newPartnerLocation: $newPartnerLocation, partnerAdjustment: $partnerAdjustment, effectsToRemove: $effectsToRemove, clearAllEffects: $clearAllEffects)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SceneTransitionImpl &&
            (identical(other.transitionType, transitionType) ||
                other.transitionType == transitionType) &&
            (identical(other.narration, narration) ||
                other.narration == narration) &&
            (identical(other.newTime, newTime) || other.newTime == newTime) &&
            (identical(other.newWeather, newWeather) ||
                other.newWeather == newWeather) &&
            (identical(other.newUserLocation, newUserLocation) ||
                other.newUserLocation == newUserLocation) &&
            (identical(other.newPartnerLocation, newPartnerLocation) ||
                other.newPartnerLocation == newPartnerLocation) &&
            (identical(other.partnerAdjustment, partnerAdjustment) ||
                other.partnerAdjustment == partnerAdjustment) &&
            const DeepCollectionEquality()
                .equals(other._effectsToRemove, _effectsToRemove) &&
            (identical(other.clearAllEffects, clearAllEffects) ||
                other.clearAllEffects == clearAllEffects));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      transitionType,
      narration,
      newTime,
      newWeather,
      newUserLocation,
      newPartnerLocation,
      partnerAdjustment,
      const DeepCollectionEquality().hash(_effectsToRemove),
      clearAllEffects);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SceneTransitionImplCopyWith<_$SceneTransitionImpl> get copyWith =>
      __$$SceneTransitionImplCopyWithImpl<_$SceneTransitionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SceneTransitionImplToJson(
      this,
    );
  }
}

abstract class _SceneTransition implements SceneTransition {
  const factory _SceneTransition(
      {required final String transitionType,
      required final String narration,
      final DateTime? newTime,
      final String? newWeather,
      final String? newUserLocation,
      final String? newPartnerLocation,
      final PartnerStateAdjustment? partnerAdjustment,
      final List<String> effectsToRemove,
      final bool clearAllEffects}) = _$SceneTransitionImpl;

  factory _SceneTransition.fromJson(Map<String, dynamic> json) =
      _$SceneTransitionImpl.fromJson;

  @override

  /// 전환 유형 ("time_skip", "location_change", "next_day")
  String get transitionType;
  @override

  /// 전환 서술
  String get narration;
  @override // 세계 상태 변경
  DateTime? get newTime;
  @override
  String? get newWeather;
  @override
  String? get newUserLocation;
  @override
  String? get newPartnerLocation;
  @override // Partner 상태 조정
  PartnerStateAdjustment? get partnerAdjustment;
  @override // 효과 정리
  List<String> get effectsToRemove;
  @override
  bool get clearAllEffects;
  @override
  @JsonKey(ignore: true)
  _$$SceneTransitionImplCopyWith<_$SceneTransitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PartnerStateAdjustment _$PartnerStateAdjustmentFromJson(
    Map<String, dynamic> json) {
  return _PartnerStateAdjustment.fromJson(json);
}

/// @nodoc
mixin _$PartnerStateAdjustment {
// 감정 수치 조정 (delta 값)
  int? get affectionDelta => throw _privateConstructorUsedError;
  int? get trustDelta => throw _privateConstructorUsedError;
  int? get arousalDelta => throw _privateConstructorUsedError;
  int? get lustDelta => throw _privateConstructorUsedError;
  int? get dominanceDelta => throw _privateConstructorUsedError; // 상태 변경
  String? get newMood => throw _privateConstructorUsedError;
  String? get newOutfit => throw _privateConstructorUsedError; // 메모리 추가
  String? get memoryToAdd => throw _privateConstructorUsedError; // 트라우마 추가
  String? get traumaToAdd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PartnerStateAdjustmentCopyWith<PartnerStateAdjustment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerStateAdjustmentCopyWith<$Res> {
  factory $PartnerStateAdjustmentCopyWith(PartnerStateAdjustment value,
          $Res Function(PartnerStateAdjustment) then) =
      _$PartnerStateAdjustmentCopyWithImpl<$Res, PartnerStateAdjustment>;
  @useResult
  $Res call(
      {int? affectionDelta,
      int? trustDelta,
      int? arousalDelta,
      int? lustDelta,
      int? dominanceDelta,
      String? newMood,
      String? newOutfit,
      String? memoryToAdd,
      String? traumaToAdd});
}

/// @nodoc
class _$PartnerStateAdjustmentCopyWithImpl<$Res,
        $Val extends PartnerStateAdjustment>
    implements $PartnerStateAdjustmentCopyWith<$Res> {
  _$PartnerStateAdjustmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? affectionDelta = freezed,
    Object? trustDelta = freezed,
    Object? arousalDelta = freezed,
    Object? lustDelta = freezed,
    Object? dominanceDelta = freezed,
    Object? newMood = freezed,
    Object? newOutfit = freezed,
    Object? memoryToAdd = freezed,
    Object? traumaToAdd = freezed,
  }) {
    return _then(_value.copyWith(
      affectionDelta: freezed == affectionDelta
          ? _value.affectionDelta
          : affectionDelta // ignore: cast_nullable_to_non_nullable
              as int?,
      trustDelta: freezed == trustDelta
          ? _value.trustDelta
          : trustDelta // ignore: cast_nullable_to_non_nullable
              as int?,
      arousalDelta: freezed == arousalDelta
          ? _value.arousalDelta
          : arousalDelta // ignore: cast_nullable_to_non_nullable
              as int?,
      lustDelta: freezed == lustDelta
          ? _value.lustDelta
          : lustDelta // ignore: cast_nullable_to_non_nullable
              as int?,
      dominanceDelta: freezed == dominanceDelta
          ? _value.dominanceDelta
          : dominanceDelta // ignore: cast_nullable_to_non_nullable
              as int?,
      newMood: freezed == newMood
          ? _value.newMood
          : newMood // ignore: cast_nullable_to_non_nullable
              as String?,
      newOutfit: freezed == newOutfit
          ? _value.newOutfit
          : newOutfit // ignore: cast_nullable_to_non_nullable
              as String?,
      memoryToAdd: freezed == memoryToAdd
          ? _value.memoryToAdd
          : memoryToAdd // ignore: cast_nullable_to_non_nullable
              as String?,
      traumaToAdd: freezed == traumaToAdd
          ? _value.traumaToAdd
          : traumaToAdd // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartnerStateAdjustmentImplCopyWith<$Res>
    implements $PartnerStateAdjustmentCopyWith<$Res> {
  factory _$$PartnerStateAdjustmentImplCopyWith(
          _$PartnerStateAdjustmentImpl value,
          $Res Function(_$PartnerStateAdjustmentImpl) then) =
      __$$PartnerStateAdjustmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? affectionDelta,
      int? trustDelta,
      int? arousalDelta,
      int? lustDelta,
      int? dominanceDelta,
      String? newMood,
      String? newOutfit,
      String? memoryToAdd,
      String? traumaToAdd});
}

/// @nodoc
class __$$PartnerStateAdjustmentImplCopyWithImpl<$Res>
    extends _$PartnerStateAdjustmentCopyWithImpl<$Res,
        _$PartnerStateAdjustmentImpl>
    implements _$$PartnerStateAdjustmentImplCopyWith<$Res> {
  __$$PartnerStateAdjustmentImplCopyWithImpl(
      _$PartnerStateAdjustmentImpl _value,
      $Res Function(_$PartnerStateAdjustmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? affectionDelta = freezed,
    Object? trustDelta = freezed,
    Object? arousalDelta = freezed,
    Object? lustDelta = freezed,
    Object? dominanceDelta = freezed,
    Object? newMood = freezed,
    Object? newOutfit = freezed,
    Object? memoryToAdd = freezed,
    Object? traumaToAdd = freezed,
  }) {
    return _then(_$PartnerStateAdjustmentImpl(
      affectionDelta: freezed == affectionDelta
          ? _value.affectionDelta
          : affectionDelta // ignore: cast_nullable_to_non_nullable
              as int?,
      trustDelta: freezed == trustDelta
          ? _value.trustDelta
          : trustDelta // ignore: cast_nullable_to_non_nullable
              as int?,
      arousalDelta: freezed == arousalDelta
          ? _value.arousalDelta
          : arousalDelta // ignore: cast_nullable_to_non_nullable
              as int?,
      lustDelta: freezed == lustDelta
          ? _value.lustDelta
          : lustDelta // ignore: cast_nullable_to_non_nullable
              as int?,
      dominanceDelta: freezed == dominanceDelta
          ? _value.dominanceDelta
          : dominanceDelta // ignore: cast_nullable_to_non_nullable
              as int?,
      newMood: freezed == newMood
          ? _value.newMood
          : newMood // ignore: cast_nullable_to_non_nullable
              as String?,
      newOutfit: freezed == newOutfit
          ? _value.newOutfit
          : newOutfit // ignore: cast_nullable_to_non_nullable
              as String?,
      memoryToAdd: freezed == memoryToAdd
          ? _value.memoryToAdd
          : memoryToAdd // ignore: cast_nullable_to_non_nullable
              as String?,
      traumaToAdd: freezed == traumaToAdd
          ? _value.traumaToAdd
          : traumaToAdd // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerStateAdjustmentImpl implements _PartnerStateAdjustment {
  const _$PartnerStateAdjustmentImpl(
      {this.affectionDelta,
      this.trustDelta,
      this.arousalDelta,
      this.lustDelta,
      this.dominanceDelta,
      this.newMood,
      this.newOutfit,
      this.memoryToAdd,
      this.traumaToAdd});

  factory _$PartnerStateAdjustmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerStateAdjustmentImplFromJson(json);

// 감정 수치 조정 (delta 값)
  @override
  final int? affectionDelta;
  @override
  final int? trustDelta;
  @override
  final int? arousalDelta;
  @override
  final int? lustDelta;
  @override
  final int? dominanceDelta;
// 상태 변경
  @override
  final String? newMood;
  @override
  final String? newOutfit;
// 메모리 추가
  @override
  final String? memoryToAdd;
// 트라우마 추가
  @override
  final String? traumaToAdd;

  @override
  String toString() {
    return 'PartnerStateAdjustment(affectionDelta: $affectionDelta, trustDelta: $trustDelta, arousalDelta: $arousalDelta, lustDelta: $lustDelta, dominanceDelta: $dominanceDelta, newMood: $newMood, newOutfit: $newOutfit, memoryToAdd: $memoryToAdd, traumaToAdd: $traumaToAdd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerStateAdjustmentImpl &&
            (identical(other.affectionDelta, affectionDelta) ||
                other.affectionDelta == affectionDelta) &&
            (identical(other.trustDelta, trustDelta) ||
                other.trustDelta == trustDelta) &&
            (identical(other.arousalDelta, arousalDelta) ||
                other.arousalDelta == arousalDelta) &&
            (identical(other.lustDelta, lustDelta) ||
                other.lustDelta == lustDelta) &&
            (identical(other.dominanceDelta, dominanceDelta) ||
                other.dominanceDelta == dominanceDelta) &&
            (identical(other.newMood, newMood) || other.newMood == newMood) &&
            (identical(other.newOutfit, newOutfit) ||
                other.newOutfit == newOutfit) &&
            (identical(other.memoryToAdd, memoryToAdd) ||
                other.memoryToAdd == memoryToAdd) &&
            (identical(other.traumaToAdd, traumaToAdd) ||
                other.traumaToAdd == traumaToAdd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      affectionDelta,
      trustDelta,
      arousalDelta,
      lustDelta,
      dominanceDelta,
      newMood,
      newOutfit,
      memoryToAdd,
      traumaToAdd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerStateAdjustmentImplCopyWith<_$PartnerStateAdjustmentImpl>
      get copyWith => __$$PartnerStateAdjustmentImplCopyWithImpl<
          _$PartnerStateAdjustmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerStateAdjustmentImplToJson(
      this,
    );
  }
}

abstract class _PartnerStateAdjustment implements PartnerStateAdjustment {
  const factory _PartnerStateAdjustment(
      {final int? affectionDelta,
      final int? trustDelta,
      final int? arousalDelta,
      final int? lustDelta,
      final int? dominanceDelta,
      final String? newMood,
      final String? newOutfit,
      final String? memoryToAdd,
      final String? traumaToAdd}) = _$PartnerStateAdjustmentImpl;

  factory _PartnerStateAdjustment.fromJson(Map<String, dynamic> json) =
      _$PartnerStateAdjustmentImpl.fromJson;

  @override // 감정 수치 조정 (delta 값)
  int? get affectionDelta;
  @override
  int? get trustDelta;
  @override
  int? get arousalDelta;
  @override
  int? get lustDelta;
  @override
  int? get dominanceDelta;
  @override // 상태 변경
  String? get newMood;
  @override
  String? get newOutfit;
  @override // 메모리 추가
  String? get memoryToAdd;
  @override // 트라우마 추가
  String? get traumaToAdd;
  @override
  @JsonKey(ignore: true)
  _$$PartnerStateAdjustmentImplCopyWith<_$PartnerStateAdjustmentImpl>
      get copyWith => throw _privateConstructorUsedError;
}
