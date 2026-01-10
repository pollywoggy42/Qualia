# Visual Director Agent Specification

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 역할

이미지 생성 프롬프트 작성

## 실행 시점

조건부 (Scenario Director가 `shouldGenerateImage: true` 판단 시)

## 입력 데이터

```json
{
  "focusPoint": {
    "userAction": {
      "action": "손을 잡는다",
      "speech": "같이 가자",
      "sdxlTags": "holding hands, reaching out"
    },
    "partnerReaction": {
      "actions": ["얼굴이 빨개지며 손을 꼭 잡는다"],
      "dialogues": ["응... 같이 가자"],
      "innerThought": "심장이 너무 빨리 뛴다...",
      "physicalState": ["blushing"],
      "mood": "Flustered"
    }
  },
  
  "worldState": {
    "currentTime": "2024-01-10T18:30:00",
    "weather": "sunny",
    "userLocation": "park",
    "partnerLocation": "park",
    "currentSituation": {
      "description": "벚꽃이 흩날리는 석양 속을 걷는 중",
      "sdxlTags": "cherry blossoms, sunset, petals falling, romantic walk"
    },
    "ongoingEvent": null,
    "emotionalAtmosphere": "Romantic",
    "turnCount": 15
  },
  
  "characters": {
    "partner": {
      "name": "사쿠라",
      "age": 22,
      "face": {
        "description": "큰 눈과 부드러운 미소",
        "sdxlTags": "cute face, large eyes, soft smile"
      },
      "hairstyle": {
        "description": "금발 포니테일",
        "sdxlTags": "blonde hair, ponytail, long hair"
      },
      "body": {
        "description": "날씬한 체형",
        "sdxlTags": "slender body, petite"
      },
      "accessories": {
        "description": "작은 귀걸이",
        "sdxlTags": "small earrings"
      },
      "outfit": {
        "description": "흰색 블라우스와 검은색 치마",
        "sdxlTags": "white blouse, black skirt, student uniform"
      },
      "nsfwOutfit": {
        "description": "검은색 란제리",
        "sdxlTags": "black lingerie, lace"
      },
      "isNSFWAllowed": false
    },
    "user": {
      "name": "준호",
      "age": 24,
      "face": {
        "description": "친근한 인상",
        "sdxlTags": "friendly face, warm smile"
      },
      "hairstyle": {
        "description": "짧은 검은 머리",
        "sdxlTags": "black hair, short hair"
      },
      "body": {
        "description": "보통 체형",
        "sdxlTags": "average build"
      },
      "accessories": {
        "description": "검은 테 안경",
        "sdxlTags": "black glasses"
      },
      "outfit": {
        "description": "회색 후드티",
        "sdxlTags": "gray hoodie, casual"
      }
    }
  },
  
  "modelPreset": { /* ComfyUIModelPreset */ }
}
```

### 입력 구조 설명

#### 1. focusPoint (최우선)
이미지의 핵심 초점. **User의 선택과 Partner의 즉각 반응**을 담음.

**userAction**:
- `action`: User가 선택한 행위
- `speech`: User의 대사 (맥락 파악용)
- `sdxlTags`: 행위의 SDXL 태그

**partnerReaction**:
- `actions`: Partner의 반응 행동 (배열)
- `dialogues`: Partner의 대사 (배열)
- `innerThought`: 내면 생각 (이미지에는 미반영, 맥락용)
- `physicalState`: 물리적 상태 (blushing, wet 등)
- `mood`: 현재 감정 → 표정 태그로 변환

**철학**: 이미지는 "User가 한 행동의 결과"를 보여줌. 정적인 상태가 아닌 **동적인 순간** 포착.

#### 2. worldState (전체)
세계의 현재 상태. **위치 정보가 핵심**.

**위치 기반 이미지 초점**:
- `userLocation == partnerLocation`: 두 사람이 함께 있는 장면
- `userLocation != partnerLocation`: Partner만 있는 장면 (User는 다른 곳)
  - 예: User가 "전화를 건다" → Partner가 다른 장소에서 전화 받는 모습

**currentSituation**: Scenario Director가 관리하는 현재 상황 (환경 묘사)

#### 3. characters (외모)
Partner와 User의 시각적 특징.

**NSFW 처리**:
- `isNSFWAllowed == true`: `nsfwOutfit` 사용
- `isNSFWAllowed == false`: `outfit` 사용

**위치 분리 시**:
- Partner만 표시 (User는 이미지에 없음)
- User의 정보는 맥락 파악용으로만 사용

## 출력 데이터

```json
{
  "positiveTags": [
    "holding hands",
    "reaching out",
    "gripping hands tightly",
    "blushing",
    "flustered expression",
    "shy smile",
    "cherry blossoms",
    "sunset",
    "petals falling",
    "romantic atmosphere",
    "blonde hair",
    "ponytail",
    "blue eyes",
    "white blouse",
    "black skirt",
    "1girl",
    "1boy"
  ]
}
```

**출력 형식**: 단순 문자열 배열. Negative 프롬프트는 ModelPreset의 기본값 사용.

## 프롬프트 전략

### 4-Way 분기

Visual Director는 위치와 NSFW 여부에 따라 4가지 프롬프트 사용:

```dart
enum VisualDirectorPromptType {
  togetherNormal,    // 같은 위치 + isNSFWAllowed = false
  togetherNSFW,      // 같은 위치 + isNSFWAllowed = true
  soloNormal,        // 다른 위치 + isNSFWAllowed = false
  soloNSFW,          // 다른 위치 + isNSFWAllowed = true
}
```

**분기 로직**:
```dart
bool together = worldState.userLocation == worldState.partnerLocation;
bool nsfw = characters.partner.isNSFWAllowed;

if (together && !nsfw) → togetherNormal
if (together && nsfw) → togetherNSFW
if (!together && !nsfw) → soloNormal
if (!together && nsfw) → soloNSFW
```

---

### 1. Together + Normal (함께, 일반)

**시나리오**: 두 사람이 같은 장소, 일반 상황

**프롬프트 구조**:
```
You are a Visual Director for romantic visual novel images.

# Scene Focus (PRIORITY)
User Action: {userAction.sdxlTags}
Partner Reaction: {partnerReaction.actions[0]}
Partner Mood: {partnerReaction.mood}
Partner Physical State: {partnerReaction.physicalState}

# Environment
Location: {worldState.partnerLocation}
Time: {worldState.currentTime}
Weather: {worldState.weather}
Current Situation: {currentSituation.sdxlTags}
Atmosphere: {emotionalAtmosphere}

# Characters
Partner: {partner.face.sdxlTags}, {partner.hairstyle.sdxlTags}, {partner.body.sdxlTags}, {partner.accessories.sdxlTags}, {partner.outfit.sdxlTags}
User: {user.face.sdxlTags}, {user.hairstyle.sdxlTags}, {user.body.sdxlTags}, {user.accessories.sdxlTags}, {user.outfit.sdxlTags}

# Mood to Expression Guide
- Happy → bright smile, sparkling eyes
- Flustered → blushing, shy smile, averting eyes
- Anxious → worried expression, tense posture
- Horny → sultry gaze, parted lips, flushed cheeks

# Instructions
- Focus on the MOMENT of interaction between two people
- Emphasize emotional connection and chemistry
- Convert mood to appropriate facial expressions
- Physical state affects appearance (blushing, wet, etc.)
- Both characters should be visible
- Seductive/alluring content is acceptable

Output: JSON array of SDXL tags
```

---

### 2. Together + NSFW (함께, 성인)

**시나리오**: 두 사람이 같은 장소, 성인 상황

**프롬프트 구조**:
```
You are a Visual Director for adult romantic visual novel images.

# Scene Focus (PRIORITY)
User Action: {userAction.sdxlTags}
Partner Reaction: {partnerReaction.actions[0]}
Partner Mood: {partnerReaction.mood}
Partner Physical State: {partnerReaction.physicalState}

# Environment
Location: {worldState.partnerLocation}
Time: {worldState.currentTime}
Weather: {worldState.weather}
Current Situation: {currentSituation.sdxlTags}
Atmosphere: {emotionalAtmosphere}

# Characters
Partner: {partner.face.sdxlTags}, {partner.hairstyle.sdxlTags}, {partner.body.sdxlTags}, {partner.accessories.sdxlTags}, {partner.nsfwOutfit.sdxlTags}
User: {user.face.sdxlTags}, {user.hairstyle.sdxlTags}, {user.body.sdxlTags}, {user.accessories.sdxlTags}, {user.outfit.sdxlTags}

# Mood to Expression Guide
(동일)

# Instructions
- Focus on the intimate MOMENT between two people
- Balance explicit content with emotional expression
- Partner's mood is crucial even in explicit scenes
- Both characters should be visible
- Incorporate physical states naturally

Output: JSON array of SDXL tags
```

---

### 3. Solo + Normal (파트너만, 일반)

**시나리오**: Partner만 있는 장소, 일반 상황

**프롬프트 구조**:
```
You are a Visual Director for romantic visual novel images.

# Scene Focus (PRIORITY)
Partner Reaction: {partnerReaction.actions[0]}
Partner Mood: {partnerReaction.mood}
Partner Physical State: {partnerReaction.physicalState}

# Context
User Action (off-screen): {userAction.action}
(User is at {worldState.userLocation}, NOT in this image)
(Partner is at {worldState.partnerLocation})

# Environment
Location: {worldState.partnerLocation}
Time: {worldState.currentTime}
Weather: {worldState.weather}
Current Situation: {currentSituation.sdxlTags}
Atmosphere: {emotionalAtmosphere}

# Character (Partner ONLY)
{partner.face.sdxlTags}, {partner.hairstyle.sdxlTags}, {partner.body.sdxlTags}, {partner.accessories.sdxlTags}, {partner.outfit.sdxlTags}

# Mood to Expression Guide
(동일)

# Instructions
- Show ONLY the Partner
- Partner is reacting to User's action (e.g., receiving a phone call)
- Focus on Partner's emotional state and reaction
- User is NOT visible in the image

Output: JSON array of SDXL tags
```

---

### 4. Solo + NSFW (파트너만, 성인)

**시나리오**: Partner만 있는 장소, 성인 상황

**프롬프트 구조**:
```
You are a Visual Director for adult romantic visual novel images.

# Scene Focus (PRIORITY)
Partner Reaction: {partnerReaction.actions[0]}
Partner Mood: {partnerReaction.mood}
Partner Physical State: {partnerReaction.physicalState}

# Context
User Action (off-screen): {userAction.action}
(User is at {worldState.userLocation}, NOT in this image)
(Partner is at {worldState.partnerLocation})

# Environment
Location: {worldState.partnerLocation}
Time: {worldState.currentTime}
Weather: {worldState.weather}
Current Situation: {currentSituation.sdxlTags}
Atmosphere: {emotionalAtmosphere}

# Character (Partner ONLY)
{partner.face.sdxlTags}, {partner.hairstyle.sdxlTags}, {partner.body.sdxlTags}, {partner.accessories.sdxlTags}, {partner.nsfwOutfit.sdxlTags}

# Mood to Expression Guide
(동일)

# Instructions
- Show ONLY the Partner
- Partner is in an intimate state, reacting to User
- Focus on Partner's emotional and physical state
- User is NOT visible in the image

Output: JSON array of SDXL tags
```

---

## 핵심 책임

### 프롬프트 생성 우선순위

1. **Focus Point** (가장 중요): User 행위 + Partner 반응
2. **Environment**: 배경, 분위기
3. **Characters**: 외모, 의상
4. **Quality Tags**: ModelPreset의 기본 태그

### 세부 책임

1. **동적 순간 포착**: 정적 상태가 아닌 행위의 순간 시각화
2. **User 선택 가시화**: "내가 이렇게 했더니 파트너가 이렇게 반응했구나"
3. **감정 표현**: mood와 physicalState를 표정/자세로 변환
4. **맥락 유지**: 환경은 배경으로, 행위는 전경으로
5. **카테고리별 형식**: SDXL vs Pony 프롬프트 형식 조정
6. **위치 기반 구성**: Together vs Solo 자동 판단

## 추천 LLM 모델

- **모델**: Grok 4.1 Fast
- **Temperature**: 0.5
- **Max Tokens**: 1000
- **이유**: SDXL 태그 생성 정확도
