# Qualia 프로젝트 백엔드 분석 보고서

**분석자**: Backend Developer  
**분석일**: 2026-01-10  
**문서 버전**: 1.0

---

## 1. 프로젝트 개요

**Qualia**는 LLM 기반 에이전트와 상호작용하는 몰입형 비쥬얼 노벨 롤플레잉 게임입니다. 채팅 UI와 실시간 이미지 생성(SDXL)을 결합한 크로스 플랫폼 애플리케이션입니다.

### 핵심 기술 스택
- **플랫폼**: Desktop, iOS, Android, Web
- **외부 통합**: OpenRouter API (LLM), ComfyUI (이미지 생성)

---

## 2. 백엔드 아키텍처 분석

### 2.1 현재 구조

이 프로젝트는 **클라이언트 중심 아키텍처**로 설계되어 있습니다. 중앙화된 백엔드 서버 없이 클라이언트가 외부 API를 직접 호출합니다.

> [!IMPORTANT]
> 기획서에는 중앙 백엔드 서버가 명시되어 있지 않습니다.

### 2.2 백엔드 필요성 검토

#### 백엔드 도입 시 해결 가능한 문제

| 문제점 | 백엔드 솔루션 |
|--------|---------------|
| API 키 노출 위험 | 서버 사이드 프록시로 키 관리 |
| 크로스 디바이스 동기화 불가 | 클라우드 세션 저장소 |
| 사용 통계 및 분석 부재 | 중앙 로깅 시스템 |
| 결제/구독 시스템 부재 | 백엔드 결제 처리 |

---

## 3. 제안하는 백엔드 아키텍처

### 3.1 기술 스택 제안

- **Backend Framework**: FastAPI (Python) 또는 Node.js + Express
- **Primary DB**: PostgreSQL (사용자, 세션 메타데이터)
- **Document Store**: MongoDB 또는 JSONB (대화 기록)
- **Cache**: Redis (세션 캐시, API 응답)
- **Container**: Docker
- **CDN**: CloudFlare (이미지 전송)

---

## 4. 데이터베이스 스키마 설계

### 4.1 핵심 테이블

#### Users
```sql
CREATE TABLE users (
    id UUID PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    username VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255),
    api_key_encrypted TEXT,
    subscription_tier VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);
```

#### ChatSessions
```sql
CREATE TABLE chat_sessions (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    title VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    is_archived BOOLEAN DEFAULT FALSE,
    genre VARCHAR(100),
    narrative_pace VARCHAR(50),
    nsfw_tolerance VARCHAR(20),
    world_state JSONB
);
```

#### Partners
```sql
CREATE TABLE partners (
    id UUID PRIMARY KEY,
    session_id UUID REFERENCES chat_sessions(id),
    name VARCHAR(100),
    age INTEGER,
    gender VARCHAR(50),
    occupation VARCHAR(100),
    appearance JSONB,
    personality JSONB,
    affection INTEGER CHECK (affection >= 0 AND affection <= 100),
    arousal INTEGER CHECK (arousal >= 0 AND arousal <= 100),
    mood VARCHAR(100),
    memory_summary TEXT,
    profile_image_url TEXT,
    created_at TIMESTAMP
);
```

#### Messages
```sql
CREATE TABLE messages (
    id UUID PRIMARY KEY,
    session_id UUID REFERENCES chat_sessions(id),
    sender VARCHAR(50),
    content JSONB,
    timestamp TIMESTAMP,
    processing_time_ms INTEGER,
    llm_model_used VARCHAR(100),
    image_url TEXT,
    image_prompt TEXT,
    partner_state_snapshot JSONB
);
```

---

## 5. API 설계

### 5.1 RESTful API 엔드포인트

#### 인증
```
POST   /api/auth/register
POST   /api/auth/login
POST   /api/auth/logout
POST   /api/auth/refresh
```

#### 세션 관리
```
GET    /api/sessions
POST   /api/sessions
GET    /api/sessions/:id
PUT    /api/sessions/:id
DELETE /api/sessions/:id
```

#### 메시지
```
GET    /api/sessions/:id/messages
POST   /api/sessions/:id/messages
POST   /api/sessions/:id/messages/:mid/retry
```

#### LLM 프록시
```
POST   /api/llm/partner
POST   /api/llm/scenario-director
POST   /api/llm/visual-director
POST   /api/llm/strategist
POST   /api/llm/scenario-generator
```

### 5.2 WebSocket API (실시간 통신)

채팅 경험을 위한 실시간 이벤트:

```javascript
// 서버 → 클라이언트
{
  "event": "partner_typing",
  "sessionId": "uuid"
}

{
  "event": "partner_message",
  "sessionId": "uuid",
  "content": {...}
}

{
  "event": "image_generating",
  "sessionId": "uuid"
}

{
  "event": "image_ready",
  "sessionId": "uuid",
  "imageUrl": "..."
}
```

---

## 6. LLM 통합 전략

### 6.1 에이전트 라우팅

각 에이전트(Partner, Scenario Director, Visual Director, Strategist)별로 적절한 LLM 모델을 라우팅하고 컨텍스트를 구성합니다.

### 6.2 메모리 관리 전략

대화가 길어질수록 토큰 제한 문제 발생 → **계층적 메모리 시스템**:

1. **Short-term**: 최근 10~20턴의 대화 전체
2. **Long-term**: 중요 이벤트 요약
3. **Semantic Search**: 벡터 DB 활용 관련 대화 검색

---

## 7. ComfyUI 통합

### 7.1 워크플로우 생성

Visual Director가 생성한 SDXL 태그와 사용자 설정을 기반으로 ComfyUI 워크플로우를 동적으로 생성합니다.

### 7.2 이미지 스토리지

- **프로덕션**: AWS S3 / Cloudflare R2
- **CDN**: 이미지 전송 가속화
- **압축**: WebP 변환

---

## 8. 보안 고려사항

### 8.1 API 키 관리

> [!CAUTION]
> OpenRouter API 키를 클라이언트에서 직접 사용하면 키 노출 위험이 있습니다.

**권장 솔루션**:
1. 서버 사이드 프록시
2. 사용자 키 암호화 저장
3. 크레딧 시스템

### 8.2 콘텐츠 검증

1. 연령 인증 (19세 이상)
2. 불법 콘텐츠 차단
3. 신고 시스템

---

## 9. 성능 최적화

### 9.1 캐싱

- Redis를 활용한 LLM 응답 캐싱
- 동일 컨텍스트 재사용

### 9.2 병렬 처리

- 여러 에이전트 동시 호출
- asyncio를 활용한 비동기 처리

---

## 10. 개발 우선순위

### Phase 1: MVP (4-6주)
- [ ] 기본 RESTful API 구축
- [ ] 사용자 인증 시스템
- [ ] PostgreSQL 스키마 구현
- [ ] LLM 프록시
- [ ] 세션 및 메시지 관리

### Phase 2: 실시간 통신 (2-3주)
- [ ] WebSocket 서버 구현
- [ ] 실시간 이벤트 스트림
- [ ] 재연결 로직

### Phase 3: 고급 기능 (3-4주)
- [ ] Visual Director + ComfyUI 통합
- [ ] 이미지 스토리지 및 CDN
- [ ] 메모리 시스템

---

## 11. 기술적 위험 요소

| 위험 요소 | 영향 | 완화 방안 |
|-----------|------|-----------|
| LLM API 비용 폭증 | 높음 | 캐싱, 사용량 제한 |
| ComfyUI 응답 지연 | 중간 | 비동기 Queue |
| NSFW 콘텐츠 법적 리스크 | 높음 | 연령 인증, 필터링 |
| API 키 노출 | 높음 | 서버 사이드 프록시 |

---

## 12. 결론 및 권장사항

### 12.1 핵심 결론

1. **백엔드 도입 권장**: 장기적으로 백엔드 서버 필요
2. **하이브리드 접근**: MVP는 클라이언트 중심, 백엔드 점진적 추가
3. **비용 관리 핵심**: LLM + 이미지 생성 비용이 주요 운영 비용

### 12.2 즉시 해결해야 할 질문

> [!WARNING]
> 프로젝트 진행 전 다음 질문들에 대한 답이 필요합니다:

1. **비즈니스 모델**: 무료 / 유료 / 프리미엄?
2. **API 키 관리**: 사용자 제공 vs 서비스 제공?
3. **ComfyUI 호스팅**: 로컬 vs 클라우드?
4. **데이터 정책**: 서버 저장 vs 로컬 보관?

---

**보고서 작성자**: Backend Developer Agent
