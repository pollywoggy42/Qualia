# Qualia Data Models Design

> **Last Updated**: 2026-01-10  
> **Status**: Design Phase

## 목차

1. [개요](#개요)
2. [핵심 설계 원칙](#핵심-설계-원칙)
3. [데이터 모델 상세](#데이터-모델-상세)
4. [ComfyUI Model Preset 시스템](#comfyui-model-preset-시스템)
5. [상태 관리 전략](#상태-관리-전략)
6. [Agent 간 데이터 흐름](#agent-간-데이터-흐름)

---

## 개요

Qualia의 데이터 모델은 LLM 기반 에이전트들이 효과적으로 상호작용하고, 일관된 세계관과 캐릭터 상태를 유지하기 위해 설계되었습니다. 이 문서는 Partner, User, World State, Narrative Context, ComfyUI Preset의 구조와 상호작용 방식을 정의합니다.

### 주요 개선 사항

- **Partner 감정 축 확장**: Trust, Dominance 추가
- **VisualDescriptor 구조**: 자연어 설명 + SDXL 태그 쌍으로 관리
- **위치 정보 분산**: User/Partner 객체 내부로 이동
- **Narrative Context 레이어**: 서사적 상태 변화 추적 및 자동 만료 관리
- **ComfyUI Model Preset**: 세션별 모델 선택 및 프롬프트 템플릿 관리
- **Personality 객체 통합**: Partner/User 공통 성격 구조
- **NSFW Outfit 분리**: 상황별 의상 정보 최적화

---

## 핵심 설계 원칙

### 1. Dual Representation (이중 표현)

모든 시각적 요소는 **자연어 설명**과 **SDXL 태그**를 함께 관리합니다.

- **자연어**: LLM이 이해하고 추론하는 데 사용
- **SDXL 태그**: 이미지 생성에 직접 사용
- **UI 워크플로우**: 유저가 자연어 입력 → LLM이 SDXL 태그 자동 생성

### 2. Separation of Concerns (관심사 분리)

- **물리적 상태**: 위치, 복장, 날씨 등 객관적 사실
- **감정적 상태**: Affection, Trust, Arousal, Dominance, Mood
- **서사적 상태**: 진행 중인 이벤트, 분위기, 시각적 효과

### 3. Temporal State Management (시간적 상태 관리)

상태 변화는 명확한 **생명주기**를 가집니다:

- **Instant**: 한 턴만 유효
- **Short-term**: 3-5턴 지속
- **Medium-term**: 시간/장소 변경까지
- **Persistent**: 명시적 제거 전까지 유지

---

## 데이터 모델 상세

### 0. ComfyUI Model Preset

세션별로 사용할 이미지 생성 모델과 기본 프롬프트를 관리합니다.

```dart
class ComfyUIModelPreset {
  String id;                    // 프리셋 고유 ID
  String name;                  // 프리셋 이름 (예: "Realistic Style", "Anime Style")
  
  // ===== Model Configuration =====
  String checkpointModel;       // SDXL 체크포인트 파일명
  String? vae;                  // VAE 파일명 (optional)
  List<LoRAConfig> loras;       // LoRA 리스트
  
  // ===== Default Prompts =====
  String defaultPositive;       // 기본 Positive Prompt
  String defaultNegative;       // 기본 Negative Prompt
  
  // ===== Metadata =====
  bool isBuiltIn;               // 기본 제공 템플릿 여부
  DateTime createdAt;
  DateTime? modifiedAt;
  
  ComfyUIModelPreset({
    required this.id,
    required this.name,
    required this.checkpointModel,
    this.vae,
    this.loras = const [],
    this.defaultPositive = '',
    this.defaultNegative = '',
    this.isBuiltIn = false,
    required this.createdAt,
    this.modifiedAt,
  });
}

class LoRAConfig {
  String fileName;              // LoRA 파일명
  double weight;                // 가중치 (0.0 ~ 1.0)
  
  LoRAConfig({
    required this.fileName,
    this.weight = 0.8,
  });
}
```

#### 기본 제공 템플릿

```dart
// 1. Realistic Style
ComfyUIModelPreset realisticPreset = ComfyUIModelPreset(
  id: 'preset_realistic',
  name: 'Realistic Style',
  checkpointModel: 'realisticVisionV60B1_v51VAE.safetensors',
  vae: null,  // 모델에 VAE 포함
  loras: [],
  defaultPositive: 'masterpiece, best quality, ultra detailed, photorealistic, 8k uhd, dslr, soft lighting, high quality',
  defaultNegative: 'cartoon, anime, illustration, painting, drawing, art, sketch, (worst quality, low quality, normal quality:1.4), lowres, blurry, text, watermark',
  isBuiltIn: true,
  createdAt: DateTime.now(),
);

// 2. Anime Style
ComfyUIModelPreset animePreset = ComfyUIModelPreset(
  id: 'preset_anime',
  name: 'Anime Style',
  checkpointModel: 'animagineXLV3_v30.safetensors',
  vae: null,
  loras: [
    LoRAConfig(fileName: 'add_detail.safetensors', weight: 0.5),
  ],
  defaultPositive: 'masterpiece, best quality, very aesthetic, absurdres, newest, anime coloring',
  defaultNegative: '(worst quality, low quality:1.4), greyscale, zombie, sketch, interlocked fingers, comic',
  isBuiltIn: true,
  createdAt: DateTime.now(),
);

// 3. Semi-realistic (Hybrid)
ComfyUIModelPreset semiRealisticPreset = ComfyUIModelPreset(
  id: 'preset_semi_realistic',
  name: 'Semi-Realistic Style',
  checkpointModel: 'ponyDiffusionV6XL_v6.safetensors',
  vae: null,
  loras: [
    LoRAConfig(fileName: 'realistic_skin.safetensors', weight: 0.6),
  ],
  defaultPositive: 'score_9, score_8_up, score_7_up, masterpiece, best quality, detailed',
  defaultNegative: 'score_6, score_5, score_4, worst quality, low quality, text, censored',
  isBuiltIn: true,
  createdAt: DateTime.now(),
);
```

#### 세션 통합

```dart
class ChatSession {
  String id;
  PartnerProfile partner;
  UserProfile user;
  WorldState worldState;
  
  // ===== ComfyUI Preset =====
  ComfyUIModelPreset modelPreset;  // 이 세션에서 사용할 모델 프리셋
  
  ChatSession({
    required this.id,
    required this.partner,
    required this.user,
    required this.worldState,
    required this.modelPreset,  // 세션 생성 시 선택
  });
}
```

#### UI 플로우

```
세션 생성 화면
  ↓
[Partner 설정]
  ↓
[ComfyUI Model Preset 선택]
  - 기본 템플릿 (Realistic / Anime / Semi-Realistic)
  - 커스텀 프리셋 (사용자가 저장한 것)
  - [+ 새 프리셋 만들기]
  ↓
[프리셋 편집 (Optional)]
  - Checkpoint Model 선택
  - LoRA 추가/제거
  - Default Positive/Negative 수정
  - [저장] → 커스텀 프리셋으로 저장
  ↓
[세션 시작]
```

---

### 1. VisualDescriptor

모든 시각적 요소의 기본 단위입니다.

```dart
class VisualDescriptor {
  String description;      // 자연어 설명 (유저 입력)
  String sdxlTags;        // SDXL 태그 (LLM 생성)
  
  VisualDescriptor({
    required this.description,
    this.sdxlTags = '',
  });
  
  // LLM을 통한 태그 생성
  Future<void> generateTags(LLMService llm) async {
    sdxlTags = await llm.convertToSDXLTags(description);
  }
}
```

**사용 예시:**

```dart
// 유저 입력
VisualDescriptor face = VisualDescriptor(
  description: "큰 눈을 가진 귀여운 동안",
);

// Generate 버튼 클릭 시
await face.generateTags(llmService);
// → sdxlTags: "baby face, large eyes, cute, youthful"
```

---

### 2. Personality

Partner와 User 모두 사용하는 공통 성격 구조입니다.

```dart
class Personality {
  String mbti;                  // MBTI 또는 Big 5
  String speechStyle;           // 말투 (Few-shot 예시 필요)
                                // 예: "반말", "존댓말", "사투리", "아가씨 말투"
  List<String> coreValues;      // 가치관
                                // 예: ["가족", "성공", "자유", "정의"]
  List<String> traits;          // 성격 특성
                                // 예: ["내향적", "논리적", "감정적", "즉흥적"]
  
  Personality({
    this.mbti = 'INFP',
    this.speechStyle = '반말',
    this.coreValues = const [],
    this.traits = const [],
  });
}
```

---

### 3. Partner Profile

```dart
class PartnerProfile {
  // ===== Basic Information =====
  String name;
  int age;
  String gender;
  String occupation;
  String location;              // 현재 위치 (Partner 소유)
  
  // ===== Visual Appearance =====
  VisualDescriptor face;
  VisualDescriptor hairstyle;
  VisualDescriptor body;
  VisualDescriptor accessories;
  
  // ===== Outfit (상황별 분리) =====
  VisualDescriptor outfit;          // 기본 SFW 의상
  VisualDescriptor? nsfwOutfit;     // NSFW 상황용 의상 (optional)
                                     // 예: "naked", "lingerie", "partially clothed"
  
  // ===== Personality =====
  Personality personality;
  List<String> secrets;         // 비밀/트라우마
  
  // ===== Emotional State =====
  PartnerEmotionalState emotionalState;
  
  // ===== Physical State =====
  List<String> physicalState;   // ["wet", "disheveled", "blushing", "sweating"]
  
  // ===== Memory =====
  String memorySummary;         // 대화 요약본 (emotional state에서 이동)
  
  PartnerProfile({
    required this.name,
    required this.age,
    required this.gender,
    required this.occupation,
    required this.location,
    required this.face,
    required this.hairstyle,
    required this.body,
    required this.accessories,
    required this.outfit,
    this.nsfwOutfit,
    required this.personality,
    this.secrets = const [],
    required this.emotionalState,
    this.physicalState = const [],
    this.memorySummary = '',
  });
}
```

**주요 변경사항:**

1. ✅ `Personality` 객체 사용
2. ✅ `currentOutfit` → `outfit`으로 변경, Visual Appearance 섹션으로 이동
3. ✅ `nsfwOutfit` 추가 (NSFW 상황용 별도 관리)
4. ✅ `preferredFetishes`, `avoidedFetishes` 제거 (Partner는 페티시 정보 불필요)
5. ✅ `memorySummary` emotional state에서 Partner Profile로 이동

---

### 4. User Profile

```dart
class UserProfile {
  // ===== Basic Information =====
  String name;
  String gender;
  int age;
  String location;              // 현재 위치 (User 소유)
  
  // ===== Visual Appearance =====
  VisualDescriptor face;
  VisualDescriptor hairstyle;
  VisualDescriptor body;
  VisualDescriptor accessories;
  
  // ===== Outfit (상황별 분리) =====
  VisualDescriptor outfit;          // 기본 SFW 의상
  VisualDescriptor? nsfwOutfit;     // NSFW 상황용 의상 (optional)
  
  // ===== Personality =====
  Personality personality;
  
  // ===== Preferences =====
  List<VisualDescriptor> fetishes;  // 유저의 성적 취향
                                     // description + sdxlTags 쌍으로 관리
  
  // ===== Physical State =====
  List<String> physicalState;       // 유저도 상태 변화 가능
                                     // ["sweating", "exhausted", "aroused"]
  
  UserProfile({
    required this.name,
    required this.gender,
    required this.age,
    required this.location,
    required this.face,
    required this.hairstyle,
    required this.body,
    required this.accessories,
    required this.outfit,
    this.nsfwOutfit,
    required this.personality,
    this.fetishes = const [],
    this.physicalState = const [],
  });
}
```

**Outfit 사용 로직:**

```dart
// Visual Director에서 이미지 생성 시
String getOutfitTags(PartnerProfile partner, bool isNSFW) {
  if (isNSFW && partner.nsfwOutfit != null) {
    return partner.nsfwOutfit!.sdxlTags;  // NSFW 전용 의상 사용
  }
  return partner.outfit.sdxlTags;  // 기본 의상 사용
}

// 예시
// SFW: "white blouse, black skirt, office attire"
// NSFW: "naked, nude, completely naked" (의상 태그 최소화)
```

---

### 5. PartnerEmotionalState

```dart
class PartnerEmotionalState {
  // ===== 장기적 관계 축 =====
  int affection;        // 0-100: 호감도, 관계 진전도
  int trust;            // 0-100: 신뢰도 (새로 추가)
                        // → Affection과 독립적 (매력적이지만 믿을 수 없는 캐릭터 가능)
  
  // ===== 즉각적 상태 축 =====
  int arousal;          // 0-100: 성적 흥분도
  int dominance;        // -100 ~ +100: S/M 성향 (새로 추가)
                        // → 음수: Submissive, 양수: Dominant, 0: Switch
  
  String mood;          // 현재 감정: "Happy", "Anxious", "Horny", "Jealous", "Angry"
                        // → LLM의 어조(Tone) 결정에 핵심
  
  PartnerEmotionalState({
    this.affection = 50,
    this.trust = 50,
    this.arousal = 0,
    this.dominance = 0,
    this.mood = "Neutral",
  });
}
```

**설계 근거:**

| 축 | 범위 | 변화 속도 | 용도 |
|---|---|---|---|
| `affection` | 0-100 | 느림 | 이벤트 해금, 관계 진전 |
| `trust` | 0-100 | 느림 | 대화 깊이, 비밀 공유 |
| `arousal` | 0-100 | 빠름 | NSFW 상황 트리거 |
| `dominance` | -100~+100 | 중간 | 상호작용 스타일, 체위 선택 |
| `mood` | String | 매우 빠름 | 즉각적인 대사 톤 |

---

### 6. World State

```dart
class WorldState {
  // ===== 물리적 환경 =====
  DateTime currentTime;         // 현재 시간
  String weather;               // 날씨: "sunny", "rainy", "snowy", "cloudy"
  
  // ===== 서사적 컨텍스트 =====
  NarrativeContext narrative;   // 진행 중인 이벤트 및 효과
  
  // ===== 메타 정보 =====
  int turnCount;                // 현재 턴 수 (상태 만료 판단용)
  
  WorldState({
    required this.currentTime,
    this.weather = "sunny",
    required this.narrative,
    this.turnCount = 0,
  });
  
  // 턴 진행 시 호출
  void advanceTurn() {
    turnCount++;
    narrative.cleanupExpiredEffects(
      currentTurn: turnCount,
      currentTime: currentTime,
    );
  }
}
```

**설계 변경 사항:**

- ❌ `userLocation`, `partnerLocation` 제거 → 각 Profile 내부로 이동
- ✅ `NarrativeContext` 추가 → 서사적 상태 관리
- ✅ `turnCount` 추가 → 효과 만료 판단 기준

---

### 6. NarrativeContext

```dart
class NarrativeContext {
  List<NarrativeEffect> activeEffects;    // 현재 활성화된 효과들
  String emotionalAtmosphere;             // 전체적인 분위기
                                          // "Tense", "Intimate", "Playful", "Melancholic"
  
  NarrativeContext({
    this.activeEffects = const [],
    this.emotionalAtmosphere = "Neutral",
  });
  
  // 새 효과 추가
  void addEffect(NarrativeEffect effect) {
    activeEffects.add(effect);
  }
  
  // 효과 제거 (명시적)
  void removeEffect(String effectId) {
    activeEffects.removeWhere((e) => e.id == effectId);
  }
  
  // 만료된 효과 자동 정리
  void cleanupExpiredEffects({
    required int currentTurn,
    required DateTime currentTime,
  }) {
    activeEffects.removeWhere((effect) => effect.isExpired(
      currentTurn: currentTurn,
      currentTime: currentTime,
    ));
  }
  
  // Visual Director용 통합 태그 추출
  List<String> getAllVisualCues() {
    return activeEffects
        .expand((effect) => effect.visualCues)
        .toSet()
        .toList();
  }
}
```

---

### 7. NarrativeEffect

```dart
class NarrativeEffect {
  String id;                    // 고유 ID (UUID)
  EffectType type;              // 효과 유형
  String description;           // 자연어 설명
  List<String> visualCues;      // SDXL 태그 힌트
  
  // 생명주기 관리
  int createdAtTurn;            // 생성된 턴
  DateTime createdAtTime;       // 생성된 시간
  EffectDuration duration;      // 지속 기간 유형
  
  // 만료 조건 (duration에 따라 사용)
  String? expiresAtLocation;    // 장소 변경 시 만료
  int? expiresAfterTurns;       // N턴 후 만료
  
  NarrativeEffect({
    required this.id,
    required this.type,
    required this.description,
    required this.visualCues,
    required this.createdAtTurn,
    required this.createdAtTime,
    required this.duration,
    this.expiresAtLocation,
    this.expiresAfterTurns,
  });
  
  // 만료 여부 판단
  bool isExpired({
    required int currentTurn,
    required DateTime currentTime,
  }) {
    switch (duration) {
      case EffectDuration.instant:
        return currentTurn > createdAtTurn;
      
      case EffectDuration.shortTerm:
        return currentTurn > createdAtTurn + (expiresAfterTurns ?? 5);
      
      case EffectDuration.mediumTerm:
        // 장소 변경 또는 시간 경과로 만료
        // (장소 변경 체크는 외부에서 처리)
        return false;
      
      case EffectDuration.persistent:
        return false;  // 명시적 제거만 가능
    }
  }
}

enum EffectType {
  environmental,    // 환경적 효과: 비, 눈, 어둠
  physical,         // 물리적 효과: 옷 젖음, 땀, 상처
  emotional,        // 감정적 효과: 긴장감, 설렘, 불안
  narrative,        // 서사적 효과: 플롯 포인트, 복선
}

enum EffectDuration {
  instant,          // 한 턴만 (다음 턴에 자동 제거)
  shortTerm,        // 3-5턴 지속
  mediumTerm,       // 시간/장소 변경까지
  persistent,       // 명시적 제거 전까지
}
```

---

## 상태 관리 전략

### 1. 효과 생명주기 예시

#### 시나리오: "갑자기 비가 내림"

```dart
// ===== 턴 1: Scenario Director가 비 시작 =====
worldState.narrative.addEffect(NarrativeEffect(
  id: uuid(),
  type: EffectType.environmental,
  description: "Heavy rain started pouring",
  visualCues: ["rain", "wet_ground", "dark_clouds"],
  createdAtTurn: worldState.turnCount,
  createdAtTime: worldState.currentTime,
  duration: EffectDuration.mediumTerm,
  expiresAtLocation: "indoor",  // 실내로 들어가면 만료
));

worldState.weather = "rainy";

// ===== 턴 2: Partner 반응 + 옷 젖음 =====
// Partner: "비다! 우산이 없어!"
partner.emotionalState.mood = "Flustered";

worldState.narrative.addEffect(NarrativeEffect(
  id: uuid(),
  type: EffectType.physical,
  description: "Partner's white shirt is getting soaked",
  visualCues: ["wet_clothes", "see-through", "dripping", "white_shirt"],
  createdAtTurn: worldState.turnCount,
  createdAtTime: worldState.currentTime,
  duration: EffectDuration.mediumTerm,
  expiresAtLocation: "home",  // 집에 가서 옷 갈아입으면 만료
));

partner.physicalState.add("wet");
partner.currentOutfit = "wet_white_shirt";

// ===== 턴 3: Visual Director 이미지 생성 =====
List<String> allCues = worldState.narrative.getAllVisualCues();
// → ["rain", "wet_ground", "dark_clouds", "wet_clothes", "see-through", "dripping", "white_shirt"]

String sdxlPrompt = generateSDXLPrompt(
  partner: partner,
  user: user,
  visualCues: allCues,
);
// → "1girl, wet clothes, see-through, white shirt, rain, outdoor, ..."

// ===== 턴 7: 실내로 이동 =====
partner.location = "cafe";
user.location = "cafe";

// 환경 효과 만료 (비는 밖에서만)
worldState.narrative.removeEffect(rainEffectId);

// 하지만 "옷 젖음"은 여전히 유지 (아직 갈아입지 않음)
// → visualCues: ["wet_clothes", "see-through", "white_shirt"]

// ===== 턴 10: 집에 도착, 옷 갈아입음 =====
partner.location = "home";
partner.currentOutfit = "dry_casual_clothes";
partner.physicalState.remove("wet");

// 옷 젖음 효과 만료
worldState.narrative.removeEffect(wetClothesEffectId);
```

---

### 2. 자동 정리 vs 명시적 제거

| 상황 | 방식 | 예시 |
|---|---|---|
| 한 턴짜리 효과 | 자동 정리 | "순간적인 표정 변화" |
| 짧은 이벤트 | 자동 정리 (5턴) | "약간의 긴장감" |
| 장소 의존 효과 | 조건부 자동 | "비에 젖음" (실내 이동 시) |
| 플롯 포인트 | 명시적 제거 | "비밀을 알게 됨" (해결 전까지) |

---

### 3. Scenario Director의 역할

Scenario Director는 **World Manager**를 겸임합니다:

1. **환경 변화 결정**: 날씨, 시간 변경
2. **이벤트 발생**: 새로운 NarrativeEffect 추가
3. **영향 서술**: 이벤트가 캐릭터에 미치는 영향 묘사
4. **상태 업데이트**: WorldState, Partner/User 상태 수정
5. **효과 제거**: 서사적으로 해결된 효과 명시적 제거
6. **위치 변화 감지 및 처리**: 대화 맥락을 보고 캐릭터 위치 변경 판단

#### 위치 변화 처리 (Location Change Management)

Scenario Director는 User와 Partner의 대화를 분석하여 **암묵적인 위치 변경**을 감지하고 처리합니다.

**예시 시나리오:**

```
User: "그럼 다음에 봐, 연락할게!"
Partner: "응, 기다릴게. 조심히 가!"

→ Scenario Director 판단:
  - 이별 인사 감지
  - User.location: "partner_home" → "user_home"
  - Partner.location: "partner_home" (유지)
  - 서술: "당신은 파트너의 집을 나와 집으로 향했다. 파트너는 문 앞에서 손을 흔들며 당신을 배웅했다."
```

**프롬프트 설계 전략:**

```markdown
# Scenario Director System Prompt (위치 관리 부분)

## Location Change Detection

대화 내용을 분석하여 다음 상황에서 위치 변경을 감지하고 처리하세요:

### 명시적 위치 변경
- "집에 가자", "카페로 가자", "밖으로 나가자" 등 직접적인 이동 제안
- "도착했어", "여기 왔어" 등 이동 완료 표현

### 암묵적 위치 변경
- 이별 인사: "다음에 봐", "안녕", "조심히 가" 등
  → User와 Partner가 각자의 위치로 분리
- 시간 경과 암시: "다음 날", "몇 시간 후" 등
  → 상황에 맞는 위치로 자동 이동
- 활동 종료: "그럼 이만", "오늘은 여기까지" 등
  → 각자의 기본 위치로 복귀

### 위치 변경 시 처리 사항

1. **User.location 업데이트**
2. **Partner.location 업데이트** (함께 이동하는 경우만)
3. **NarrativeEffect 정리**:
   - `expiresAtLocation`이 설정된 효과들 확인
   - 새 위치와 맞지 않으면 제거
4. **Outfit 변경 고려**:
   - 실내 ↔ 실외 이동 시 의상 변경 가능성 판단
   - 시간 경과 시 (다음 날 등) 의상 변경
5. **서술 생성**:
   - 이동 과정을 자연스럽게 묘사
   - 새로운 장소의 분위기 설정

### JSON Response Format

```json
{
  "narration": "당신은 파트너의 집을 나와 집으로 향했다...",
  "locationChanges": {
    "userLocation": "user_home",
    "partnerLocation": "partner_home"
  },
  "timeChange": null,  // 또는 "2024-01-11T09:00:00"
  "effectsToRemove": ["effect_id_1", "effect_id_2"],
  "outfitChanges": {
    "partner": "casual_home_clothes"  // optional
  }
}
```

### 위치 추론 규칙

| 대화 패턴 | User 위치 | Partner 위치 | 비고 |
|---|---|---|---|
| 이별 인사 | user_home | partner_home | 각자 집으로 |
| "우리 집에 가자" | user_home | user_home | 함께 이동 |
| "네 집에 갈게" | partner_home | partner_home | 함께 이동 |
| "밖에서 만나자" | outdoor/cafe | outdoor/cafe | 만남 장소 |
| "다음 날 아침" | user_home | partner_home | 시간 경과 |
```

**구현 시 고려사항:**

1. **컨텍스트 윈도우**: 최근 3-5턴의 대화를 함께 분석
2. **애매한 경우**: 위치 변경하지 않고 현재 위치 유지 (보수적 접근)
3. **검증**: 위치 변경 후 Partner의 다음 대사가 자연스러운지 확인
4. **사용자 피드백**: 위치 변경이 이상하면 사용자가 수정할 수 있는 UI 제공 (향후)

---

## Agent 간 데이터 흐름

### 전체 아키텍처

```
┌─────────────────────────────────────────┐
│      Scenario Director                  │
│   (World Manager + Narrator)            │
│                                         │
│  - 환경 변화 (날씨, 시간)                │
│  - 이벤트 발생 (NarrativeEffect 추가)   │
│  - 영향 서술                            │
│  - WorldState 업데이트                  │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│            WorldState                   │
│                                         │
│  - currentTime, weather                 │
│  - NarrativeContext                     │
│    └─ activeEffects[]                   │
│    └─ emotionalAtmosphere               │
└─────────────────────────────────────────┘
                    │
        ┌───────────┴───────────┐
        ▼                       ▼
┌──────────────┐        ┌──────────────┐
│   Partner    │        │   Visual     │
│              │        │   Director   │
│ - 반응 생성   │        │              │
│ - 감정 변화   │        │ - SDXL 생성  │
│ - 상태 변화   │        │ - 시각화     │
└──────────────┘        └──────────────┘
        │                       ▲
        └───────────┬───────────┘
                    ▼
            ┌──────────────┐
            │  Strategist  │
            │              │
            │ - 선택지 생성 │
            └──────────────┘
```

### 턴 진행 시퀀스

```
1. User 입력
   ↓
2. Partner 반응
   - PartnerEmotionalState 업데이트
   - physicalState 변경 가능
   ↓
3. Scenario Director 서술
   - 대화 맥락 분석 → 위치 변경 감지
   - User/Partner location 업데이트 (필요시)
   - NarrativeEffect 추가/제거
   - WorldState 업데이트
   - Outfit 변경 고려 (위치/시간 변화 시)
   - 이미지 생성 필요 여부 결정
   ↓
4. Visual Director (조건부)
   - WorldState.narrative.getAllVisualCues()
   - Partner/User VisualDescriptor 참조
   - Outfit 선택 (SFW vs NSFW)
   - ComfyUI ModelPreset 적용
   - SDXL 프롬프트 생성 → 이미지
   ↓
5. Strategist 선택지 생성
   - 모든 상태 참조
   - User.fetishes 고려
   - 현재 위치/상황에 맞는 선택지
   ↓
6. User 선택 대기
   ↓
7. WorldState.advanceTurn()
   - turnCount++
   - 만료된 효과 자동 정리
```

---

## 구현 시 고려사항

### 1. 데이터 직렬화

모든 모델은 JSON 직렬화를 지원해야 합니다:

```dart
class PartnerProfile {
  // ...
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
    'emotionalState': emotionalState.toJson(),
    'physicalState': physicalState,
    // ...
  };
  
  factory PartnerProfile.fromJson(Map<String, dynamic> json) {
    return PartnerProfile(
      name: json['name'],
      age: json['age'],
      emotionalState: PartnerEmotionalState.fromJson(json['emotionalState']),
      physicalState: List<String>.from(json['physicalState']),
      // ...
    );
  }
}
```

### 2. LLM 프롬프트 통합

각 Agent는 필요한 상태만 선택적으로 프롬프트에 포함:

```dart
String buildPartnerPrompt(PartnerProfile partner, WorldState world) {
  return '''
# Partner Identity
Name: ${partner.name}
Occupation: ${partner.occupation}
Location: ${partner.location}

# Emotional State
Affection: ${partner.emotionalState.affection}/100
Trust: ${partner.emotionalState.trust}/100
Arousal: ${partner.emotionalState.arousal}/100
Dominance: ${partner.emotionalState.dominance} (${partner.emotionalState.dominance > 0 ? 'Dominant' : 'Submissive'})
Current Mood: ${partner.emotionalState.mood}

# Physical State
Outfit: ${partner.currentOutfit}
Condition: ${partner.physicalState.join(', ')}

# Current Situation
Time: ${world.currentTime}
Weather: ${world.weather}
Atmosphere: ${world.narrative.emotionalAtmosphere}
Active Effects: ${world.narrative.activeEffects.map((e) => e.description).join(', ')}
''';
}
```

### 3. 성능 최적화

- **효과 개수 제한**: activeEffects는 최대 20개로 제한
- **자동 정리**: 매 턴마다 `cleanupExpiredEffects()` 호출
- **인덱싱**: effectId로 빠른 검색 가능하도록 Map 사용 고려

---

## 다음 단계

### Phase 1: 핵심 모델 구현
- [ ] Dart 모델 클래스 구현
  - [ ] `VisualDescriptor`
  - [ ] `Personality`
  - [ ] `PartnerProfile` / `UserProfile`
  - [ ] `PartnerEmotionalState`
  - [ ] `ComfyUIModelPreset` / `LoRAConfig`
  - [ ] `WorldState` / `NarrativeContext` / `NarrativeEffect`
- [ ] JSON 직렬화/역직렬화 구현 및 테스트

### Phase 2: UI 구현
- [ ] VisualDescriptor Generate 버튼 (LLM 태그 생성)
- [ ] ComfyUI Preset 관리 화면
  - [ ] 기본 템플릿 표시
  - [ ] 커스텀 프리셋 생성/편집/저장
- [ ] 세션 생성 플로우 업데이트
  - [ ] Personality 입력 UI
  - [ ] Outfit (SFW/NSFW) 입력 UI
  - [ ] Model Preset 선택 UI

### Phase 3: Agent 프롬프트 구현
- [ ] Scenario Director 프롬프트
  - [ ] 위치 변경 감지 로직
  - [ ] NarrativeEffect 생성 규칙
  - [ ] Outfit 변경 판단 로직
- [ ] Visual Director 프롬프트
  - [ ] Outfit 선택 로직 (SFW vs NSFW)
  - [ ] ComfyUI Preset 통합
- [ ] Partner 프롬프트
  - [ ] Personality 반영
  - [ ] Emotional State 업데이트 규칙

### Phase 4: 검증 및 최적화
- [ ] NarrativeEffect 자동 정리 로직 검증
- [ ] 위치 변경 감지 정확도 테스트
- [ ] 성능 최적화 (효과 개수 제한, 인덱싱)

---

## 변경 이력

| 날짜 | 변경 내용 |
|---|---|
| 2026-01-10 | 초안 작성: Trust/Dominance 추가, VisualDescriptor 도입, NarrativeContext 설계 |
| 2026-01-10 | 주요 업데이트: ComfyUI Model Preset 시스템, Personality 객체 통합, NSFW Outfit 분리, Scenario Director 위치 관리 기능 추가 |
