import 'package:freezed_annotation/freezed_annotation.dart';

part 'visual_director_response.freezed.dart';
part 'visual_director_response.g.dart';

/// Visual Director Response
@freezed
class VisualDirectorResponse with _$VisualDirectorResponse {
  const factory VisualDirectorResponse({
    required List<String> positiveTags,
  }) = _VisualDirectorResponse;

  factory VisualDirectorResponse.fromJson(Map<String, dynamic> json) =>
      _$VisualDirectorResponseFromJson(json);
}
