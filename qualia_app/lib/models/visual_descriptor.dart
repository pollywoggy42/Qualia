import 'package:freezed_annotation/freezed_annotation.dart';

part 'visual_descriptor.freezed.dart';
part 'visual_descriptor.g.dart';

/// Visual Descriptor - 자연어 설명과 SDXL 태그를 쌍으로 관리
@freezed
class VisualDescriptor with _$VisualDescriptor {
  const factory VisualDescriptor({
    required String description,
    required String sdxlTags,
  }) = _VisualDescriptor;

  factory VisualDescriptor.fromJson(Map<String, dynamic> json) =>
      _$VisualDescriptorFromJson(json);
}
