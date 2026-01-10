# Visual Descriptor

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 개요

자연어 설명과 SDXL 태그를 쌍으로 관리하는 기본 구조.

## 데이터 구조

```dart
class VisualDescriptor {
  String description;      // 자연어 설명 (유저 입력)
  String sdxlTags;        // SDXL 태그 (LLM 생성 또는 수동 입력)
}
```

## 사용 예시

```dart
// 얼굴
VisualDescriptor(
  description: "큰 눈을 가진 귀여운 동안",
  sdxlTags: "baby face, large eyes, cute, youthful"
);

// 의상
VisualDescriptor(
  description: "흰색 블라우스와 검은색 치마",
  sdxlTags: "white blouse, black skirt, student uniform"
);

// 현재 상황
VisualDescriptor(
  description: "비가 내리고 옷이 젖어가는 중",
  sdxlTags: "rain, wet clothes, getting soaked"
);
```

## 설계 의도

- **Dual Representation**: LLM은 자연어로 이해하고, 이미지 생성은 SDXL 태그 사용
- **유연성**: 사용자가 자연어로 입력하면 SDXL Transformer가 태그 생성
- **일관성**: 모든 시각적 요소에 동일한 구조 사용
