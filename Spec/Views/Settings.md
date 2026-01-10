# Qualia Settings Specification

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 목차

1. [개요](#개요)
2. [ComfyUI Settings](#comfyui-settings)
3. [OpenRouter Settings](#openrouter-settings)
4. [Agent Settings](#agent-settings)

---

## 개요

Qualia의 설정 화면은 3개의 주요 섹션으로 구성됩니다:
1. **ComfyUI Settings**: 이미지 생성 서버 연결 설정
2. **OpenRouter Settings**: LLM API 연결 및 크레딧 관리
3. **Agent Settings**: 각 Agent별 LLM 모델 선택

---

## ComfyUI Settings

ComfyUI 서버 연결 설정 및 상태 확인.

### 데이터 모델

```dart
class ComfyUISettings {
  String ipAddress;             // IP 주소 (예: "127.0.0.1", "192.168.1.100")
  int port;                     // 포트 번호 (기본: 8188)
  bool isConnected;             // 연결 상태
  DateTime? lastChecked;        // 마지막 연결 확인 시간
}
```

### UI 구성

```
┌─────────────────────────────────────────┐
│ ComfyUI Settings                        │
├─────────────────────────────────────────┤
│                                         │
│ IP Address                              │
│ [127.0.0.1                    ]         │
│                                         │
│ Port                                    │
│ [8188                         ]         │
│                                         │
│ [Test Connection]  ● Connected          │
│                                         │
│ Last checked: 2026-01-10 23:25:30       │
└─────────────────────────────────────────┘
```

### 기능

1. **IP/Port 입력**: 사용자가 ComfyUI 서버 주소 입력
2. **Test Connection 버튼**: 
   - ComfyUI API 엔드포인트 호출 (`GET /system_stats`)
   - 성공: "Connected" 표시 (녹색)
   - 실패: "Disconnected" 표시 (빨간색) + 에러 메시지
3. **자동 저장**: 설정 변경 시 자동 저장

### 연결 확인 로직

```dart
Future<bool> testComfyUIConnection() async {
  try {
    final response = await http.get(
      Uri.parse('http://$ipAddress:$port/system_stats')
    );
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
```

---

## OpenRouter Settings

OpenRouter API 연결 및 크레딧 정보 관리.

### 데이터 모델

```dart
class OpenRouterSettings {
  String apiKey;                // API Key
  bool isAuthenticated;         // 인증 상태
  double? creditBalance;        // 크레딧 잔액 (USD)
  List<ModelInfo> availableModels;  // 사용 가능한 모델 목록
  DateTime? lastSynced;         // 마지막 동기화 시간
}

class ModelInfo {
  String id;                    // 모델 ID (예: "anthropic/claude-3.5-sonnet")
  String name;                  // 표시 이름 (예: "Claude 3.5 Sonnet")
  String provider;              // 제공자 (예: "Anthropic")
  double pricePerMToken;        // 1M 토큰당 가격 (USD)
  int contextLength;            // 컨텍스트 길이
}
```

### UI 구성

```
┌─────────────────────────────────────────┐
│ OpenRouter Settings                     │
├─────────────────────────────────────────┤
│                                         │
│ API Key                                 │
│ [sk-or-v1-*********************]        │
│                                         │
│ [Verify & Sync]  ● Authenticated        │
│                                         │
│ Credit Balance: $12.45                  │
│ Last synced: 2026-01-10 23:25:30        │
│                                         │
│ Available Models (45)                   │
│ ┌─────────────────────────────────────┐ │
│ │ ● Anthropic                         │ │
│ │   - Claude 3.5 Sonnet               │ │
│ │   - Claude 3 Opus                   │ │
│ │ ● OpenAI                            │ │
│ │   - GPT-4o                          │ │
│ │   - GPT-4o-mini                     │ │
│ │ ...                                 │ │
│ └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

### 기능

1. **API Key 입력**: 사용자가 OpenRouter API Key 입력
2. **Verify & Sync 버튼**:
   - API Key 검증
   - 크레딧 잔액 조회
   - 사용 가능한 모델 목록 가져오기
3. **크레딧 표시**: 현재 잔액 실시간 표시
4. **모델 목록**: 제공자별로 그룹화하여 표시

### API 호출

```dart
// 크레딧 조회
Future<double?> getCreditBalance() async {
  final response = await http.get(
    Uri.parse('https://openrouter.ai/api/v1/auth/key'),
    headers: {'Authorization': 'Bearer $apiKey'},
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['data']['limit'];  // 크레딧 한도
  }
  return null;
}

// 모델 목록 조회
Future<List<ModelInfo>> getAvailableModels() async {
  final response = await http.get(
    Uri.parse('https://openrouter.ai/api/v1/models'),
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return (data['data'] as List)
        .map((m) => ModelInfo.fromJson(m))
        .toList();
  }
  return [];
}
```

---

## Agent Settings

각 Agent별 LLM 모델 선택 및 설정.

### 데이터 모델

```dart
class AgentSettings {
  Map<AgentType, AgentModelConfig> agentConfigs;
}

enum AgentType {
  partner,
  scenarioDirector,
  visualDirector,
  strategist,
  sceneTransitioner,
  scenarioGenerator,
  sdxlTransformer,
}

class AgentModelConfig {
  String modelId;               // OpenRouter 모델 ID
  String modelName;             // 표시용 모델 이름
  double temperature;           // 온도 (0.0 ~ 2.0)
  int maxTokens;                // 최대 토큰 수
}
```

### UI 구성

```
┌─────────────────────────────────────────┐
│ Agent Settings                          │
├─────────────────────────────────────────┤
│                                         │
│ Partner Agent                           │
│ Model: [Claude 3.5 Sonnet        ▼]    │
│ Temperature: [0.7          ] (0-2)      │
│ Max Tokens: [2000          ]            │
│                                         │
│ Scenario Director                       │
│ Model: [Claude 3.5 Sonnet        ▼]    │
│ Temperature: [0.8          ]            │
│ Max Tokens: [1500          ]            │
│                                         │
│ Visual Director                         │
│ Model: [GPT-4o                   ▼]    │
│ Temperature: [0.5          ]            │
│ Max Tokens: [1000          ]            │
│                                         │
│ Strategist                              │
│ Model: [GPT-4o-mini              ▼]    │
│ Temperature: [0.7          ]            │
│ Max Tokens: [1500          ]            │
│                                         │
│ Scene Transitioner                      │
│ Model: [Claude 3.5 Sonnet        ▼]    │
│ Temperature: [0.8          ]            │
│ Max Tokens: [2000          ]            │
│                                         │
│ Scenario Generator                      │
│ Model: [Claude 3.5 Sonnet        ▼]    │
│ Temperature: [0.9          ]            │
│ Max Tokens: [3000          ]            │
│                                         │
│ SDXL Transformer                        │
│ Model: [GPT-4o-mini              ▼]    │
│ Temperature: [0.3          ]            │
│ Max Tokens: [500           ]            │
│                                         │
│ [Reset to Defaults]  [Save]             │
└─────────────────────────────────────────┘
```

### 기능

1. **모델 선택**: OpenRouter에서 가져온 모델 목록에서 선택
2. **Temperature 조정**: 각 Agent별 창의성 조절
3. **Max Tokens 설정**: 응답 길이 제한
4. **기본값 리셋**: Agents-Design.md의 추천 설정으로 복원
5. **자동 저장**: 설정 변경 시 자동 저장

### 기본 설정값

| Agent | 추천 모델 | Temperature | Max Tokens |
|---|---|---|---|
| Partner | Claude 3.5 Sonnet | 0.7 | 2000 |
| Scenario Director | Claude 3.5 Sonnet | 0.8 | 1500 |
| Visual Director | GPT-4o | 0.5 | 1000 |
| Strategist | GPT-4o-mini | 0.7 | 1500 |
| Scene Transitioner | Claude 3.5 Sonnet | 0.8 | 2000 |
| Scenario Generator | Claude 3.5 Sonnet | 0.9 | 3000 |
| SDXL Transformer | GPT-4o-mini | 0.3 | 500 |

---

## 설정 저장

모든 설정은 로컬 저장소에 저장됩니다.

```dart
class AppSettings {
  ComfyUISettings comfyUI;
  OpenRouterSettings openRouter;
  AgentSettings agents;
  
  // JSON 직렬화
  Map<String, dynamic> toJson();
  factory AppSettings.fromJson(Map<String, dynamic> json);
}
```

### 저장 위치
- **Flutter**: SharedPreferences 또는 Hive
- **파일 경로**: `app_data/settings.json`

---

## 변경 이력

| 날짜 | 변경 내용 |
|---|---|
| 2026-01-10 | 초안 작성: ComfyUI, OpenRouter, Agent 설정 스펙 정의 |
