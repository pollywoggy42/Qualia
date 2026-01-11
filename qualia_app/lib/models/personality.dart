import 'package:freezed_annotation/freezed_annotation.dart';

part 'personality.freezed.dart';
part 'personality.g.dart';

/// Personality - Partner와 User 공통 성격 구조
@freezed
class Personality with _$Personality {
  const factory Personality({
    required String mbti,
    required String speechStyle,
    required List<String> traits,
  }) = _Personality;

  factory Personality.fromJson(Map<String, dynamic> json) =>
      _$PersonalityFromJson(json);
}
