# Qualia: 채팅 UI를 활용한 비쥬얼 노벨 롤플레잉 앱 기획서

## 1. 개요 (Summary)
*   **제품명**: Qualia
*   **플랫폼**: Desktop, iOS, Android, Web (크로스 플랫폼 배포)
*   **핵심 컨셉**: LLM 기반의 에이전트들과 상호작용하며 진행되는 몰입형 비쥬얼 노벨 롤플레잉 게임. 채팅 UI를 기반으로 하며, 실시간 이미지 생성(SDXL) 기능을 통해 시각적 몰입감을 극대화함.

## 2. UX/UI 상세 (UX Description)

### 2.1 탭 구성
앱은 크게 두 가지 탭으로 구성됩니다.
1.  **채팅 (Chat)**
2.  **설정 (Settings)**

### 2.2 채팅 탭 (Chat Tab)
*   **메인 화면 (Empty State)**:
    *   진행 중인 채팅 세션이 없을 경우, 사용자가 새로운 시작을 할 수 있도록 안내 문구를 표시합니다.
*   **새 세션 생성 (+ 버튼)**:
    *   **커스텀 시작**: 파트너(Partner) 페르소나, 유저(User) 페르소나, 초기 상황(Situation)을 직접 설정하여 시작.
    *   **AI 가챠 시작**: AI(LLM)가 임의의 설정과 시나리오를 생성하여 즉시 시작하는 기능.
*   **채팅 인터페이스**:
    *   **디자인**: iPhone iMessage 스타일의 깔끔하고 친숙한 디자인 차용.
    *   **진행 방식**:
        1.  **초기 진입**: 파트너 응답 → 시나리오 감독(Scenario Director) 서술 → (Optional) 비쥬얼 감독(Visual Director) 이미지 생성 → 유저(User) 응답 대기.
        2.  **유저 턴**:
            *   LLM이 현재 상황에 맞는 3~4개의 대사/행동 선택지를 제안.
            *   유저는 선택지를 고르거나, 직접 텍스트를 입력하여 진행 가능.
        3.  **순환**: 유저의 입력 → 파트너 반응 & 시나리오 진행 → 이미지 생성 → 다시 유저 턴.

### 2.3 설정 탭 (Settings Tab)
*   **ComfyUI 설정**:
    *   **연동 방식**: 유저의 로컬 컴퓨터에서 구동되는 ComfyUI 서버(Localhost Port)와 통신.
    *   **제어 패널**: 모델(Model), VAE, 업스케일링(Upscaling), CFG Scale 등 이미지 생성 관련 핵심 파라미터를 앱 내에서 직접 설정.
    *   **UX**: 각 설정 필드에 대한 친절한 설명(Tooltip/Text) 제공.
*   **LLM 설정**:
    *   **API 연동**: OpenRouter API Key 입력 지원.
    *   **모델 선택**: 사용 가능한 LLM 모델 리스트를 불러와 선택 가능.
    *   **에이전트별 설정**: Partner, User, Scenario Director, Visual Director 등 각 역할(Agent)별로 적합한 LLM 모델을 개별 할당 및 설정 가능.
*   **Support**:
    *   **후원 기능**: 'Buy Me a Coffee' 등 개발자 후원 링크 연동.

## 3. 핵심 기능 및 로직 (Core Mechanics)

### 3.1 채팅 경험 (Chat Experience)
*   **실제감 부여 (Realism)**:
    *   실제 사람과 메신저를 하는 듯한 경험 제공.
    *   파트너가 입력 중일 때 '...' 말풍선 애니메이션 표시.
*   **에러 핸들링**:
    *   응답 실패 시 고정 멘트 출력: *"잘 못 들었어. 다시 말해줄래..?"* (API Error로 인지).
    *   사용자가 보낸 마지막 말풍선에 '다시 보내기(Retry)' 버튼 활성화.
*   **파트너 응답 포맷**:
    *   한 번의 턴에 여러 개의 말풍선과 속마음, 행동 지문을 포함.
    *   **구조**:
        *   `행동 지문` (Action)
        *   `대사 1` (Dialogue)
        *   `대사 2` (Optional)
        *   `대사 3` (Optional)
        *   `속마음` (Inner Thought - 유저에게는 보이지 않거나 특정 방식으로 연출 가능)
*   **기억 시스템 (Memory)**:
    *   파트너는 유저와의 대화 중 중요한 내용을 요약하여 장기 기억(Memory)으로 저장 및 유지.

### 3.2 시나리오 디렉터 (Scenario Director - The Writer)
*   **역할**: 제3자 입장에서 상황을 서술하는 '작가' 혹은 '신'의 역할.
*   **기능**:
    *   단순 대화의 나열이 아닌, 비쥬얼 노벨/소설처럼 분위기, 상황, 주변 환경을 서술.
    *   Partner와 User의 대사 외에, 시간의 흐름, 장소 이동, 외부 이벤트 등을 통제하고 서술함.
    *   **목적**: 플롯의 신선함, 카타르시스 제공, 사용자의 몰입과 흥분을 유도(NSFW 포함)하는 중독성 있는 전개 생성.

### 3.3 비쥬얼 디렉터 (Visual Director - The Camera)
*   **역할**: 현재 상황을 시각화하는 '카메라 감독'.
*   **작동 시점**: **시나리오 디렉터가 "이미지 생성이 필요하다"고 판단하여 트리거를 보냈을 때만** 작동.
*   **Core Logic**:
    *   **ComfyUI Workflow**를 활용하여 이미지를 생성.
    *   주요 역할은 상황에 맞는 **SDXL Tag (Positive Prompt)**를 생성하는 것.
    *   **Negative Prompts**는 설정 탭에서 전역적으로 관리되므로 생성하지 않음.
*   **프로세스**:
    1.  **Input 수신**: 시나리오 디렉터로부터 승인된 상황 묘사 및 키워드 수신.
    2.  User의 선택/행동 및 Partner의 리액션 분석.
    3.  World State(시간, Partner의 장소 등) 분석.
    4.  위 정보를 종합하여 Scene에 필요한 **SDXL Tags**만 생성.
    5.  사용자 몰입도(Addiction)와 흥분도 강화를 최우선으로 함.
        *   User 성별/성향에 맞춘 최적의 앵글, 구도, 체위, 연출 적용.
    6.  ComfyUI를 통해 이미지 생성 후 채팅방에 전송.

### 3.4 유저 추론 (User Inference)
*   **역할**: 유저가 다음에 할법한 행동과 대사를 LLM이 미리 추론하여 제안.
*   **기능**:
    *   이미지 생성 및 파트너 응답 직후, 유저가 선택할 수 있는 3~4개의 선택지 생성.
    *   유저는 이를 클릭하여 편하게 진행하거나, 직접 타이핑하여 자유도를 행사.

## 4. 에이전트 정의 (Agent Definitions)

### 4.1 Partner (The Heroine/Hero)
*   사용자가 상호작용하고 공략하는 대상.
*   감정(Emotion) 축 보유.
*   외모(Face, Hair, Body), 어투(Tone), 성격(Personality) 정의됨.

### 4.2 User (The Protagonist)
*   사용자가 해당 세션에서 빙의하는 페르소나.
*   감정 축 없음 (유저 본인이 느끼는 것이므로).
*   외모, 어투, 성격 정의 가능.
*   비쥬얼 노벨/동인지 등에서 독자가 이입하여 특정 목적을 달성하려는 주체.

### 4.3 Scenario Director (The Narrator/God)
*   턴제 대화(Partner ↔ User) 사이의 빈틈을 메우는 서술자.
*   대화만으로 부족한 상황 묘사, 시공간 변경, 강제 이벤트 삽입 수행.
*   **World Management**:
    *   `Time`, `User Location`, `Partner Location` 관리.
    *   **Partner Outfit Change**: 시간 흐름(다음날)이나 장소 변경(집->밖)에 따른 파트너의 의상 변경을 관장 및 서술.
*   유저를 몰입시키고 도파민을 자극하는 플롯 설계를 최우선으로 함 (NSFW 요소 포함).
*   **권한**: 이미지 생성 여부 결정권 보유.

### 4.4 Visual Director (The Illustrator)
*   시나리오, 대사, 상황을 조합하여 최적의 '한 장면'을 포착.
*   SDXL / Danbooru 태그 생성에 특화됨.
*   단순 묘사가 아닌, 사용자가 보고 싶어하는 '꼴리는' 혹은 '멋진' 포인트(Fetish/Cool factor)를 정확히 짚어내어 이미지로 구현.

## 5. 데이터 구조 및 페르소나 필드 (Data Structure & Persona Fields)

각 에이전트가 효과적으로 작동하기 위해 필요한 핵심 데이터 필드를 정의합니다. 유저는 설정 탭이나 초기 세팅에서 이 값들을 조정할 수 있습니다.

### 5.1 Partner Agent Fields
*   **Basic Info**:
    *   `Name` (이름)
    *   `Age` (나이)
    *   `Gender` (성별)
    *   `Occupation` (직업 - 대화 주제 및 행동 패턴에 영향)
*   **Visual Appearance (Dual Structure)**:
    *   *Natural Language Description*과 *SDXL Tags*가 쌍으로 존재해야 함. 
    *   *UI Feature*: 유저가 자연어 묘사 입력 시, LLM을 통해 대응되는 SDXL Tag를 자동 생성하는 'Generate' 버튼 제공.
    *   **Fields**:
        *   `Face`: [Description] / [Tags] (예: 귀여운 동안, 큰 눈 / baby face, big eyes)
        *   `Hairstyle`: [Description] / [Tags] (예: 금발의 포니테일 / blonde hair, ponytail)
        *   `Body`: [Description] / [Tags] (예: 글래머러스한 몸매 / voluptuous body, large breasts)
        *   `Accessories`: [Description] / [Tags] (예: 안경, 피어싱 / glasses, piercings)
        *   `Fashion`: [Description] / [Tags] (기본 복장)
*   **Personality & Tone**:
    *   `MBTI` or `Big 5` (성격 유형)
    *   `Speech Style` (말투 - 예: 반말/존댓말, 사투리, 아가씨 말투 등. *Few-shot 예시 데이터 필요*)
    *   `Core Values` (중요하게 생각하는 가치관)
    *   `Secrets` (유저가 알아내야 할 비밀이나 트라우마)
*   **State & Emotion (Research Based)**:
    *   LLM 롤플레잉에서는 정량적 수치와 정성적 상태가 결합될 때 최고의 효율을 보임.
    *   `Affection` (0-100): 장기적인 호감도 및 관계 진전도 (이벤트 해금 트리거).
    *   `Arousal` (0-100): 현재의 성적 흥분도 (NSFW 상황 트리거).
    *   `Mood` (String): 현재의 즉각적인 감정 상태 (예: "Happy", "Anxious", "Horny", "Jealous"). LLM의 어조(Tone) 결정에 핵심.
    *   `Memory Summary` (지금까지의 대화 요약본)

### 5.2 User Agent Fields
*   **Basic Info**:
    *   `Name` (이름)
    *   `Gender` (성별)
    *   `Age` (나이 - 대략적 범위)
*   **Visual Appearance (Dual Structure)**:
    *   Partner와 마찬가지로 자연어/태그 쌍으로 관리하며 자동 생성 기능 지원.
    *   **Fields**:
        *   `Face`: [Description] / [Tags] (예: 평범한 남자 / average face)
        *   `Hairstyle`: [Description] / [Tags] (예: 짧은 머리 / short hair)
        *   `Body`: [Description] / [Tags] (예: 근육질 / muscular male)
        *   `Accessories`: [Description] / [Tags]
        *   `Fashion`: [Description] / [Tags]
*   **Preferences**:
    *   `Fetish Tags` (성적 취향 태그 - 예: deepthroat, paizuri, romantic date 등. 유저 추론 및 시나리오 전개에 반영)

### 5.3 Scenario Director Fields
*   **Narrative Settings**:
    *   `Genre` (장르 - 예: Pure Romance, NTR, Hardcore, Mystery)
    *   `Narrative Pace` (전개 속도 - 느림/보통/빠름)
    *   `NSFW Tolerance` (수위 조절 - Safe / R-15 / R-18)
*   **World State**:
    *   `Current Time` (현재 시간)
    *   `User Location` (유저 장소)
    *   `Partner Location` (파트너 장소)
    *   `Partner Outfit State` (현재 파트너가 입고 있는 옷 - Scenario Director가 상황에 따라 변경 결정)
    *   `Weather` (날씨)

### 5.4 Visual Director Fields
*   **SDXL Settings** (ComfyUI 연동용):
    *   `Checkpoints` (사용할 모델 파일명)
    *   `LoRA List` (적용할 LoRA 파일명 및 가중치 목록)
    *   `VAE`
    *   *Note*: Negative Prompts는 설정 탭에서 관리.

## 6. 시나리오 생성기 (Scenario Generator - The Guide)

### 6.1 역할 및 목적
*   **역할**: 새로운 세션을 시작할 때 사용자에게 흥미롭고 몰입감 있는 초기 설정을 제공하는 '안내자'.
*   **Type**: Agent는 아니지만 중요한 LLM 기능.
*   **목적**:
    *   창의적이고 신선한 시나리오 생성.
    *   사용자가 "이번엔 어떤 시나리오일까?" 하는 기대감을 품게 만듦 (가챠 시스템).
    *   성별 조합에 맞는 최적의 설정 제공.

### 6.2 생성 대상 필드
시나리오 생성기는 다음 필드들을 자동으로 채워줍니다:
*   **Partner Fields**: Name, Age, Occupation, Visual Appearance (Description + Tags), Personality, Speech Style, Core Values, Secrets
*   **User Fields**: Name, Visual Appearance (Description + Tags)
*   **Scenario Director Initial Settings**: Genre, Initial Time, Initial Location (User/Partner), Initial Situation, Partner's Initial Outfit

### 6.3 시나리오 패턴 카테고리 (Research Based)

비쥬얼 노벨, 동인지, 성인 웹툰 등에서 검증된 인기 시나리오 패턴들:

#### **금단의 관계 (Forbidden Relationships)**
*   Teacher/Student (선생/학생)
*   Step-siblings (의붓남매)
*   Boss/Employee (상사/부하)
*   Best Friend's Partner/Sibling (친구의 연인/형제자매)
*   Mentor/Apprentice (스승/제자)
*   Rival to Lovers (경쟁자에서 연인으로)
*   Mother/Son (엄마/아들)
*   Father/Daughter (아빠/딸)

#### **갖지 못할 것 같은 대상 (Unattainable Targets)**
*   Idol/Fan (아이돌/팬)
*   Celebrity/Ordinary Person (유명인/평범한 사람)
*   Popular Person/Outcast (인싸/아싸)
*   Rich/Poor (부자/가난한 사람)
*   Childhood Friend who became unreachable (멀어진 소꿉친구)

#### **판타지 설정 (Fantasy Settings)**
*   Human/Non-Human (인간/비인간 - 뱀파이어, 악마, 천사, 수인 등)
*   Hero/Villain (영웅/악당)
*   Summoner/Summoned Being (소환사/소환된 존재)
*   Master/Servant in magical contract (주인/하인 마법 계약)
*   Reincarnation/Past Life lovers (환생/전생의 연인)
*   Different Social Status in Fantasy Kingdom (판타지 왕국의 신분 차이)

#### **현실적 상황 (Realistic Scenarios)**
*   Workplace Romance (직장 로맨스)
*   Roommate/Housemate (룸메이트)
*   Ex-lovers reunited (헤어졌던 연인의 재회)
*   Arranged Marriage/Blind Date (중매/소개팅)
*   Secret Relationship (비밀 연애)
*   Friends to Lovers (친구에서 연인으로)
*   Fake Dating becomes Real (가짜 연애가 진짜로)
*   Neighbors (이웃)

#### **특수 상황 (Special Situations)**
*   Trapped Together (함께 갇힌 상황 - 엘리베이터, 무인도 등)
*   One Night Stand aftermath (하룻밤의 실수 이후)
*   Amnesia (기억상실)
*   Time Travel (시간 여행)
*   Body Swap (몸이 바뀜)
*   Love Triangle/Harem (삼각관계/하렘)

### 6.4 성별 조합별 추천 패턴
*   **남성캐릭터(User) × 여성캐릭터(Partner)**:
    *   Tsundere, Kuudere, Dandere 등 클래식 캐릭터 유형
    *   Student/Teacher, Idol/Fan, Childhood Friend
    *   Fantasy: Elf, Demon girl, Succubus, Maid
    
*   **여성캐릭터(User) × 남성캐릭터(Partner)**:
    *   Cold Boss, Yandere, Gentle Giant
    *   CEO/Secretary, Doctor/Patient, Bodyguard/Client
    *   Fantasy: Vampire lord, Dragon prince, Dark mage
    
*   **기타 조합 (마물/여성 등 비전통적)**:
    *   Monster/Human dynamics
    *   Non-binary or fluid gender setups
    *   Supernatural beings with unique relationship rules

## 7. 세션 생성 워크플로우 (Session Creation Workflow)

### 7.1 사용자 플로우

1.  **세션 생성 화면 진입**:
    *   사용자가 `+` 버튼 클릭.

2.  **기본 정보 입력**:
    *   **Partner Gender** (필수): 파트너 성별 선택.
    *   **User Gender** (필수): 본인 성별 선택.

3.  **시나리오 생성 선택**:
    *   **Option A - AI Generate 버튼**:
        *   사용자가 "Generate" 버튼 클릭.
        *   LLM(Scenario Generator)가 위 성별 조합을 기반으로 모든 필드를 자동 생성.
        *   생성된 내용을 사용자에게 표시 (수정 가능).
    *   **Option B - Manual Input**:
        *   사용자가 직접 모든 필드를 입력.

4.  **외모 태그 생성 (Optional per field)**:
    *   각 외모 필드(Face, Hairstyle, Body, Accessories, Fashion)마다 개별 'Generate Tags' 버튼 제공.
    *   자연어 Description을 입력한 후 버튼을 누르면 LLM이 대응되는 SDXL Tags 생성.

5.  **파트너 프로필 이미지 생성 (Optional)**:
    *   모든 필드 입력 완료 후, "Generate Partner Image" 버튼 활성화.
    *   Visual Director를 통해 **Square (1024x1024)** 포맷의 파트너 얼굴 이미지 생성.
    *   생성된 이미지는 채팅방 프로필 이미지로 사용됨.
    *   생성하지 않아도 세션 시작 가능 (기본 아이콘 사용).

6.  **세션 시작**:
    *   "Start Session" 버튼을 누르면 채팅 화면으로 진입하여 시나리오 시작.

### 7.2 시나리오 생성기 동작 로직

*   **Input**: User Gender, Partner Gender
*   **Process**:
    1.  성별 조합에 적합한 시나리오 패턴 선택 (위 6.3, 6.4 참조).
    2.  해당 패턴에 맞는 Partner와 User 페르소나 생성.
    3.  초기 상황(Initial Situation) 설정 - 첫 대화가 어떻게 시작될지.
    4.  모든 필드를 JSON 형식으로 반환.
*   **Output**: Partner Fields + User Fields + Scenario Director Initial Settings의 완성된 JSON.

### 7.3 기술적 고려사항

*   **LLM Model**: 창의적이고 다양한 출력을 위해 높은 Temperature 설정 권장.
*   **Randomness**: 매번 다른 시나리오를 생성하여 가챠의 재미 극대화.
*   **User Customization**: 생성된 결과를 사용자가 원하는 대로 수정할 수 있어야 함.
*   **Image Format**: 파트너 이미지 생성 시 Square (1024x1024) 고정, LatentSizePreset enum 참조.
