// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
// Basic Information
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get occupation => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get language =>
      throw _privateConstructorUsedError; // Visual Appearance
  VisualDescriptor get face => throw _privateConstructorUsedError;
  VisualDescriptor get hairstyle => throw _privateConstructorUsedError;
  VisualDescriptor get body => throw _privateConstructorUsedError;
  VisualDescriptor get accessories => throw _privateConstructorUsedError;
  VisualDescriptor get outfit =>
      throw _privateConstructorUsedError; // Personality
  Personality get personality => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {String name,
      int age,
      String gender,
      String occupation,
      String location,
      String language,
      VisualDescriptor face,
      VisualDescriptor hairstyle,
      VisualDescriptor body,
      VisualDescriptor accessories,
      VisualDescriptor outfit,
      Personality personality});

  $VisualDescriptorCopyWith<$Res> get face;
  $VisualDescriptorCopyWith<$Res> get hairstyle;
  $VisualDescriptorCopyWith<$Res> get body;
  $VisualDescriptorCopyWith<$Res> get accessories;
  $VisualDescriptorCopyWith<$Res> get outfit;
  $PersonalityCopyWith<$Res> get personality;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

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
    Object? language = null,
    Object? face = null,
    Object? hairstyle = null,
    Object? body = null,
    Object? accessories = null,
    Object? outfit = null,
    Object? personality = null,
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
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
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
      personality: null == personality
          ? _value.personality
          : personality // ignore: cast_nullable_to_non_nullable
              as Personality,
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
  $PersonalityCopyWith<$Res> get personality {
    return $PersonalityCopyWith<$Res>(_value.personality, (value) {
      return _then(_value.copyWith(personality: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int age,
      String gender,
      String occupation,
      String location,
      String language,
      VisualDescriptor face,
      VisualDescriptor hairstyle,
      VisualDescriptor body,
      VisualDescriptor accessories,
      VisualDescriptor outfit,
      Personality personality});

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
  $PersonalityCopyWith<$Res> get personality;
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? occupation = null,
    Object? location = null,
    Object? language = null,
    Object? face = null,
    Object? hairstyle = null,
    Object? body = null,
    Object? accessories = null,
    Object? outfit = null,
    Object? personality = null,
  }) {
    return _then(_$UserProfileImpl(
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
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
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
      personality: null == personality
          ? _value.personality
          : personality // ignore: cast_nullable_to_non_nullable
              as Personality,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl(
      {required this.name,
      required this.age,
      required this.gender,
      required this.occupation,
      required this.location,
      this.language = 'Korean',
      required this.face,
      required this.hairstyle,
      required this.body,
      required this.accessories,
      required this.outfit,
      required this.personality});

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

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
  @override
  @JsonKey()
  final String language;
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
// Personality
  @override
  final Personality personality;

  @override
  String toString() {
    return 'UserProfile(name: $name, age: $age, gender: $gender, occupation: $occupation, location: $location, language: $language, face: $face, hairstyle: $hairstyle, body: $body, accessories: $accessories, outfit: $outfit, personality: $personality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.occupation, occupation) ||
                other.occupation == occupation) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.face, face) || other.face == face) &&
            (identical(other.hairstyle, hairstyle) ||
                other.hairstyle == hairstyle) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.accessories, accessories) ||
                other.accessories == accessories) &&
            (identical(other.outfit, outfit) || other.outfit == outfit) &&
            (identical(other.personality, personality) ||
                other.personality == personality));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      age,
      gender,
      occupation,
      location,
      language,
      face,
      hairstyle,
      body,
      accessories,
      outfit,
      personality);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile(
      {required final String name,
      required final int age,
      required final String gender,
      required final String occupation,
      required final String location,
      final String language,
      required final VisualDescriptor face,
      required final VisualDescriptor hairstyle,
      required final VisualDescriptor body,
      required final VisualDescriptor accessories,
      required final VisualDescriptor outfit,
      required final Personality personality}) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

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
  @override
  String get language;
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
  @override // Personality
  Personality get personality;
  @override
  @JsonKey(ignore: true)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
