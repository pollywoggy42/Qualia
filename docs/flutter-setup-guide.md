# Flutter 설치 가이드 (macOS)

## 방법 1: 공식 사이트에서 직접 다운로드 (추천 - 빠름)

### 1. Flutter SDK 다운로드
1. 브라우저에서 https://docs.flutter.dev/get-started/install/macos 접속
2. **Apple Silicon (M1/M2/M3)** 또는 **Intel** 버전 선택
3. `flutter_macos_arm64_3.x.x-stable.zip` 다운로드

### 2. 압축 해제 및 설치
```bash
cd ~/Downloads
unzip flutter_macos_arm64_*.zip
sudo mv flutter /usr/local/
```

### 3. PATH 설정
```bash
# zsh 사용 시 (기본)
echo 'export PATH="$PATH:/usr/local/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# bash 사용 시
echo 'export PATH="$PATH:/usr/local/flutter/bin"' >> ~/.bash_profile
source ~/.bash_profile
```

### 4. 설치 확인
```bash
flutter --version
flutter doctor
```

---

## 방법 2: Homebrew (현재 진행 중이지만 느림)

현재 실행 중인 명령어를 취소하고 다시 시도하거나, 완료될 때까지 기다리세요.

```bash
# 현재 실행 중
brew install --cask flutter
```

---

## Flutter 초기 설정

### 1. Flutter Doctor 실행
```bash
flutter doctor
```

이 명령어가 필요한 의존성을 체크합니다:
- ✅ Flutter SDK
- ⚠️ Xcode (iOS 개발용)
- ⚠️ Android Studio (Android 개발용)
- ⚠️ Chrome (웹 개발용)

### 2. 웹 지원 활성화
```bash
flutter config --enable-web
```

### 3. 필요한 도구 설치 (선택)

#### Chrome (웹 개발용)
이미 설치되어 있을 가능성이 높습니다.

#### Xcode (iOS/macOS 개발용)
```bash
# App Store에서 설치하거나
xcode-select --install
```

#### Android Studio (Android 개발용)
나중에 필요할 때 설치해도 됩니다.

---

## Flutter 프로젝트 생성

설치가 완료되면:

```bash
cd /Users/wschoi/Documents/Projects/Qualia

# Flutter 프로젝트 생성
flutter create qualia_app --platforms=web,ios,android,macos,windows

cd qualia_app

# 웹에서 실행
flutter run -d chrome
```

---

## 빠른 테스트

설치 후 바로 테스트:

```bash
# 웹 브라우저에서 실행
flutter run -d web-server

# 또는 Chrome에서 실행
flutter run -d chrome
```

---

## 문제 해결

### Flutter 명령어를 찾을 수 없는 경우
```bash
# PATH 확인
echo $PATH

# Flutter 경로 확인
which flutter

# PATH 다시 로드
source ~/.zshrc
```

### 권한 문제
```bash
sudo chown -R $(whoami) /usr/local/flutter
```

---

## 다음 단계

Flutter 설치가 완료되면:
1. ✅ `flutter --version` 확인
2. ✅ `flutter doctor` 실행하여 상태 확인
3. ✅ 프로젝트 생성 및 웹에서 실행 테스트
4. 📋 데이터 모델 설계 시작
