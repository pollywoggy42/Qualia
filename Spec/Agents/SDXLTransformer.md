# SDXL Transformer Agent Specification

> **Version**: 1.0  
> **Last Updated**: 2026-01-10

## 역할

자연어 설명 → SDXL 태그 변환 (UI 헬퍼)

## 실행 시점

UI 요청 시 (사용자가 "Generate Tags" 버튼 클릭)

## 입력 데이터

```json
{
  "description": "큰 가슴을 가진 글래머러스한 몸매",
  "context": "body"
}
```

**Context 옵션**: `face`, `hairstyle`, `body`, `outfit`, `fetish`

## 출력 데이터

```json
[
  "voluptuous body",
  "large breasts",
  "curvy",
  "hourglass figure"
]
```

**출력 형식**: 단순 문자열 배열

## 핵심 책임

1. **정확한 변환**: 자연어의 의미를 SDXL 태그로 정확히 변환
2. **컨텍스트 인식**: 같은 단어도 맥락에 따라 다른 태그 생성
3. **NSFW 처리**: 성적 표현도 적절한 SDXL 태그로 변환

## 추천 LLM 모델

- **모델**: GPT-4o-mini
- **Temperature**: 0.3
- **Max Tokens**: 500
- **이유**: 간단한 변환 작업
