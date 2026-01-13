// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartnerResponse _$PartnerResponseFromJson(Map<String, dynamic> json) {
  return _PartnerResponse.fromJson(json);
}

/// @nodoc
mixin _$PartnerResponse {
  List<String> get actions => throw _privateConstructorUsedError;
  List<String> get dialogues => throw _privateConstructorUsedError;
  String get innerThought => throw _privateConstructorUsedError; // Changes
  PartnerEmotionalState get emotionalChanges =>
      throw _privateConstructorUsedError;
  PhysicalStateChange get physicalStateChanges =>
      throw _privateConstructorUsedError;
  bool get isNSFWAllowed => throw _privateConstructorUsedError;
  int get sexualExperienceGain => throw _privateConstructorUsedError;
  String? get traumaDetected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PartnerResponseCopyWith<PartnerResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerResponseCopyWith<$Res> {
  factory $PartnerResponseCopyWith(
          PartnerResponse value, $Res Function(PartnerResponse) then) =
      _$PartnerResponseCopyWithImpl<$Res, PartnerResponse>;
  @useResult
  $Res call(
      {List<String> actions,
      List<String> dialogues,
      String innerThought,
      PartnerEmotionalState emotionalChanges,
      PhysicalStateChange physicalStateChanges,
      bool isNSFWAllowed,
      int sexualExperienceGain,
      String? traumaDetected});

  $PartnerEmotionalStateCopyWith<$Res> get emotionalChanges;
  $PhysicalStateChangeCopyWith<$Res> get physicalStateChanges;
}

/// @nodoc
class _$PartnerResponseCopyWithImpl<$Res, $Val extends PartnerResponse>
    implements $PartnerResponseCopyWith<$Res> {
  _$PartnerResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actions = null,
    Object? dialogues = null,
    Object? innerThought = null,
    Object? emotionalChanges = null,
    Object? physicalStateChanges = null,
    Object? isNSFWAllowed = null,
    Object? sexualExperienceGain = null,
    Object? traumaDetected = freezed,
  }) {
    return _then(_value.copyWith(
      actions: null == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dialogues: null == dialogues
          ? _value.dialogues
          : dialogues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      innerThought: null == innerThought
          ? _value.innerThought
          : innerThought // ignore: cast_nullable_to_non_nullable
              as String,
      emotionalChanges: null == emotionalChanges
          ? _value.emotionalChanges
          : emotionalChanges // ignore: cast_nullable_to_non_nullable
              as PartnerEmotionalState,
      physicalStateChanges: null == physicalStateChanges
          ? _value.physicalStateChanges
          : physicalStateChanges // ignore: cast_nullable_to_non_nullable
              as PhysicalStateChange,
      isNSFWAllowed: null == isNSFWAllowed
          ? _value.isNSFWAllowed
          : isNSFWAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
      sexualExperienceGain: null == sexualExperienceGain
          ? _value.sexualExperienceGain
          : sexualExperienceGain // ignore: cast_nullable_to_non_nullable
              as int,
      traumaDetected: freezed == traumaDetected
          ? _value.traumaDetected
          : traumaDetected // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PartnerEmotionalStateCopyWith<$Res> get emotionalChanges {
    return $PartnerEmotionalStateCopyWith<$Res>(_value.emotionalChanges,
        (value) {
      return _then(_value.copyWith(emotionalChanges: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PhysicalStateChangeCopyWith<$Res> get physicalStateChanges {
    return $PhysicalStateChangeCopyWith<$Res>(_value.physicalStateChanges,
        (value) {
      return _then(_value.copyWith(physicalStateChanges: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PartnerResponseImplCopyWith<$Res>
    implements $PartnerResponseCopyWith<$Res> {
  factory _$$PartnerResponseImplCopyWith(_$PartnerResponseImpl value,
          $Res Function(_$PartnerResponseImpl) then) =
      __$$PartnerResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> actions,
      List<String> dialogues,
      String innerThought,
      PartnerEmotionalState emotionalChanges,
      PhysicalStateChange physicalStateChanges,
      bool isNSFWAllowed,
      int sexualExperienceGain,
      String? traumaDetected});

  @override
  $PartnerEmotionalStateCopyWith<$Res> get emotionalChanges;
  @override
  $PhysicalStateChangeCopyWith<$Res> get physicalStateChanges;
}

/// @nodoc
class __$$PartnerResponseImplCopyWithImpl<$Res>
    extends _$PartnerResponseCopyWithImpl<$Res, _$PartnerResponseImpl>
    implements _$$PartnerResponseImplCopyWith<$Res> {
  __$$PartnerResponseImplCopyWithImpl(
      _$PartnerResponseImpl _value, $Res Function(_$PartnerResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actions = null,
    Object? dialogues = null,
    Object? innerThought = null,
    Object? emotionalChanges = null,
    Object? physicalStateChanges = null,
    Object? isNSFWAllowed = null,
    Object? sexualExperienceGain = null,
    Object? traumaDetected = freezed,
  }) {
    return _then(_$PartnerResponseImpl(
      actions: null == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dialogues: null == dialogues
          ? _value._dialogues
          : dialogues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      innerThought: null == innerThought
          ? _value.innerThought
          : innerThought // ignore: cast_nullable_to_non_nullable
              as String,
      emotionalChanges: null == emotionalChanges
          ? _value.emotionalChanges
          : emotionalChanges // ignore: cast_nullable_to_non_nullable
              as PartnerEmotionalState,
      physicalStateChanges: null == physicalStateChanges
          ? _value.physicalStateChanges
          : physicalStateChanges // ignore: cast_nullable_to_non_nullable
              as PhysicalStateChange,
      isNSFWAllowed: null == isNSFWAllowed
          ? _value.isNSFWAllowed
          : isNSFWAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
      sexualExperienceGain: null == sexualExperienceGain
          ? _value.sexualExperienceGain
          : sexualExperienceGain // ignore: cast_nullable_to_non_nullable
              as int,
      traumaDetected: freezed == traumaDetected
          ? _value.traumaDetected
          : traumaDetected // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerResponseImpl implements _PartnerResponse {
  const _$PartnerResponseImpl(
      {final List<String> actions = const [],
      final List<String> dialogues = const [],
      required this.innerThought,
      required this.emotionalChanges,
      required this.physicalStateChanges,
      this.isNSFWAllowed = false,
      this.sexualExperienceGain = 0,
      this.traumaDetected})
      : _actions = actions,
        _dialogues = dialogues;

  factory _$PartnerResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerResponseImplFromJson(json);

  final List<String> _actions;
  @override
  @JsonKey()
  List<String> get actions {
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actions);
  }

  final List<String> _dialogues;
  @override
  @JsonKey()
  List<String> get dialogues {
    if (_dialogues is EqualUnmodifiableListView) return _dialogues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dialogues);
  }

  @override
  final String innerThought;
// Changes
  @override
  final PartnerEmotionalState emotionalChanges;
  @override
  final PhysicalStateChange physicalStateChanges;
  @override
  @JsonKey()
  final bool isNSFWAllowed;
  @override
  @JsonKey()
  final int sexualExperienceGain;
  @override
  final String? traumaDetected;

  @override
  String toString() {
    return 'PartnerResponse(actions: $actions, dialogues: $dialogues, innerThought: $innerThought, emotionalChanges: $emotionalChanges, physicalStateChanges: $physicalStateChanges, isNSFWAllowed: $isNSFWAllowed, sexualExperienceGain: $sexualExperienceGain, traumaDetected: $traumaDetected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerResponseImpl &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            const DeepCollectionEquality()
                .equals(other._dialogues, _dialogues) &&
            (identical(other.innerThought, innerThought) ||
                other.innerThought == innerThought) &&
            (identical(other.emotionalChanges, emotionalChanges) ||
                other.emotionalChanges == emotionalChanges) &&
            (identical(other.physicalStateChanges, physicalStateChanges) ||
                other.physicalStateChanges == physicalStateChanges) &&
            (identical(other.isNSFWAllowed, isNSFWAllowed) ||
                other.isNSFWAllowed == isNSFWAllowed) &&
            (identical(other.sexualExperienceGain, sexualExperienceGain) ||
                other.sexualExperienceGain == sexualExperienceGain) &&
            (identical(other.traumaDetected, traumaDetected) ||
                other.traumaDetected == traumaDetected));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_actions),
      const DeepCollectionEquality().hash(_dialogues),
      innerThought,
      emotionalChanges,
      physicalStateChanges,
      isNSFWAllowed,
      sexualExperienceGain,
      traumaDetected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerResponseImplCopyWith<_$PartnerResponseImpl> get copyWith =>
      __$$PartnerResponseImplCopyWithImpl<_$PartnerResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerResponseImplToJson(
      this,
    );
  }
}

abstract class _PartnerResponse implements PartnerResponse {
  const factory _PartnerResponse(
      {final List<String> actions,
      final List<String> dialogues,
      required final String innerThought,
      required final PartnerEmotionalState emotionalChanges,
      required final PhysicalStateChange physicalStateChanges,
      final bool isNSFWAllowed,
      final int sexualExperienceGain,
      final String? traumaDetected}) = _$PartnerResponseImpl;

  factory _PartnerResponse.fromJson(Map<String, dynamic> json) =
      _$PartnerResponseImpl.fromJson;

  @override
  List<String> get actions;
  @override
  List<String> get dialogues;
  @override
  String get innerThought;
  @override // Changes
  PartnerEmotionalState get emotionalChanges;
  @override
  PhysicalStateChange get physicalStateChanges;
  @override
  bool get isNSFWAllowed;
  @override
  int get sexualExperienceGain;
  @override
  String? get traumaDetected;
  @override
  @JsonKey(ignore: true)
  _$$PartnerResponseImplCopyWith<_$PartnerResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhysicalStateChange _$PhysicalStateChangeFromJson(Map<String, dynamic> json) {
  return _PhysicalStateChange.fromJson(json);
}

/// @nodoc
mixin _$PhysicalStateChange {
  List<String> get add => throw _privateConstructorUsedError;
  List<String> get remove => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhysicalStateChangeCopyWith<PhysicalStateChange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhysicalStateChangeCopyWith<$Res> {
  factory $PhysicalStateChangeCopyWith(
          PhysicalStateChange value, $Res Function(PhysicalStateChange) then) =
      _$PhysicalStateChangeCopyWithImpl<$Res, PhysicalStateChange>;
  @useResult
  $Res call({List<String> add, List<String> remove});
}

/// @nodoc
class _$PhysicalStateChangeCopyWithImpl<$Res, $Val extends PhysicalStateChange>
    implements $PhysicalStateChangeCopyWith<$Res> {
  _$PhysicalStateChangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? add = null,
    Object? remove = null,
  }) {
    return _then(_value.copyWith(
      add: null == add
          ? _value.add
          : add // ignore: cast_nullable_to_non_nullable
              as List<String>,
      remove: null == remove
          ? _value.remove
          : remove // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhysicalStateChangeImplCopyWith<$Res>
    implements $PhysicalStateChangeCopyWith<$Res> {
  factory _$$PhysicalStateChangeImplCopyWith(_$PhysicalStateChangeImpl value,
          $Res Function(_$PhysicalStateChangeImpl) then) =
      __$$PhysicalStateChangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> add, List<String> remove});
}

/// @nodoc
class __$$PhysicalStateChangeImplCopyWithImpl<$Res>
    extends _$PhysicalStateChangeCopyWithImpl<$Res, _$PhysicalStateChangeImpl>
    implements _$$PhysicalStateChangeImplCopyWith<$Res> {
  __$$PhysicalStateChangeImplCopyWithImpl(_$PhysicalStateChangeImpl _value,
      $Res Function(_$PhysicalStateChangeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? add = null,
    Object? remove = null,
  }) {
    return _then(_$PhysicalStateChangeImpl(
      add: null == add
          ? _value._add
          : add // ignore: cast_nullable_to_non_nullable
              as List<String>,
      remove: null == remove
          ? _value._remove
          : remove // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PhysicalStateChangeImpl implements _PhysicalStateChange {
  const _$PhysicalStateChangeImpl(
      {final List<String> add = const [], final List<String> remove = const []})
      : _add = add,
        _remove = remove;

  factory _$PhysicalStateChangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhysicalStateChangeImplFromJson(json);

  final List<String> _add;
  @override
  @JsonKey()
  List<String> get add {
    if (_add is EqualUnmodifiableListView) return _add;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_add);
  }

  final List<String> _remove;
  @override
  @JsonKey()
  List<String> get remove {
    if (_remove is EqualUnmodifiableListView) return _remove;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_remove);
  }

  @override
  String toString() {
    return 'PhysicalStateChange(add: $add, remove: $remove)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhysicalStateChangeImpl &&
            const DeepCollectionEquality().equals(other._add, _add) &&
            const DeepCollectionEquality().equals(other._remove, _remove));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_add),
      const DeepCollectionEquality().hash(_remove));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhysicalStateChangeImplCopyWith<_$PhysicalStateChangeImpl> get copyWith =>
      __$$PhysicalStateChangeImplCopyWithImpl<_$PhysicalStateChangeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhysicalStateChangeImplToJson(
      this,
    );
  }
}

abstract class _PhysicalStateChange implements PhysicalStateChange {
  const factory _PhysicalStateChange(
      {final List<String> add,
      final List<String> remove}) = _$PhysicalStateChangeImpl;

  factory _PhysicalStateChange.fromJson(Map<String, dynamic> json) =
      _$PhysicalStateChangeImpl.fromJson;

  @override
  List<String> get add;
  @override
  List<String> get remove;
  @override
  @JsonKey(ignore: true)
  _$$PhysicalStateChangeImplCopyWith<_$PhysicalStateChangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
