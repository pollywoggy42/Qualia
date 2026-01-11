import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'widgets/session_card.dart';
import 'widgets/empty_state.dart';

/// Session List View - Main home screen
class SessionListView extends ConsumerWidget {
  const SessionListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Replace with actual session data from provider
    final sessions = <SessionListItem>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Qualia'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: sessions.isEmpty
          ? const EmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sessions.length + 1, // +1 for new session button
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildNewSessionButton(context);
                }
                final session = sessions[index - 1];
                return SessionCard(session: session);
              },
            ),
      floatingActionButton: sessions.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () => context.push('/new-session'),
              icon: const Icon(Icons.add),
              label: const Text('New Session'),
            ),
    );
  }

  Widget _buildNewSessionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ElevatedButton.icon(
        onPressed: () => context.push('/new-session'),
        icon: const Icon(Icons.add),
        label: const Text('New Session'),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
        ),
      ),
    );
  }
}

/// Temporary data class - will be moved to models
class SessionListItem {
  final String sessionId;
  final String partnerName;
  final int partnerAge;
  final String? lastImageUrl;
  final String lastMemorySummary;
  final DateTime lastActiveAt;
  final int turnCount;
  final bool isNSFW;

  SessionListItem({
    required this.sessionId,
    required this.partnerName,
    required this.partnerAge,
    this.lastImageUrl,
    required this.lastMemorySummary,
    required this.lastActiveAt,
    required this.turnCount,
    this.isNSFW = false,
  });
}
