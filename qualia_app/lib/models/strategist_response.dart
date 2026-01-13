import 'package:freezed_annotation/freezed_annotation.dart';

part 'strategist_response.freezed.dart';
part 'strategist_response.g.dart';

/// Strategist Response
@freezed
class StrategistResponse with _$StrategistResponse {
  const factory StrategistResponse({
    required List<StrategyChoice> choices,
  }) = _StrategistResponse;

  factory StrategistResponse.fromJson(Map<String, dynamic> json) =>
      _$StrategistResponseFromJson(json);
}

/// Strategy Choice
@freezed
class StrategyChoice with _$StrategyChoice {
  const factory StrategyChoice({
    String? id, // Generated if null
    String? action,
    String? speech,
    String? sdxlTags,
    @Default(0) int successRate,
    String? reasoning,
    @Default(false) bool isSpecial,
  }) = _StrategyChoice;

  factory StrategyChoice.fromJson(Map<String, dynamic> json) =>
      _$StrategyChoiceFromJson(json);
}
