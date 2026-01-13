import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/session_provider.dart';
import 'widgets/session_card.dart';
import 'widgets/empty_state.dart';

/// Session List View - Main home screen
class SessionListView extends ConsumerWidget {
  const SessionListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch session list from provider
    final sessions = ref.watch(sessionListProvider);

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
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return SessionCard(
                  session: session,
                  onTap: () => context.push('/chat/${session.id}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/new-session'),
        icon: const Icon(Icons.add),
        label: const Text('New Session'),
      ),
    );
  }
}
