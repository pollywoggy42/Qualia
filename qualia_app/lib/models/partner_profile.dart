import 'package:freezed_annotation/freezed_annotation.dart';

import 'visual_descriptor.dart';
import 'personality.dart';
import 'partner_emotional_state.dart';

part 'partner_profile.freezed.dart';
part 'partner_profile.g.dart';

/// Partner Profile - 파트너 캐릭터의 모든 정보
@freezed
class PartnerProfile with _$PartnerProfile {
  const factory PartnerProfile({
    // Basic Information
    required String name,
    required int age,
    required String gender,
    required String occupation,
    required String location,

    // Visual Appearance
    required VisualDescriptor face,
    required VisualDescriptor hairstyle,
    required VisualDescriptor body,
    required VisualDescriptor accessories,
    required VisualDescriptor outfit,
    VisualDescriptor? nsfwOutfit,

    // Personality
    required Personality personality,
    String? secret,
    @Default([]) List<String> secretFragments,
    @Default([]) List<String> traumas,

    // Emotional State
    required PartnerEmotionalState emotionalState,

    // Physical State
    @Default([]) List<String> physicalState,

    // Sexual State
    @Default(0) int sexualExperience,
    @Default(false) bool isNSFWAllowed,

    // Memory - 5턴마다 요약 저장, 최근 5개만 유지
    @Default([]) List<String> memorySnapshots,
  }) = _PartnerProfile;

  factory PartnerProfile.fromJson(Map<String, dynamic> json) =>
      _$PartnerProfileFromJson(json);
}
