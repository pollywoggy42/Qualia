// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartnerProfile _$PartnerProfileFromJson(Map<String, dynamic> json) {
  return _PartnerProfile.fromJson(json);
}

/// @nodoc
mixin _$PartnerProfile {
// Basic Information
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get occupation => throw _privateConstructorUsedError;
  String get location =>
      throw _privateConstructorUsedError; // Visual Appearance
  VisualDescriptor get face => throw _privateConstructorUsedError;
  VisualDescriptor get hairstyle => throw _privateConstructorUsedError;
  VisualDescriptor get body => throw _privateConstructorUsedError;
  VisualDescriptor get accessories => throw _privateConstructorUsedError;
  VisualDescriptor get outfit => throw _privateConstructorUsedError;
  VisualDescriptor? get nsfwOutfit =>
      throw _privateConstructorUsedError; // Personality
  Personality get personality => throw _privateConstructorUsedError;
  String? get secret => throw _privateConstructorUsedError;
  List<String> get secretFragments => throw _privateConstructorUsedError;
  List<String> get traumas =>
      throw _privateConstructorUsedError; // Emotional State
  PartnerEmotionalState get emotionalState =>
      throw _privateConstructorUsedError; // Physical State
  List<String> get physicalState =>
      throw _privateConstructorUsedError; // Sexual State
  int get sexualExperience => throw _privateConstructorUsedError;
  bool get isNSFWAllowed =>
      throw _privateConstructorUsedError; // Memory - 5턴마다 요약 저장, 최근 5개만 유지
  List<String> get memorySnapshots => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PartnerProfileCopyWith<PartnerProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerProfileCopyWith<$Res> {
  factory $PartnerProfileCopyWith(
          PartnerProfile value, $Res Function(PartnerProfile) then) =
      _$PartnerProfileCopyWithImpl<$Res, PartnerProfile>;
  @useResult
  $Res call(
      {String name,
      int age,
      String gender,
      String occupation,
      String location,
      VisualDescriptor face,
      VisualDescriptor hairstyle,
      VisualDescriptor body,
      VisualDescriptor accessories,
      VisualDescriptor outfit,
      VisualDescriptor? nsfwOutfit,
      Personality personality,
      String? secret,
      List<String> secretFragments,
      List<String> traumas,
      PartnerEmotionalState emotionalState,
      List<String> physicalState,
      int sexualExperience,
      bool isNSFWAllowed,
      List<String> memorySnapshots});

  $VisualDescriptorCopyWith<$Res> get face;
  $VisualDescriptorCopyWith<$Res> get hairstyle;
  $VisualDescriptorCopyWith<$Res> get body;
  $VisualDescriptorCopyWith<$Res> get accessories;
  $VisualDescriptorCopyWith<$Res> get outfit;
  $VisualDescriptorCopyWith<$Res>? get nsfwOutfit;
  $PersonalityCopyWith<$Res> get personality;
  $PartnerEmotionalStateCopyWith<$Res> get emotionalState;
}

/// @nodoc
class _$PartnerProfileCopyWithImpl<$Res, $Val extends PartnerProfile>
    implements $PartnerProfileCopyWith<$Res> {
  _$PartnerProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? occupation = null,
    Object? location = null,
    Object? face = null,
    Object? hairstyle = null,
    Object? body = null,
    Object? accessories = null,
    Object? outfit = null,
    Object? nsfwOutfit = freezed,
    Object? personality = null,
    Object? secret = freezed,
    Object? secretFragments = null,
    Object? traumas = null,
    Object? emotionalState = null,
    Object? physicalState = null,
    Object? sexualExperience = null,
    Object? isNSFWAllowed = null,
    Object? memorySnapshots = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      occupation: null == occupation
          ? _value.occupation
          : occupation // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      face: null == face
          ? _value.face
          : face // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor,
      hairstyle: null == hairstyle
          ? _value.hairstyle
          : hairstyle // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor,
      accessories: null == accessories
          ? _value.accessories
          : accessories // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor,
      outfit: null == outfit
          ? _value.outfit
          : outfit // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor,
      nsfwOutfit: freezed == nsfwOutfit
          ? _value.nsfwOutfit
          : nsfwOutfit // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor?,
      personality: null == personality
          ? _value.personality
          : personality // ignore: cast_nullable_to_non_nullable
              as Personality,
      secret: freezed == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
      secretFragments: null == secretFragments
          ? _value.secretFragments
          : secretFragments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      traumas: null == traumas
          ? _value.traumas
          : traumas // ignore: cast_nullable_to_non_nullable
              as List<String>,
      emotionalState: null == emotionalState
          ? _value.emotionalState
          : emotionalState // ignore: cast_nullable_to_non_nullable
              as PartnerEmotionalState,
      physicalState: null == physicalState
          ? _value.physicalState
          : physicalState // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sexualExperience: null == sexualExperience
          ? _value.sexualExperience
          : sexualExperience // ignore: cast_nullable_to_non_nullable
              as int,
      isNSFWAllowed: null == isNSFWAllowed
          ? _value.isNSFWAllowed
          : isNSFWAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
      memorySnapshots: null == memorySnapshots
          ? _value.memorySnapshots
          : memorySnapshots // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VisualDescriptorCopyWith<$Res> get face {
    return $VisualDescriptorCopyWith<$Res>(_value.face, (value) {
      return _then(_value.copyWith(face: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VisualDescriptorCopyWith<$Res> get hairstyle {
    return $VisualDescriptorCopyWith<$Res>(_value.hairstyle, (value) {
      return _then(_value.copyWith(hairstyle: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VisualDescriptorCopyWith<$Res> get body {
    return $VisualDescriptorCopyWith<$Res>(_value.body, (value) {
      return _then(_value.copyWith(body: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VisualDescriptorCopyWith<$Res> get accessories {
    return $VisualDescriptorCopyWith<$Res>(_value.accessories, (value) {
      return _then(_value.copyWith(accessories: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VisualDescriptorCopyWith<$Res> get outfit {
    return $VisualDescriptorCopyWith<$Res>(_value.outfit, (value) {
      return _then(_value.copyWith(outfit: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VisualDescriptorCopyWith<$Res>? get nsfwOutfit {
    if (_value.nsfwOutfit == null) {
      return null;
    }

    return $VisualDescriptorCopyWith<$Res>(_value.nsfwOutfit!, (value) {
      return _then(_value.copyWith(nsfwOutfit: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PersonalityCopyWith<$Res> get personality {
    return $PersonalityCopyWith<$Res>(_value.personality, (value) {
      return _then(_value.copyWith(personality: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PartnerEmotionalStateCopyWith<$Res> get emotionalState {
    return $PartnerEmotionalStateCopyWith<$Res>(_value.emotionalState, (value) {
      return _then(_value.copyWith(emotionalState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PartnerProfileImplCopyWith<$Res>
    implements $PartnerProfileCopyWith<$Res> {
  factory _$$PartnerProfileImplCopyWith(_$PartnerProfileImpl value,
          $Res Function(_$PartnerProfileImpl) then) =
      __$$PartnerProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int age,
      String gender,
      String occupation,
      String location,
      VisualDescriptor face,
      VisualDescriptor hairstyle,
      VisualDescriptor body,
      VisualDescriptor accessories,
      VisualDescriptor outfit,
      VisualDescriptor? nsfwOutfit,
      Personality personality,
      String? secret,
      List<String> secretFragments,
      List<String> traumas,
      PartnerEmotionalState emotionalState,
      List<String> physicalState,
      int sexualExperience,
      bool isNSFWAllowed,
      List<String> memorySnapshots});

  @override
  $VisualDescriptorCopyWith<$Res> get face;
  @override
  $VisualDescriptorCopyWith<$Res> get hairstyle;
  @override
  $VisualDescriptorCopyWith<$Res> get body;
  @override
  $VisualDescriptorCopyWith<$Res> get accessories;
  @override
  $VisualDescriptorCopyWith<$Res> get outfit;
  @override
  $VisualDescriptorCopyWith<$Res>? get nsfwOutfit;
  @override
  $PersonalityCopyWith<$Res> get personality;
  @override
  $PartnerEmotionalStateCopyWith<$Res> get emotionalState;
}

/// @nodoc
class __$$PartnerProfileImplCopyWithImpl<$Res>
    extends _$PartnerProfileCopyWithImpl<$Res, _$PartnerProfileImpl>
    implements _$$PartnerProfileImplCopyWith<$Res> {
  __$$PartnerProfileImplCopyWithImpl(
      _$PartnerProfileImpl _value, $Res Function(_$PartnerProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? occupation = null,
    Object? location = null,
    Object? face = null,
    Object? hairstyle = null,
    Object? body = null,
    Object? accessories = null,
    Object? outfit = null,
    Object? nsfwOutfit = freezed,
    Object? personality = null,
    Object? secret = freezed,
    Object? secretFragments = null,
    Object? traumas = null,
    Object? emotionalState = null,
    Object? physicalState = null,
    Object? sexualExperience = null,
    Object? isNSFWAllowed = null,
    Object? memorySnapshots = null,
  }) {
    return _then(_$PartnerProfileImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      occupation: null == occupation
          ? _value.occupation
          : occupation // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      face: null == face
          ? _value.face
          : face // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor,
      hairstyle: null == hairstyle
          ? _value.hairstyle
          : hairstyle // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor,
      accessories: null == accessories
          ? _value.accessories
          : accessories // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor,
      outfit: null == outfit
          ? _value.outfit
          : outfit // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor,
      nsfwOutfit: freezed == nsfwOutfit
          ? _value.nsfwOutfit
          : nsfwOutfit // ignore: cast_nullable_to_non_nullable
              as VisualDescriptor?,
      personality: null == personality
          ? _value.personality
          : personality // ignore: cast_nullable_to_non_nullable
              as Personality,
      secret: freezed == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
      secretFragments: null == secretFragments
          ? _value._secretFragments
          : secretFragments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      traumas: null == traumas
          ? _value._traumas
          : traumas // ignore: cast_nullable_to_non_nullable
              as List<String>,
      emotionalState: null == emotionalState
          ? _value.emotionalState
          : emotionalState // ignore: cast_nullable_to_non_nullable
              as PartnerEmotionalState,
      physicalState: null == physicalState
          ? _value._physicalState
          : physicalState // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sexualExperience: null == sexualExperience
          ? _value.sexualExperience
          : sexualExperience // ignore: cast_nullable_to_non_nullable
              as int,
      isNSFWAllowed: null == isNSFWAllowed
          ? _value.isNSFWAllowed
          : isNSFWAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
      memorySnapshots: null == memorySnapshots
          ? _value._memorySnapshots
          : memorySnapshots // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerProfileImpl implements _PartnerProfile {
  const _$PartnerProfileImpl(
      {required this.name,
      required this.age,
      required this.gender,
      required this.occupation,
      required this.location,
      required this.face,
      required this.hairstyle,
      required this.body,
      required this.accessories,
      required this.outfit,
      this.nsfwOutfit,
      required this.personality,
      this.secret,
      final List<String> secretFragments = const [],
      final List<String> traumas = const [],
      required this.emotionalState,
      final List<String> physicalState = const [],
      this.sexualExperience = 0,
      this.isNSFWAllowed = false,
      final List<String> memorySnapshots = const []})
      : _secretFragments = secretFragments,
        _traumas = traumas,
        _physicalState = physicalState,
        _memorySnapshots = memorySnapshots;

  factory _$PartnerProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerProfileImplFromJson(json);

// Basic Information
  @override
  final String name;
  @override
  final int age;
  @override
  final String gender;
  @override
  final String occupation;
  @override
  final String location;
// Visual Appearance
  @override
  final VisualDescriptor face;
  @override
  final VisualDescriptor hairstyle;
  @override
  final VisualDescriptor body;
  @override
  final VisualDescriptor accessories;
  @override
  final VisualDescriptor outfit;
  @override
  final VisualDescriptor? nsfwOutfit;
// Personality
  @override
  final Personality personality;
  @override
  final String? secret;
  final List<String> _secretFragments;
  @override
  @JsonKey()
  List<String> get secretFragments {
    if (_secretFragments is EqualUnmodifiableListView) return _secretFragments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_secretFragments);
  }

  final List<String> _traumas;
  @override
  @JsonKey()
  List<String> get traumas {
    if (_traumas is EqualUnmodifiableListView) return _traumas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_traumas);
  }

// Emotional State
  @override
  final PartnerEmotionalState emotionalState;
// Physical State
  final List<String> _physicalState;
// Physical State
  @override
  @JsonKey()
  List<String> get physicalState {
    if (_physicalState is EqualUnmodifiableListView) return _physicalState;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_physicalState);
  }

// Sexual State
  @override
  @JsonKey()
  final int sexualExperience;
  @override
  @JsonKey()
  final bool isNSFWAllowed;
// Memory - 5턴마다 요약 저장, 최근 5개만 유지
  final List<String> _memorySnapshots;
// Memory - 5턴마다 요약 저장, 최근 5개만 유지
  @override
  @JsonKey()
  List<String> get memorySnapshots {
    if (_memorySnapshots is EqualUnmodifiableListView) return _memorySnapshots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memorySnapshots);
  }

  @override
  String toString() {
    return 'PartnerProfile(name: $name, age: $age, gender: $gender, occupation: $occupation, location: $location, face: $face, hairstyle: $hairstyle, body: $body, accessories: $accessories, outfit: $outfit, nsfwOutfit: $nsfwOutfit, personality: $personality, secret: $secret, secretFragments: $secretFragments, traumas: $traumas, emotionalState: $emotionalState, physicalState: $physicalState, sexualExperience: $sexualExperience, isNSFWAllowed: $isNSFWAllowed, memorySnapshots: $memorySnapshots)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerProfileImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.occupation, occupation) ||
                other.occupation == occupation) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.face, face) || other.face == face) &&
            (identical(other.hairstyle, hairstyle) ||
                other.hairstyle == hairstyle) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.accessories, accessories) ||
                other.accessories == accessories) &&
            (identical(other.outfit, outfit) || other.outfit == outfit) &&
            (identical(other.nsfwOutfit, nsfwOutfit) ||
                other.nsfwOutfit == nsfwOutfit) &&
            (identical(other.personality, personality) ||
                other.personality == personality) &&
            (identical(other.secret, secret) || other.secret == secret) &&
            const DeepCollectionEquality()
                .equals(other._secretFragments, _secretFragments) &&
            const DeepCollectionEquality().equals(other._traumas, _traumas) &&
            (identical(other.emotionalState, emotionalState) ||
                other.emotionalState == emotionalState) &&
            const DeepCollectionEquality()
                .equals(other._physicalState, _physicalState) &&
            (identical(other.sexualExperience, sexualExperience) ||
                other.sexualExperience == sexualExperience) &&
            (identical(other.isNSFWAllowed, isNSFWAllowed) ||
                other.isNSFWAllowed == isNSFWAllowed) &&
            const DeepCollectionEquality()
                .equals(other._memorySnapshots, _memorySnapshots));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        name,
        age,
        gender,
        occupation,
        location,
        face,
        hairstyle,
        body,
        accessories,
        outfit,
        nsfwOutfit,
        personality,
        secret,
        const DeepCollectionEquality().hash(_secretFragments),
        const DeepCollectionEquality().hash(_traumas),
        emotionalState,
        const DeepCollectionEquality().hash(_physicalState),
        sexualExperience,
        isNSFWAllowed,
        const DeepCollectionEquality().hash(_memorySnapshots)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerProfileImplCopyWith<_$PartnerProfileImpl> get copyWith =>
      __$$PartnerProfileImplCopyWithImpl<_$PartnerProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerProfileImplToJson(
      this,
    );
  }
}

abstract class _PartnerProfile implements PartnerProfile {
  const factory _PartnerProfile(
      {required final String name,
      required final int age,
      required final String gender,
      required final String occupation,
      required final String location,
      required final VisualDescriptor face,
      required final VisualDescriptor hairstyle,
      required final VisualDescriptor body,
      required final VisualDescriptor accessories,
      required final VisualDescriptor outfit,
      final VisualDescriptor? nsfwOutfit,
      required final Personality personality,
      final String? secret,
      final List<String> secretFragments,
      final List<String> traumas,
      required final PartnerEmotionalState emotionalState,
      final List<String> physicalState,
      final int sexualExperience,
      final bool isNSFWAllowed,
      final List<String> memorySnapshots}) = _$PartnerProfileImpl;

  factory _PartnerProfile.fromJson(Map<String, dynamic> json) =
      _$PartnerProfileImpl.fromJson;

  @override // Basic Information
  String get name;
  @override
  int get age;
  @override
  String get gender;
  @override
  String get occupation;
  @override
  String get location;
  @override // Visual Appearance
  VisualDescriptor get face;
  @override
  VisualDescriptor get hairstyle;
  @override
  VisualDescriptor get body;
  @override
  VisualDescriptor get accessories;
  @override
  VisualDescriptor get outfit;
  @override
  VisualDescriptor? get nsfwOutfit;
  @override // Personality
  Personality get personality;
  @override
  String? get secret;
  @override
  List<String> get secretFragments;
  @override
  List<String> get traumas;
  @override // Emotional State
  PartnerEmotionalState get emotionalState;
  @override // Physical State
  List<String> get physicalState;
  @override // Sexual State
  int get sexualExperience;
  @override
  bool get isNSFWAllowed;
  @override // Memory - 5턴마다 요약 저장, 최근 5개만 유지
  List<String> get memorySnapshots;
  @override
  @JsonKey(ignore: true)
  _$$PartnerProfileImplCopyWith<_$PartnerProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
