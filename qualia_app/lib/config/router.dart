import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/session_list/session_list_view.dart';
import '../views/new_session/new_session_view.dart';
import '../views/chat/chat_view.dart';
import '../views/settings/settings_view.dart';

/// App Router Configuration
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Session List (Home)
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const SessionListView(),
    ),

    // New Session Flow
    GoRoute(
      path: '/new-session',
      name: 'newSession',
      builder: (context, state) => const NewSessionView(),
    ),

    // Chat View
    GoRoute(
      path: '/chat/:sessionId',
      name: 'chat',
      builder: (context, state) {
        final sessionId = state.pathParameters['sessionId']!;
        return ChatView(sessionId: sessionId);
      },
    ),

    // Settings
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsView(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri}'),
    ),
  ),
);
