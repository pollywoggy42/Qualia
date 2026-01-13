import 'package:freezed_annotation/freezed_annotation.dart';
import 'partner_emotional_state.dart';

part 'partner_response.freezed.dart';
part 'partner_response.g.dart';

/// Partner Agent Response
@freezed
class PartnerResponse with _$PartnerResponse {
  const factory PartnerResponse({
    @Default([]) List<String> actions,
    @Default([]) List<String> dialogues,
    required String innerThought,
    
    // Changes
    required PartnerEmotionalState emotionalChanges,
    required PhysicalStateChange physicalStateChanges,
    
    @Default(false) bool isNSFWAllowed,
    @Default(0) int sexualExperienceGain,
    String? traumaDetected,
  }) = _PartnerResponse;

  factory PartnerResponse.fromJson(Map<String, dynamic> json) =>
      _$PartnerResponseFromJson(json);
}

@freezed
class PhysicalStateChange with _$PhysicalStateChange {
  const factory PhysicalStateChange({
    @Default([]) List<String> add,
    @Default([]) List<String> remove,
  }) = _PhysicalStateChange;

  factory PhysicalStateChange.fromJson(Map<String, dynamic> json) =>
      _$PhysicalStateChangeFromJson(json);
}
