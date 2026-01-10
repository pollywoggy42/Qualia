# Personality

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 개요

Partner와 User 공통 성격 구조.

## 데이터 구조

```dart
class Personality {
  String mbti;                  // MBTI 성격 유형 (예: "INFP", "ESTJ")
  String speechStyle;           // 말투 스타일 (예: "반말", "존댓말", "사투리")
  List<String> traits;          // 성격 특성 리스트
}
```

## 사용 예시

```dart
Personality(
  mbti: "INFP",
  speechStyle: "존댓말",
  traits: ["내향적", "감성적", "배려심 많음", "창의적"]
);

Personality(
  mbti: "ESTJ",
  speechStyle: "반말",
  traits: ["외향적", "논리적", "계획적", "리더십"]
);
```

## 설계 의도

- Partner와 User 모두 동일한 구조 사용
- LLM이 성격을 일관되게 반영하도록 명확한 특성 제공
- MBTI는 기본 성향, traits는 구체적 특성
