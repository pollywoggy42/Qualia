import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../status/status_modal.dart';
import 'widgets/message_bubble.dart';
import 'widgets/user_panel.dart';
import 'widgets/narrator_block.dart';

/// Chat View - Main conversation interface (iMessage style)
class ChatView extends ConsumerStatefulWidget {
  final String sessionId;

  const ChatView({super.key, required this.sessionId});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  final ScrollController _scrollController = ScrollController();
  bool _isProcessing = false;
  int _processingStage = 0;

  // Sample choices for demo
  final List<StrategyChoice> _choices = const [
    StrategyChoice(
      action: 'Tilt umbrella towards her',
      speech: 'You\'ll get soaked, come closer',
      successRate: 85,
      reasoning: 'Considerate action',
    ),
    StrategyChoice(
      action: 'Take off your jacket and offer it',
      speech: 'Here, put this on',
      successRate: 75,
      reasoning: 'Protective gesture',
    ),
    StrategyChoice(
      action: 'Pull her close under the umbrella',
      successRate: 60,
      reasoning: 'Bold move',
      isSpecial: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF2F2F7),
      appBar: _buildAppBar(context, isDark),
      body: Column(
        children: [
          // Message List
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                const SizedBox(height: 8),

                // Generated Image
                _buildImageMessage(isDark),
                const SizedBox(height: 12),

                // Narrator
                const NarratorBlock(
                  text: 'The rain begins to fall softly. Both of you start getting wet, the droplets glistening on your clothes...',
                ),
                const SizedBox(height: 12),

                // Partner Message
                MessageBubble(
                  isPartner: true,
                  partnerName: 'Sakura',
                  actions: const ['Blushes and looks down', 'Covers her cheeks with hands'],
                  dialogues: const ['Ah... it\'s raining...', 'You\'re getting wet too...'],
                  innerThought: 'My heart is beating so fast...',
                ),
                const SizedBox(height: 16),

                // User Message (previous turn)
                MessageBubble(
                  isPartner: false,
                  actions: const ['Tilts umbrella towards her'],
                  dialogues: const ['You\'ll get soaked, come closer'],
                ),

                const SizedBox(height: 100), // Space for user panel
              ],
            ),
          ),

          // User Panel - Bottom fixed
          UserPanel(
            isProcessing: _isProcessing,
            processingStage: _processingStage,
            choices: _isProcessing ? null : _choices,
            onChoiceSelected: _selectChoice,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isDark) {
    return AppBar(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF2F2F7),
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () => context.go('/'),
      ),
      title: GestureDetector(
        onTap: () => _showStatusModal(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? Colors.grey[800] : Colors.grey[300],
              ),
              child: const Icon(Icons.person, size: 20, color: Colors.grey),
            ),
            const SizedBox(width: 10),
            // Name and status
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Sakura',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text('😳', style: TextStyle(fontSize: 14)),
                  ],
                ),
                Text(
                  'Flustered',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.skip_next_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            // Scene transition
          },
        ),
        PopupMenuButton<String>(
          icon: Icon(
            Icons.more_horiz,
            color: Theme.of(context).colorScheme.primary,
          ),
          onSelected: (value) {
            switch (value) {
              case 'info':
                _showStatusModal(context);
                break;
              case 'end':
                context.go('/');
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'info',
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20),
                  SizedBox(width: 12),
                  Text('Session Info'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'end',
              child: Row(
                children: [
                  Icon(Icons.exit_to_app, size: 20),
                  SizedBox(width: 12),
                  Text('End Session'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageMessage(bool isDark) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 280),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark ? Colors.grey[900] : Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            const Center(
              child: Icon(Icons.image_rounded, size: 48, color: Colors.grey),
            ),
            // Tap to expand overlay
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.fullscreen, size: 14, color: Colors.white70),
                    SizedBox(width: 4),
                    Text(
                      'Tap to expand',
                      style: TextStyle(fontSize: 10, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectChoice(int index) {
    setState(() {
      _isProcessing = true;
      _processingStage = 0;
    });
    _simulateProcessing();
  }

  Future<void> _simulateProcessing() async {
    for (int i = 0; i < 4; i++) {
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) {
        setState(() => _processingStage = i);
      }
    }
    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) {
      setState(() => _isProcessing = false);
    }
  }

  void _showStatusModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const StatusModal(),
    );
  }
}
