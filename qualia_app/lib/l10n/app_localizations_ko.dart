// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Qualia';

  @override
  String get settings => '설정';

  @override
  String get appearance => '외관';

  @override
  String get theme => '테마';

  @override
  String get themeDescription => '원하는 테마를 선택하세요';

  @override
  String get themeLight => '라이트';

  @override
  String get themeDark => '다크';

  @override
  String get themeSystem => '시스템';

  @override
  String get language => '언어';

  @override
  String get languageDescription => '원하는 언어를 선택하세요';

  @override
  String get comfyUI => 'ComfyUI';

  @override
  String get ipAddress => 'IP 주소';

  @override
  String get ipAddressHint => '로컬 ComfyUI 서버 주소';

  @override
  String get port => '포트';

  @override
  String get portHint => '기본값: 8188';

  @override
  String get testConnection => '연결 테스트';

  @override
  String get connected => '연결됨';

  @override
  String get disconnected => '연결 안됨';

  @override
  String get openRouter => 'OpenRouter';

  @override
  String get apiKey => 'API 키';

  @override
  String get apiKeyHint => 'openrouter.ai에서 키를 발급받으세요';

  @override
  String get verifySync => '확인 및 동기화';

  @override
  String get authenticated => '인증됨';

  @override
  String get notConnected => '연결 안됨';

  @override
  String get creditBalance => '크레딧 잔액';

  @override
  String get agentSettings => '에이전트 설정';

  @override
  String get partnerAgent => '파트너 에이전트';

  @override
  String get partnerAgentDesc => '파트너의 대사, 행동, 감정 반응을 생성합니다';

  @override
  String get scenarioDirector => '시나리오 디렉터';

  @override
  String get scenarioDirectorDesc => '내러티브 흐름과 월드 상태 변화를 관리합니다';

  @override
  String get visualDirector => '비주얼 디렉터';

  @override
  String get visualDirectorDesc => '장면 컨텍스트에서 이미지 프롬프트를 생성합니다';

  @override
  String get strategist => '전략가';

  @override
  String get strategistDesc => '성공률이 포함된 플레이어 선택지를 생성합니다';

  @override
  String get scenarioGenerator => '시나리오 생성기';

  @override
  String get scenarioGeneratorDesc => '초기 시나리오와 파트너 프로필을 생성합니다';

  @override
  String get sdxlTransformer => 'SDXL 변환기';

  @override
  String get sdxlTransformerDesc => '자연어를 SDXL 프롬프트 태그로 변환합니다';

  @override
  String get model => '모델';

  @override
  String get modelHint => '이 에이전트의 LLM 모델';

  @override
  String get temperature => '온도';

  @override
  String get temperatureHint => '창의성 레벨 (0 = 결정적, 1 = 창의적)';

  @override
  String get maxTokens => '최대 토큰';

  @override
  String get maxTokensHint => '응답 최대 길이';

  @override
  String get newSession => '새 세션';

  @override
  String get selectStyle => '스타일 선택';

  @override
  String get chooseVisualStyle => '비주얼 스타일 선택';

  @override
  String get visualStyleDesc => '이미지 생성에 사용될 AI 모델을 결정합니다';

  @override
  String get customizePreset => '프리셋 커스터마이즈';

  @override
  String get customizePresetInfo => '프리셋 설정을 커스터마이즈하세요. 이 세션의 모든 이미지에 적용됩니다.';

  @override
  String get reset => '초기화';

  @override
  String get next => '다음';

  @override
  String get nextCustomize => '다음: 커스터마이즈';

  @override
  String get nextChoosePartner => '다음: 파트너 선택';

  @override
  String get userGender => '당신의 성별';

  @override
  String get whoAreYou => '당신은 누구인가요?';

  @override
  String get selectYourGender => '당신의 성별을 선택하세요';

  @override
  String get partnerGender => '파트너 성별';

  @override
  String get whoToMeet => '누구를 만나고 싶나요?';

  @override
  String get selectPartnerGender => '파트너의 성별을 선택하세요';

  @override
  String get female => '여성';

  @override
  String get male => '남성';

  @override
  String get other => '기타';

  @override
  String get random => '랜덤';

  @override
  String get generatePartner => '파트너 생성';

  @override
  String get generating => '생성 중...';

  @override
  String get creatingPartner => '파트너를 생성하고 있습니다...';

  @override
  String get generatingScenario => '시나리오와 외모를 생성 중';

  @override
  String get ready => '준비 완료!';

  @override
  String get partnerReady => '파트너 준비 완료!';

  @override
  String get scenarioGenerated => '시나리오가 생성되었습니다.\n시작을 눌러 스토리를 시작하세요.';

  @override
  String get reroll => '다시 뽑기';

  @override
  String get start => '시작';

  @override
  String get realistic => '리얼리스틱';

  @override
  String get realisticDesc => '디테일한 사실적 초상화';

  @override
  String get anime => '애니메';

  @override
  String get animeDesc => '선명한 색상의 애니메 스타일';

  @override
  String get semiRealistic => '세미 리얼리스틱';

  @override
  String get semiRealisticDesc => '유연한 스코어 기반 프롬프팅';

  @override
  String get presetModelConfig => '모델 설정';

  @override
  String get checkpointModel => '체크포인트 모델';

  @override
  String get vae => 'VAE (선택)';

  @override
  String get upscaler => '업스케일러 (선택)';

  @override
  String get generationParams => '생성 파라미터';

  @override
  String get steps => '스텝';

  @override
  String get cfgScale => 'CFG 스케일';

  @override
  String get sampler => '샘플러';

  @override
  String get scheduler => '스케줄러';

  @override
  String get imageSize => '이미지 크기';

  @override
  String get portrait => '세로';

  @override
  String get square => '정사각형';

  @override
  String get landscape => '가로';

  @override
  String get defaultPrompts => '기본 프롬프트';

  @override
  String get positivePrompt => '긍정 프롬프트';

  @override
  String get negativePrompt => '부정 프롬프트';

  @override
  String get sessions => '세션';

  @override
  String get noSessions => '세션이 없습니다';

  @override
  String get createFirstSession => '첫 번째 세션을 만들어 시작하세요';

  @override
  String get chat => '채팅';

  @override
  String get typeMessage => '메시지를 입력하세요...';

  @override
  String get send => '전송';

  @override
  String get cancel => '취소';

  @override
  String get save => '저장';

  @override
  String get delete => '삭제';

  @override
  String get confirm => '확인';

  @override
  String get edit => '편집';
}
