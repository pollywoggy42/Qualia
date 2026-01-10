# Visual Director Input Structure

> **Version**: 1.0  
> **Last Updated**: 2026-01-11

## 개요

Visual Director의 입력 데이터 구조. "행위의 순간" 중심 접근법.

## 설계 철학

### 핵심 원칙
1. **User 선택의 가시화**: 이미지는 "내가 한 행동의 결과"를 보여줌
2. **즉각성**: 정적인 상태보다 **동적인 순간** (행위 + 반응)
3. **감정의 시각화**: Partner의 mood와 physicalState가 표정/자세로 드러남
4. **맥락 유지**: 환경(currentSituation)은 배경으로 존재

### 4-Way 프롬프트 전략

위치와 NSFW 여부에 따라 4가지 프롬프트 사용:

| 프롬프트 | 위치 | NSFW | 인원 | 의상 | 강조점 |
|---|---|---|---|---|---|
| Together Normal | 같음 | No | 2명 | outfit | 상호작용, 감정 연결 |
| Together NSFW | 같음 | Yes | 2명 | nsfwOutfit | 친밀한 순간, 감정 유지 |
| Solo Normal | 다름 | No | 1명 | outfit | Partner 반응, 감정 상태 |
| Solo NSFW | 다름 | Yes | 1명 | nsfwOutfit | Partner 친밀 상태 |

**참고**: "Normal"도 유혹적, 섹시할 수 있음. 단지 explicit content 여부만 차이.

## 데이터 구조

```dart
class VisualDirectorInput {
  FocusPoint focusPoint;           // 이미지의 핵심 초점
  SceneContext sceneContext;       // 장면 맥락
  CharacterVisuals characters;     // 캐릭터 외모
  ComfyUIModelPreset modelPreset;  // 모델 설정
}

class FocusPoint {
  UserAction userAction;           // User가 선택한 행위
  PartnerReaction partnerReaction; // Partner의 즉각 반응
}

class UserAction {
  String action;                   // 행위 설명
  String sdxlTags;                 // SDXL 태그
}

class PartnerReaction {
  String action;                   // 첫 번째 반응 행동
  List<String> physicalState;      // 물리적 상태 (blushing, wet 등)
  String mood;                     // 현재 감정
}

class SceneContext {
  VisualDescriptor? currentSituation;  // 현재 상황
  String emotionalAtmosphere;          // 전체 분위기
  String location;                     // 위치
  String timeOfDay;                    // 시간대
  String weather;                      // 날씨
}

class CharacterVisuals {
  PartnerVisuals partner;
  UserVisuals user;
}

class PartnerVisuals {
  VisualDescriptor face;
  VisualDescriptor hairstyle;
  VisualDescriptor body;
  VisualDescriptor accessories;
  VisualDescriptor outfit;
  VisualDescriptor? nsfwOutfit;
  bool isNSFWAllowed;
}

class UserVisuals {
  VisualDescriptor face;
  VisualDescriptor hairstyle;
  VisualDescriptor body;
  VisualDescriptor accessories;
  VisualDescriptor outfit;
}
```

## 레이어 시스템

Visual Director는 정보를 레이어별로 처리:

### Layer 1: Focus Point (최우선)
- User의 action SDXL 태그
- Partner의 reaction action
- Partner의 physicalState
- Partner의 mood → 표정 태그

**예시**:
```
User: "holding hands, reaching out"
Partner: "blushing, gripping hands tightly, flustered expression"
```

### Layer 2: Scene Context (배경)
- currentSituation의 SDXL 태그
- emotionalAtmosphere → 조명/색감
- 위치, 시간대, 날씨

**예시**:
```
"cherry blossoms, sunset, petals falling, romantic atmosphere, warm lighting"
```

### Layer 3: Characters (외모)
- Partner/User의 VisualDescriptor
- Outfit 선택 (isNSFWAllowed 기준)

**예시**:
```
"blonde hair, ponytail, blue eyes, white blouse, black skirt"
```

### Layer 4: Quality Tags (기본)
- ModelPreset의 defaultPositive/Negative
- Category별 형식 조정

## 프롬프트 생성 예시

### 입력
```json
{
  "focusPoint": {
    "userAction": {
      "action": "손을 잡는다",
      "sdxlTags": "holding hands, reaching out"
    },
    "partnerReaction": {
      "action": "얼굴이 빨개지며 손을 꼭 잡는다",
      "physicalState": ["blushing"],
      "mood": "Flustered"
    }
  },
  "sceneContext": {
    "currentSituation": {
      "sdxlTags": "cherry blossoms, sunset, petals falling"
    },
    "emotionalAtmosphere": "Romantic"
  }
}
```

### 출력 (Positive Prompt)
```
holding hands, reaching out, gripping hands tightly, blushing, flustered expression, shy smile,
cherry blossoms, sunset, petals falling, romantic atmosphere, warm lighting,
blonde hair, ponytail, blue eyes, white blouse, black skirt,
1girl, 1boy, masterpiece, best quality
```

**우선순위**: Focus Point → Scene Context → Characters → Quality

## 설계 의도

1. **User 행위의 임팩트**: 선택이 이미지에 직접 반영됨
2. **Partner 반응의 즉각성**: 감정과 물리적 변화가 시각화됨
3. **구조화된 정보**: 레이어별 처리로 명확한 우선순위
4. **유연성**: 각 레이어는 독립적으로 조정 가능
