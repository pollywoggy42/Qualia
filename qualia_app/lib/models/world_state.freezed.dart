// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'world_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorldState _$WorldStateFromJson(Map<String, dynamic> json) {
  return _WorldState.fromJson(json);
}

/// @nodoc
mixin _$WorldState {
// 물리적 환경
  DateTime get currentTime => throw _privateConstructorUsedError;
  String get weather =>
      throw _privateConstructorUsedError; // 서사적 상태 (Scenario Director가 관리)
  VisualDescriptor? get currentSituation => throw _privateConstructorUsedError;
  String? get ongoingEvent => throw _privateConstructorUsedError;
  String get emotionalAtmosphere => throw _privateConstructorUsedError; // 메타 정보
  int get turnCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorldStateCopyWith<WorldState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorldStateCopyWith<$Res> {
  factory $WorldStateCopyWith(
          WorldState value, $Res Function(WorldState) then) =
      _$WorldStateCopyWithImpl<$Res, WorldState>;
  @useResult
  $Res call(
      {DateTime currentTime,
      String weather,
      VisualDescriptor? currentSituation,
      String? ongoingEvent,
      String emotionalAtmosphere,
      int turnCount});

  $VisualDescriptorCopyWith<$Res>? get currentSituation;
}

/// @nodoc
class _$WorldStateCopyWithImpl<$Res, $Val extends WorldState>
    implements $WorldStateCopyWith<$Res> {
  _$WorldStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTime = null,
    Object? weather = null,
    Object? currentSituation = freezed,
    Object? ongoingEvent = freezed,
    Object? emotionalAtmosphere = null,
    Object? turnCount = null,
  }) {
    return _then(_value.copyWith(
      currentTime: null == currentTime
          ? _value.currentTime
          : currentTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weather: null == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as String,
      currentSituation: freezed == currentSituation
          ? _value.currentSituation
          : currentSituation // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor?,
      ongoingEvent: freezed == ongoingEvent
          ? _value.ongoingEvent
          : ongoingEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      emotionalAtmosphere: null == emotionalAtmosphere
          ? _value.emotionalAtmosphere
          : emotionalAtmosphere // ignore: cast_nullable_to_non_nullable
              as String,
      turnCount: null == turnCount
          ? _value.turnCount
          : turnCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VisualDescriptorCopyWith<$Res>? get currentSituation {
    if (_value.currentSituation == null) {
      return null;
    }

    return $VisualDescriptorCopyWith<$Res>(_value.currentSituation!, (value) {
      return _then(_value.copyWith(currentSituation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorldStateImplCopyWith<$Res>
    implements $WorldStateCopyWith<$Res> {
  factory _$$WorldStateImplCopyWith(
          _$WorldStateImpl value, $Res Function(_$WorldStateImpl) then) =
      __$$WorldStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime currentTime,
      String weather,
      VisualDescriptor? currentSituation,
      String? ongoingEvent,
      String emotionalAtmosphere,
      int turnCount});

  @override
  $VisualDescriptorCopyWith<$Res>? get currentSituation;
}

/// @nodoc
class __$$WorldStateImplCopyWithImpl<$Res>
    extends _$WorldStateCopyWithImpl<$Res, _$WorldStateImpl>
    implements _$$WorldStateImplCopyWith<$Res> {
  __$$WorldStateImplCopyWithImpl(
      _$WorldStateImpl _value, $Res Function(_$WorldStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTime = null,
    Object? weather = null,
    Object? currentSituation = freezed,
    Object? ongoingEvent = freezed,
    Object? emotionalAtmosphere = null,
    Object? turnCount = null,
  }) {
    return _then(_$WorldStateImpl(
      currentTime: null == currentTime
          ? _value.currentTime
          : currentTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weather: null == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as String,
      currentSituation: freezed == currentSituation
          ? _value.currentSituation
          : currentSituation // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor?,
      ongoingEvent: freezed == ongoingEvent
          ? _value.ongoingEvent
          : ongoingEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      emotionalAtmosphere: null == emotionalAtmosphere
          ? _value.emotionalAtmosphere
          : emotionalAtmosphere // ignore: cast_nullable_to_non_nullable
              as String,
      turnCount: null == turnCount
          ? _value.turnCount
          : turnCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorldStateImpl implements _WorldState {
  const _$WorldStateImpl(
      {required this.currentTime,
      required this.weather,
      this.currentSituation,
      this.ongoingEvent,
      this.emotionalAtmosphere = 'Neutral',
      this.turnCount = 0});

  factory _$WorldStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorldStateImplFromJson(json);

// 물리적 환경
  @override
  final DateTime currentTime;
  @override
  final String weather;
// 서사적 상태 (Scenario Director가 관리)
  @override
  final VisualDescriptor? currentSituation;
  @override
  final String? ongoingEvent;
  @override
  @JsonKey()
  final String emotionalAtmosphere;
// 메타 정보
  @override
  @JsonKey()
  final int turnCount;

  @override
  String toString() {
    return 'WorldState(currentTime: $currentTime, weather: $weather, currentSituation: $currentSituation, ongoingEvent: $ongoingEvent, emotionalAtmosphere: $emotionalAtmosphere, turnCount: $turnCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorldStateImpl &&
            (identical(other.currentTime, currentTime) ||
                other.currentTime == currentTime) &&
            (identical(other.weather, weather) || other.weather == weather) &&
            (identical(other.currentSituation, currentSituation) ||
                other.currentSituation == currentSituation) &&
            (identical(other.ongoingEvent, ongoingEvent) ||
                other.ongoingEvent == ongoingEvent) &&
            (identical(other.emotionalAtmosphere, emotionalAtmosphere) ||
                other.emotionalAtmosphere == emotionalAtmosphere) &&
            (identical(other.turnCount, turnCount) ||
                other.turnCount == turnCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentTime, weather,
      currentSituation, ongoingEvent, emotionalAtmosphere, turnCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorldStateImplCopyWith<_$WorldStateImpl> get copyWith =>
      __$$WorldStateImplCopyWithImpl<_$WorldStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorldStateImplToJson(
      this,
    );
  }
}

abstract class _WorldState implements WorldState {
  const factory _WorldState(
      {required final DateTime currentTime,
      required final String weather,
      final VisualDescriptor? currentSituation,
      final String? ongoingEvent,
      final String emotionalAtmosphere,
      final int turnCount}) = _$WorldStateImpl;

  factory _WorldState.fromJson(Map<String, dynamic> json) =
      _$WorldStateImpl.fromJson;

  @override // 물리적 환경
  DateTime get currentTime;
  @override
  String get weather;
  @override // 서사적 상태 (Scenario Director가 관리)
  VisualDescriptor? get currentSituation;
  @override
  String? get ongoingEvent;
  @override
  String get emotionalAtmosphere;
  @override // 메타 정보
  int get turnCount;
  @override
  @JsonKey(ignore: true)
  _$$WorldStateImplCopyWith<_$WorldStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
