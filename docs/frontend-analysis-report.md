# Qualia 프로젝트 프론트엔드 분석 보고서

**분석자**: Frontend Developer  
**분석일**: 2026-01-10  
**문서 버전**: 1.0

---

## 1. 프로젝트 개요

**Qualia**는 채팅 UI 기반 비쥬얼 노벨 롤플레잉 게임으로, LLM 에이전트와의 실시간 상호작용과 동적 이미지 생성을 특징으로 합니다.

### 플랫폼 요구사항
- **크로스 플랫폼**: Desktop, iOS, Android, Web
- **UI 스타일**: iPhone iMessage 스타일

---

## 2. UI/UX 요구사항 분석

### 2.1 탭 구조

앱은 2개의 메인 탭으로 구성:
1. **채팅 (Chat)**: 메인 인터랙션 영역
2. **설정 (Settings)**: ComfyUI 및 LLM 설정

### 2.2 채팅 탭 상세 분석

#### Empty State
- 진행 중인 세션이 없을 때 안내 문구 표시
- `+` 버튼으로 새 세션 생성 유도

#### 세션 생성 플로우

```
[시작] → [성별 선택] → [생성 방식 선택]
                           ├─ AI 가챠 (자동 생성)
                           └─ 커스텀 입력
                                 ↓
                      [상세 설정 입력]
                                 ↓
                      [외모 태그 생성 (선택)]
                                 ↓
                      [파트너 이미지 생성 (선택)]
                                 ↓
                          [세션 시작]
```

#### 채팅 인터페이스 요구사항

**메시지 흐름**:
1. 파트너 타이핑 인디케이터 (`...`)
2. 파트너 응답 (여러 말풍선 가능)
3. 시나리오 디렉터 서술
4. 이미지 생성 (조건부)
5. 사용자 선택지 표시
6. 사용자 입력 대기

**파트너 응답 포맷**:
- 행동 지문 (Action)
- 대사 1-3개 (Dialogue)
- 속마음 (Inner Thought - 특수 연출)

**사용자 인터랙션**:
- 3~4개의 추천 선택지
- 직접 텍스트 입력 옵션
- 재시도 버튼 (에러 시)

---

## 3. 컴포넌트 아키텍처

### 3.1 컴포넌트 트리

```
App
├── TabNavigator
│   ├── ChatTab
│   │   ├── SessionList
│   │   │   ├── SessionCard
│   │   │   └── EmptyState
│   │   └── ChatView
│   │       ├── MessageList
│   │       │   ├── MessageBubble
│   │       │   │   ├── ActionText
│   │       │   │   ├── DialogueText
│   │       │   │   └── InnerThoughtText
│   │       │   ├── DirectorNarration
│   │       │   └── GeneratedImage
│   │       ├── TypingIndicator
│   │       ├── StrategyChoices
│   │       └── MessageInput
│   └── SettingsTab
│       ├── ComfyUISettings
│       │   ├── ServerConfig
│       │   ├── ModelSelector
│       │   ├── VAESelector
│       │   └── AdvancedParams
│       ├── LLMSettings
│       │   ├── APIKeyInput
│       │   ├── ModelList
│       │   └── AgentModelAssignment
│       └── SupportSection
└── SessionCreator
    ├── GenderSelection
    ├── AIGachaButton
    ├── CustomInputForm
    │   ├── PartnerProfileForm
    │   ├── UserPersonaForm
    │   ├── ScenarioForm
    │   └── AppearanceTagGenerator
    └── ProfileImageGenerator
```

### 3.2 핵심 컴포넌트 상세

#### MessageBubble
```jsx
<MessageBubble
  sender="partner" // 'user' | 'partner' | 'director'
  content={{
    action: "살며시 미소를 지으며",
    dialogues: ["응, 좋아.", "오늘 날씨 정말 좋다."],
    innerThought: "드디어 함께 있게 되었어..."
  }}
  timestamp={Date}
  onRetry={handleRetry}
/>
```

#### GeneratedImage
```jsx
<GeneratedImage
  src="https://..."
  prompt="blonde hair, ponytail, smiling"
  loading={false}
  onRegenerate={handleRegenerate}
/>
```

#### StrategyChoices
```jsx
<StrategyChoices
  choices={[
    {
      id: 1,
      action: "손을 잡는다",
      speech: "같이 걸을까?",
      tags: "holding hands"
    },
    // ...
  ]}
  onSelect={handleChoiceSelect}
/>
```

---

## 4. 상태 관리 전략

### 4.1 전역 상태 (Context / Redux / Zustand)

```typescript
interface AppState {
  // 사용자 설정
  settings: {
    comfyui: ComfyUISettings;
    llm: LLMSettings;
  };
  
  // 세션 목록
  sessions: ChatSession[];
  
  // 활성 세션
  activeSession: ChatSession | null;
  
  // UI 상태
  ui: {
    isTyping: boolean;
    isGeneratingImage: boolean;
    currentChoices: Choice[];
  };
}

interface ChatSession {
  id: string;
  title: string;
  partner: Partner;
  user: UserPersona;
  scenarioDirector: ScenarioDirectorSettings;
  messages: Message[];
  worldState: WorldState;
  createdAt: Date;
  updatedAt: Date;
}

interface Message {
  id: string;
  sender: 'user' | 'partner' | 'director';
  content: MessageContent;
  timestamp: Date;
  imageUrl?: string;
  imagePrompt?: string;
}

interface WorldState {
  currentTime: string;
  userLocation: string;
  partnerLocation: string;
  partnerOutfit: string;
  weather: string;
}
```

### 4.2 로컬 스토리지

- 세션 데이터 영구 저장
- 설정 캐싱
- 이미지 URL 캐싱

---

## 5. 실시간 통신 구현

### 5.1 WebSocket 또는 Server-Sent Events

```typescript
class ChatEngine {
  private ws: WebSocket;
  
  connect(sessionId: string) {
    this.ws = new WebSocket(`ws://api.qualia.app/chat/${sessionId}`);
    
    this.ws.onmessage = (event) => {
      const data = JSON.parse(event.data);
      
      switch (data.event) {
        case 'partner_typing':
          this.showTypingIndicator();
          break;
        case 'partner_message':
          this.addMessage(data.content);
          break;
        case 'image_generating':
          this.showImageLoadingState();
          break;
        case 'image_ready':
          this.displayImage(data.imageUrl);
          break;
        case 'strategy_choices':
          this.displayChoices(data.choices);
          break;
        case 'error':
          this.handleError(data);
          break;
      }
    };
  }
  
  sendMessage(content: MessageContent) {
    this.ws.send(JSON.stringify({
      event: 'user_message',
      sessionId: this.sessionId,
      content
    }));
  }
}
```

### 5.2 타이핑 인디케이터 애니메이션

```css
.typing-indicator {
  display: inline-flex;
  gap: 4px;
  padding: 12px 16px;
  background: #e5e5ea;
  border-radius: 18px;
}

.typing-indicator span {
  width: 8px;
  height: 8px;
  background: #8e8e93;
  border-radius: 50%;
  animation: typing 1.4s infinite;
}

.typing-indicator span:nth-child(2) {
  animation-delay: 0.2s;
}

.typing-indicator span:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes typing {
  0%, 60%, 100% { opacity: 0.3; }
  30% { opacity: 1; }
}
```

---

## 6. 스타일링 전략

### 6.1 iMessage 스타일 구현

```css
/* Partner 메시지 (왼쪽, 회색) */
.message-bubble.partner {
  align-self: flex-start;
  background: #e5e5ea;
  color: #000;
  border-radius: 18px 18px 18px 4px;
  max-width: 70%;
  padding: 10px 14px;
  margin: 2px 0;
}

/* User 메시지 (오른쪽, 파란색) */
.message-bubble.user {
  align-self: flex-end;
  background: #007aff;
  color: #fff;
  border-radius: 18px 18px 4px 18px;
  max-width: 70%;
  padding: 10px 14px;
  margin: 2px 0;
}

/* 연속된 메시지 간격 조정 */
.message-bubble + .message-bubble.same-sender {
  margin-top: 1px;
}

.message-bubble + .message-bubble.different-sender {
  margin-top: 12px;
}
```

### 6.2 다크 모드 지원

```css
@media (prefers-color-scheme: dark) {
  .message-bubble.partner {
    background: #3a3a3c;
    color: #fff;
  }
  
  .chat-background {
    background: #000;
  }
}
```

---

## 7. 이미지 처리

### 7.1 로딩 상태 표시

```jsx
function GeneratedImage({ src, loading }) {
  if (loading) {
    return (
      <div className="image-placeholder">
        <Spinner />
        <p>이미지 생성 중...</p>
      </div>
    );
  }
  
  return (
    <img 
      src={src} 
      alt="Generated scene"
      loading="lazy"
      onError={handleImageError}
    />
  );
}
```

### 7.2 이미지 최적화

- **Lazy Loading**: 스크롤 시 로드
- **Progressive JPEG**: 점진적 로딩
- **WebP 변환**: 파일 크기 축소
- **Responsive Images**: `srcset` 활용

```jsx
<img
  src="image-1024.webp"
  srcset="
    image-640.webp 640w,
    image-1024.webp 1024w,
    image-1536.webp 1536w
  "
  sizes="(max-width: 768px) 100vw, 70vw"
  loading="lazy"
  alt="Partner"
/>
```

---

## 8. 반응형 디자인

### 8.1 브레이크포인트

```css
/* Mobile */
@media (max-width: 640px) {
  .chat-container {
    padding: 8px;
  }
  .message-bubble {
    max-width: 85%;
  }
}

/* Tablet */
@media (min-width: 641px) and (max-width: 1024px) {
  .chat-container {
    padding: 16px;
  }
  .message-bubble {
    max-width: 75%;
  }
}

/* Desktop */
@media (min-width: 1025px) {
  .chat-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 24px;
  }
  .message-bubble {
    max-width: 70%;
  }
}
```

---

## 9. 성능 최적화

### 9.1 가상 스크롤

대화가 길어질 경우 모든 메시지를 DOM에 렌더링하면 성능 저하:

```jsx
import { FixedSizeList } from 'react-window';

function VirtualMessageList({ messages }) {
  const Row = ({ index, style }) => (
    <div style={style}>
      <MessageBubble message={messages[index]} />
    </div>
  );
  
  return (
    <FixedSizeList
      height={600}
      itemCount={messages.length}
      itemSize={80}
      width="100%"
    >
      {Row}
    </FixedSizeList>
  );
}
```

### 9.2 메모이제이션

```jsx
const MessageBubble = React.memo(({ message }) => {
  // ...
}, (prevProps, nextProps) => {
  return prevProps.message.id === nextProps.message.id;
});
```

### 9.3 Code Splitting

```jsx
// Lazy load 설정 화면
const SettingsTab = lazy(() => import('./SettingsTab'));
const SessionCreator = lazy(() => import('./SessionCreator'));

function App() {
  return (
    <Suspense fallback={<Loading />}>
      <Routes>
        <Route path="/chat" element={<ChatTab />} />
        <Route path="/settings" element={<SettingsTab />} />
        <Route path="/new" element={<SessionCreator />} />
      </Routes>
    </Suspense>
  );
}
```

---

## 10. 접근성 (a11y)

### 10.1 스크린 리더 지원

```jsx
<button
  onClick={handleSend}
  aria-label="메시지 전송"
>
  <SendIcon />
</button>

<div role="log" aria-live="polite" aria-atomic="false">
  {messages.map(msg => (
    <MessageBubble key={msg.id} message={msg} />
  ))}
</div>
```

### 10.2 키보드 네비게이션

- `Tab`: 선택지 간 이동
- `Enter`: 선택지 선택 / 메시지 전송
- `Escape`: 모달 닫기

---

## 11. 에러 처리 및 사용자 피드백

### 11.1 에러 메시지 표시

```jsx
function ErrorMessage({ error, onRetry }) {
  return (
    <div className="message-bubble error">
      <p>잘 못 들었어. 다시 말해줄래..?</p>
      <button onClick={onRetry}>다시 보내기</button>
    </div>
  );
}
```

### 11.2 토스트 알림

```jsx
import { Toaster, toast } from 'react-hot-toast';

// 성공
toast.success('세션이 생성되었습니다.');

// 에러
toast.error('ComfyUI 서버에 연결할 수 없습니다.');

// 로딩
toast.loading('이미지 생성 중...');
```

---

## 12. 크로스 플랫폼 전략

### 12.1 기술 스택 제안

#### Option A: React Native (모바일) + React (웹)
- 코드 공유율 높음
- Native 성능
- 플랫폼별 UI 커스터마이징

#### Option B: Flutter
- 단일 코드베이스
- 빠른 개발 속도
- 웹 지원 개선 중

#### Option C: Electron (데스크톱) + React Native (모바일) + React (웹)
- 각 플랫폼 최적화
- 개발 복잡도 증가

### 12.2 권장 스택

**Phase 1**: React (Web) - 빠른 프로토타이핑  
**Phase 2**: React Native (iOS, Android)  
**Phase 3**: Electron (Desktop)

---

## 13. 개발 우선순위

### Phase 1: 핵심 채팅 UI (3-4주)
- [ ] 기본 레이아웃 (탭, 네비게이션)
- [ ] MessageBubble 컴포넌트
- [ ] 타이핑 인디케이터
- [ ] 메시지 입력 및 전송
- [ ] 로컬 상태 관리
- [ ] iMessage 스타일링

### Phase 2: 세션 관리 (2-3주)
- [ ] SessionCreator (커스텀 입력)
- [ ] AI 가챠 생성 통합
- [ ] 외모 태그 생성 UI
- [ ] 파트너 이미지 생성
- [ ] 세션 목록 및 저장

### Phase 3: 실시간 기능 (2-3주)
- [ ] WebSocket 통합
- [ ] 실시간 파트너 응답
- [ ] 이미지 생성 스트리밍
- [ ] 선택지 표시
- [ ] 재시도 기능

### Phase 4: 설정 및 고급 기능 (2주)
- [ ] ComfyUI 설정 UI
- [ ] LLM 설정 UI
- [ ] 에이전트별 모델 할당
- [ ] 다크 모드
- [ ] 접근성 개선

### Phase 5: 최적화 (1-2주)
- [ ] 가상 스크롤
- [ ] 이미지 최적화
- [ ] Code Splitting
- [ ] 성능 프로파일링

---

## 14. UI/UX 개선 제안

### 14.1 몰입감 강화

**애니메이션**:
- 메시지 등장 애니메이션 (fade + slide)
- 이미지 reveal 효과
- 선택지 등장 애니메이션

**사운드 효과** (선택):
- 메시지 수신음
- 이미지 생성 완료음
- 타이핑 사운드

### 14.2 편의성 기능

- **메시지 검색**: 대화 내 키워드 검색
- **북마크**: 중요한 장면 저장
- **이미지 갤러리**: 생성된 이미지 모아보기
- **대화 분기 시각화**: 선택에 따른 분기 트리

### 14.3 개인화

- **테마 커스터마이징**: 말풍선 색상, 배경
- **폰트 크기 조절**: 가독성 향상
- **알림 설정**: 파트너 응답 알림

---

## 15. 기술적 고려사항

### 15.1 오프라인 지원

```typescript
// Service Worker로 캐싱
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/sw.js');
}

// IndexedDB로 로컬 저장
import { openDB } from 'idb';

const db = await openDB('qualia-db', 1, {
  upgrade(db) {
    db.createObjectStore('sessions', { keyPath: 'id' });
    db.createObjectStore('messages', { keyPath: 'id' });
  },
});
```

### 15.2 Progressive Web App (PWA)

```json
{
  "name": "Qualia",
  "short_name": "Qualia",
  "start_url": "/",
  "display": "standalone",
  "theme_color": "#007aff",
  "background_color": "#ffffff",
  "icons": [
    {
      "src": "/icon-192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "/icon-512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
```

---

## 16. 결론 및 권장사항

### 16.1 핵심 결론

1. **iMessage 스타일 UI는 검증된 패턴**: Facebook Messenger, WhatsApp 등에서 입증
2. **실시간 통신이 핵심**: WebSocket 필수
3. **이미지 최적화 중요**: NSFW 콘텐츠로 이미지 크기가 클 가능성
4. **크로스 플랫폼 전략**: Web 먼저 → 모바일 → 데스크톱

### 16.2 즉시 결정해야 할 사항

> [!IMPORTANT]
> 개발 시작 전 다음 사항을 결정해야 합니다:

1. **프레임워크 선택**: React? Vue? Next.js?
2. **상태 관리**: Redux? Zustand? Context API?
3. **스타일링**: Tailwind? Styled-components? CSS Modules?
4. **플랫폼 우선순위**: Web first? Mobile first?
5. **백엔드 통신**: REST? GraphQL? WebSocket?

### 16.3 다음 단계

1. **디자인 시스템 구축**: 컬러, 타이포그래피, 컴포넌트 라이브러리
2. **프로토타입 개발**: Figma/Sketch 목업
3. **기술 스택 확정**: 위 질문들에 대한 답변
4. **개발 환경 구성**: ESLint, Prettier, Git hooks

---

**보고서 작성자**: Frontend Developer Agent
