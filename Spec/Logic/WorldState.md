# World State

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 개요

세계의 물리적 환경 및 서사적 상태.

## 데이터 구조

```dart
class WorldState {
  // 물리적 환경
  DateTime currentTime;         // 현재 시간
  String weather;               // 날씨 (예: "sunny", "rainy", "snowy")
  
  // 서사적 상태 (Scenario Director가 관리)
  VisualDescriptor? currentSituation;  // 현재 상황 (설명 + SDXL 태그)
  String? ongoingEvent;         // 진행 중인 이벤트 (플롯, 복선 등)
  String emotionalAtmosphere;   // 전체 분위기
  
  // 메타 정보
  int turnCount;                // 현재 턴 수
}
```

## Scenario Director의 관리 방식

### currentSituation
- 환경/상황 변화를 설명과 SDXL 태그로 표현
- 계속 유지할 상황이면 그대로 두거나 업데이트
- 상황이 종료되면 null로 설정

### ongoingEvent
- 중요한 서사 이벤트
- 진행 중이면 계속 유지
- 해결되거나 종료되면 null

### emotionalAtmosphere
- 매 턴 업데이트 가능
- 예: "Romantic", "Tense", "Playful"

## 사용 예시

```dart
// 비가 내리기 시작
currentSituation = VisualDescriptor(
  description: "비가 내리고 두 사람의 옷이 점점 젖어가고 있다",
  sdxlTags: "rain, wet clothes, getting soaked"
);

// 몇 턴 후, 비가 그침
currentSituation = null;

// 중요한 이벤트 시작
ongoingEvent = "파트너가 과거의 상처에 대해 말하려 하고 있다";

// 이벤트 해결
ongoingEvent = null;
```
