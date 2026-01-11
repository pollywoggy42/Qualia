import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/models.dart';
import 'storage_provider.dart';

part 'session_provider.g.dart';

/// 세션 목록 Provider
@riverpod
class SessionList extends _$SessionList {
  @override
  List<Session> build() {
    final storage = ref.watch(storageServiceProvider);
    return storage.getAllSessions();
  }

  Future<void> createSession(Session session) async {
    final storage = ref.read(storageServiceProvider);
    await storage.saveSession(session);
    ref.invalidateSelf();
  }

  Future<void> deleteSession(String id) async {
    final storage = ref.read(storageServiceProvider);
    await storage.deleteSession(id);
    ref.invalidateSelf();
  }

  void refresh() {
    ref.invalidateSelf();
  }
}

/// 현재 세션 Provider
@riverpod
class CurrentSession extends _$CurrentSession {
  @override
  Session? build(String sessionId) {
    final storage = ref.watch(storageServiceProvider);
    return storage.getSession(sessionId);
  }

  Future<void> updateSession(Session session) async {
    final storage = ref.read(storageServiceProvider);
    await storage.saveSession(session);
    ref.invalidateSelf();
  }

  /// 메시지 추가
  Future<void> addMessage(ChatMessage message) async {
    final current = state;
    if (current == null) return;

    final updated = current.copyWith(
      messages: [...current.messages, message],
      lastActiveAt: DateTime.now(),
      worldState: current.worldState.copyWith(
        turnCount: current.worldState.turnCount + 1,
      ),
    );

    await updateSession(updated);
  }

  /// 이미지 추가
  Future<void> addImage(GeneratedImage image) async {
    final current = state;
    if (current == null) return;

    final updated = current.copyWith(
      images: [...current.images, image],
      lastActiveAt: DateTime.now(),
    );

    await updateSession(updated);
  }

  /// 파트너 감정 상태 업데이트
  Future<void> updatePartnerEmotionalState(PartnerEmotionalState emotionalState) async {
    final current = state;
    if (current == null) return;

    final updated = current.copyWith(
      partner: current.partner.copyWith(
        emotionalState: emotionalState,
      ),
      lastActiveAt: DateTime.now(),
    );

    await updateSession(updated);
  }

  /// 월드 상태 업데이트
  Future<void> updateWorldState(WorldState worldState) async {
    final current = state;
    if (current == null) return;

    final updated = current.copyWith(
      worldState: worldState,
      lastActiveAt: DateTime.now(),
    );

    await updateSession(updated);
  }
}

/// 세션 메시지 목록
@riverpod
List<ChatMessage> sessionMessages(SessionMessagesRef ref, String sessionId) {
  final session = ref.watch(currentSessionProvider(sessionId));
  return session?.messages ?? [];
}

/// 세션 이미지 목록
@riverpod
List<GeneratedImage> sessionImages(SessionImagesRef ref, String sessionId) {
  final session = ref.watch(currentSessionProvider(sessionId));
  return session?.images ?? [];
}
