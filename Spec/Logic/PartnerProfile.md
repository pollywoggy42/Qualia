# Partner Profile

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 개요

파트너 캐릭터의 모든 정보를 담는 데이터 모델.

## 데이터 구조

```dart
class PartnerProfile {
  // Basic Information
  String name;                  // 이름
  int age;                      // 나이
  String gender;                // 성별
  String occupation;            // 직업
  String location;              // 현재 위치
  
  // Visual Appearance
  VisualDescriptor face;        // 얼굴 (설명 + SDXL 태그)
  VisualDescriptor hairstyle;   // 헤어스타일
  VisualDescriptor body;        // 체형
  VisualDescriptor accessories; // 액세서리
  VisualDescriptor outfit;      // 기본 의상 (SFW)
  VisualDescriptor? nsfwOutfit; // NSFW 상황용 의상 (optional)
  
  // Personality
  Personality personality;      // 성격 정보
  String? secret;               // 비밀 (하나만, optional)
  List<String> secretFragments; // 비밀 트리거 키워드 (트라우마 감지용)
  List<String> traumas;         // 트라우마 리스트 (LLM이 감지 시 추가, 영구 보존)
  
  // Emotional State
  PartnerEmotionalState emotionalState;  // 현재 감정 상태
  
  // Physical State
  List<String> physicalState;   // 물리적 상태 (예: ["wet", "blushing", "sweating"])
  
  // Sexual State
  int sexualExperience;         // 성경험 횟수 (0~무한대)
  bool isNSFWAllowed;           // NSFW 상황 허용 여부
  
  // Memory
  List<String> memorySnapshots; // 5턴마다 요약 저장, 최근 5개만 유지
}
```

## 관리 규칙

### Memory 관리
- 5턴마다 대화 요약 생성 → `memorySnapshots`에 추가
- 배열 크기가 5를 초과하면 가장 오래된 것 제거 (FIFO)

### Trauma 관리
- Scenario Generator가 `secret`과 `secretFragments` 생성
- Partner Agent가 대화 중 `secretFragments` 키워드 감지 시 트라우마 트리거
- 감지된 트라우마는 `traumas` 배열에 추가
- 한 번 추가되면 영구 보존 (삭제 불가)

### Sexual State 관리
- `sexualExperience`: NSFW 이벤트 발생 시마다 +1
- `isNSFWAllowed`: Partner Agent가 매 턴 재평가
  - 성격, 감정, 공간, 시간 고려
