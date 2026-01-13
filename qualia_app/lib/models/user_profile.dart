import 'package:freezed_annotation/freezed_annotation.dart';

import 'visual_descriptor.dart';
import 'personality.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// User Profile - 유저 캐릭터 정보
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    // Basic Information
    required String name,
    required int age,
    required String gender,
    required String occupation,
    required String location,
    @Default('Korean') String language,

    // Visual Appearance
    required VisualDescriptor face,
    required VisualDescriptor hairstyle,
    required VisualDescriptor body,
    required VisualDescriptor accessories,
    required VisualDescriptor outfit,

    // Personality
    required Personality personality,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
