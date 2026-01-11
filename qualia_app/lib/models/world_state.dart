import 'package:freezed_annotation/freezed_annotation.dart';

import 'visual_descriptor.dart';

part 'world_state.freezed.dart';
part 'world_state.g.dart';

/// World State - 세계의 물리적 환경 및 서사적 상태
@freezed
class WorldState with _$WorldState {
  const factory WorldState({
    // 물리적 환경
    required DateTime currentTime,
    required String weather,

    // 서사적 상태 (Scenario Director가 관리)
    VisualDescriptor? currentSituation,
    String? ongoingEvent,
    @Default('Neutral') String emotionalAtmosphere,

    // 메타 정보
    @Default(0) int turnCount,
  }) = _WorldState;

  factory WorldState.fromJson(Map<String, dynamic> json) =>
      _$WorldStateFromJson(json);
}
