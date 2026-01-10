# Qualia 크로스 플랫폼 전략 분석

**목표 플랫폼**: Mac, iPhone, Windows, Android  
**아키텍처**: 클라이언트 앱 (백엔드 서버 없음)  
**외부 의존성**: OpenRouter API, 로컬 ComfyUI

---

## 옵션 비교

### 1. Flutter ⭐ **추천**

#### 장점
- ✅ **단일 코드베이스**로 4개 플랫폼 모두 지원
- ✅ **네이티브 성능** (Dart → 네이티브 컴파일)
- ✅ 풍부한 UI 컴포넌트 (Material, Cupertino)
- ✅ 핫 리로드로 빠른 개발
- ✅ 강력한 상태 관리 (Provider, Riverpod, Bloc)
- ✅ 로컬 스토리지 라이브러리 풍부 (Hive, SQLite)
- ✅ 파일 시스템 접근 용이 (ComfyUI 로컬 연동)

#### 단점
- ⚠️ 데스크톱 지원이 상대적으로 최신 (안정화 중)
- ⚠️ 각 플랫폼별 약간의 추가 설정 필요

#### 코드 공유율
**95%+** - 거의 모든 코드 공유 가능

#### 예상 개발 기간
**8-12주** (4개 플랫폼 동시)

---

### 2. React Native (모바일) + Tauri (데스크톱)

#### 장점
- ✅ React 생태계 활용 (JavaScript/TypeScript)
- ✅ Tauri는 매우 가벼움 (Electron 대비)
- ✅ 웹 개발자에게 친숙

#### 단점
- ⚠️ **두 개의 코드베이스** 필요 (모바일 / 데스크톱)
- ⚠️ 코드 공유를 위한 추가 설계 필요
- ⚠️ 유지보수 복잡도 증가

#### 코드 공유율
**60-70%** (로직 계층만 공유)

#### 예상 개발 기간
**12-16주**

---

### 3. Electron (모든 플랫폼)

#### 장점
- ✅ 웹 기술 100% 활용 (React, Vue 등)
- ✅ 많은 라이브러리 및 레퍼런스
- ✅ 데스크톱에서 검증됨

#### 단점
- ❌ **모바일 미지원** (iOS, Android 불가)
- ❌ 번들 크기 매우 큼 (~50MB+)
- ❌ 메모리 사용량 높음

#### 결론
❌ **부적합** - 모바일 지원 불가

---

### 4. .NET MAUI

#### 장점
- ✅ Microsoft 공식 크로스 플랫폼 프레임워크
- ✅ C# 및 .NET 생태계
- ✅ XAML 기반 UI

#### 단점
- ⚠️ 상대적으로 커뮤니티 작음
- ⚠️ LLM 통합 라이브러리 부족
- ⚠️ Mac 개발 환경 설정 복잡

#### 예상 개발 기간
**10-14주**

---

## 상세 비교표

| 항목 | Flutter | RN+Tauri | Electron | .NET MAUI |
|------|---------|----------|----------|-----------|
| Mac 지원 | ✅ | ✅ | ✅ | ✅ |
| Windows 지원 | ✅ | ✅ | ✅ | ✅ |
| iPhone 지원 | ✅ | ✅ | ❌ | ✅ |
| Android 지원 | ✅ | ✅ | ❌ | ✅ |
| 코드 공유율 | 95%+ | 60-70% | N/A | 90%+ |
| 성능 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| 번들 크기 | 15-20MB | 각 40MB+ | 50MB+ | 20-30MB |
| 개발 속도 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| 커뮤니티 | 매우 큼 | 큼 | 매우 큼 | 보통 |
| LLM 통합 | 용이 | 용이 | 용이 | 보통 |

---

## Qualia 프로젝트에 대한 추천: **Flutter** 🎯

### 이유

#### 1. 완벽한 플랫폼 매칭
4개 플랫폼을 **단일 코드베이스**로 커버합니다.

#### 2. 로컬 파일 시스템 접근
ComfyUI와 연동하기 위해 로컬 파일 시스템 접근이 필요한데, Flutter는 이를 잘 지원합니다:

```dart
// ComfyUI 로컬 서버 통신
import 'package:http/http.dart' as http;

Future<void> generateImage(String prompt) async {
  final response = await http.post(
    Uri.parse('http://localhost:8188/prompt'),
    body: jsonEncode({
      'prompt': workflow,
    }),
  );
}
```

#### 3. 상태 관리
복잡한 채팅 상태, 에이전트 상태 관리에 적합:

```dart
// Riverpod 예시
final chatSessionProvider = StateNotifierProvider<ChatSessionNotifier, ChatSession>((ref) {
  return ChatSessionNotifier();
});
```

#### 4. iMessage 스타일 UI 구현 용이
Flutter는 UI 커스터마이징이 매우 자유롭습니다:

```dart
Container(
  padding: EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: isUser ? Colors.blue : Colors.grey[300],
    borderRadius: BorderRadius.circular(18),
  ),
  child: Text(message.content),
)
```

#### 5. 로컬 데이터베이스
```dart
// Hive (NoSQL) 또는 Drift (SQLite)
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ChatSession extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  List<Message> messages;
  
  @HiveField(2)
  Partner partner;
}
```

---

## Flutter 프로젝트 구조 제안

```
qualia/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── agents/
│   │   │   ├── partner_agent.dart
│   │   │   ├── scenario_director.dart
│   │   │   ├── visual_director.dart
│   │   │   └── strategist.dart
│   │   ├── services/
│   │   │   ├── openrouter_service.dart
│   │   │   ├── comfyui_service.dart
│   │   │   └── storage_service.dart
│   │   └── models/
│   │       ├── chat_session.dart
│   │       ├── message.dart
│   │       ├── partner.dart
│   │       └── user_persona.dart
│   ├── features/
│   │   ├── chat/
│   │   │   ├── screens/
│   │   │   │   ├── chat_screen.dart
│   │   │   │   └── session_list_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── message_bubble.dart
│   │   │   │   ├── typing_indicator.dart
│   │   │   │   ├── strategy_choices.dart
│   │   │   │   └── generated_image.dart
│   │   │   └── providers/
│   │   │       └── chat_provider.dart
│   │   ├── session_creator/
│   │   │   ├── screens/
│   │   │   │   └── session_creator_screen.dart
│   │   │   └── widgets/
│   │   │       ├── partner_form.dart
│   │   │       └── tag_generator.dart
│   │   └── settings/
│   │       ├── screens/
│   │       │   └── settings_screen.dart
│   │       └── widgets/
│   │           ├── comfyui_settings.dart
│   │           └── llm_settings.dart
│   └── shared/
│       ├── theme/
│       │   └── app_theme.dart
│       └── widgets/
│           └── common_widgets.dart
├── android/
├── ios/
├── macos/
├── windows/
└── pubspec.yaml
```

---

## 핵심 Flutter 패키지

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # 상태 관리
  riverpod: ^2.5.0
  flutter_riverpod: ^2.5.0
  
  # 로컬 스토리지
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # HTTP 통신
  http: ^1.2.0
  dio: ^5.4.0  # 고급 HTTP (파일 업로드 등)
  
  # WebSocket
  web_socket_channel: ^2.4.0
  
  # JSON 직렬화
  json_annotation: ^4.8.1
  freezed_annotation: ^2.4.1
  
  # UI
  cached_network_image: ^3.3.0  # 이미지 캐싱
  flutter_markdown: ^0.6.18  # Markdown 렌더링 (Director 서술)
  
  # 파일 시스템
  path_provider: ^2.1.1
  
  # 환경 변수
  flutter_dotenv: ^5.1.0

dev_dependencies:
  # 코드 생성
  build_runner: ^2.4.7
  hive_generator: ^2.0.1
  json_serializable: ^6.7.1
  freezed: ^2.4.6
```

---

## 개발 단계

### Phase 1: 프로젝트 설정 (1주)
```bash
flutter create qualia --platforms=ios,android,macos,windows
cd qualia
flutter pub add riverpod flutter_riverpod hive http
flutter pub add --dev build_runner hive_generator
```

### Phase 2: 핵심 기능 (4-5주)
- [ ] 데이터 모델 및 로컬 DB
- [ ] OpenRouter 통합
- [ ] 채팅 UI (iMessage 스타일)
- [ ] 에이전트 로직
- [ ] 세션 생성

### Phase 3: 이미지 생성 (2주)
- [ ] ComfyUI 통합
- [ ] 워크플로우 생성
- [ ] 이미지 표시 및 캐싱

### Phase 4: 플랫폼별 최적화 (2-3주)
- [ ] iOS 빌드 및 테스트
- [ ] Android 빌드 및 테스트
- [ ] macOS 빌드 및 테스트
- [ ] Windows 빌드 및 테스트
- [ ] 플랫폼별 UI 조정

### Phase 5: 배포 준비 (1-2주)
- [ ] 앱 아이콘, 스플래시 스크린
- [ ] 코드 사이닝
- [ ] 빌드 자동화
- [ ] 배포 가이드

---

## 플랫폼별 고려사항

### iOS
- **요구**: Mac + Xcode + Apple Developer 계정 ($99/년)
- **배포**: App Store 또는 TestFlight

### Android
- **요구**: Android Studio
- **배포**: Google Play Store 또는 APK 직접 배포

### macOS
- **요구**: Mac + Xcode
- **배포**: App Store 또는 DMG 직접 배포
- **권한**: 로컬 네트워크 접근 (ComfyUI) 명시 필요

### Windows
- **요구**: Windows 10+ 또는 Visual Studio
- **배포**: EXE 또는 MSIX

---

## ComfyUI 로컬 연동 고려사항

### 문제점
모바일 (iPhone, Android)에서는 로컬 ComfyUI 서버에 직접 접근 불가능합니다.

### 해결책

#### Option A: Desktop Only 이미지 생성
- 데스크톱에서만 이미지 생성 가능
- 모바일에서는 텍스트 채팅만 지원

#### Option B: 로컬 네트워크 공유
- 같은 Wi-Fi에 있는 Mac/Windows에서 ComfyUI 실행
- 모바일 앱이 로컬 IP로 접근 (예: `http://192.168.1.100:8188`)

```dart
// 설정에서 ComfyUI 서버 주소 입력
String comfyuiUrl = 'http://192.168.1.100:8188';
```

#### Option C: 클라우드 ComfyUI (추후)
- Replicate, RunPod 등에 ComfyUI 배포
- 모든 플랫폼에서 접근 가능

**추천**: Option B (로컬 네트워크) → 추후 Option C로 확장

---

## 결론

### 최종 추천: **Flutter**

**이유**:
1. ✅ 4개 플랫폼 완벽 지원
2. ✅ 95%+ 코드 공유
3. ✅ 빠른 개발 속도
4. ✅ 네이티브 성능
5. ✅ LLM 및 이미지 생성 통합 용이

**예상 개발 기간**: 10-12주

**시작 명령어**:
```bash
flutter create qualia --platforms=ios,android,macos,windows
cd qualia
flutter run -d macos  # Mac에서 테스트
```

---

**다음 단계**: Flutter 프로젝트 생성 및 기본 구조 설정을 시작할까요?
