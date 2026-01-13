import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/chat_provider.dart';

import '../../widgets/glass_card.dart';
import '../status/status_modal.dart';
import 'widgets/message_bubble.dart';
import 'widgets/user_panel.dart';
import 'widgets/narrator_block.dart';
import 'widgets/emotion_background.dart';

/// Chat View - Main conversation interface (iMessage/iOS 26 style)
class ChatView extends ConsumerStatefulWidget {
  final String sessionId;

  const ChatView({super.key, required this.sessionId});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  final ScrollController _scrollController = ScrollController();
  // No local state needed

  @override
  Widget build(BuildContext context) {
    // Watch provider
    final chatState = ref.watch(chatNotifierProvider(widget.sessionId));
    final chatNotifier = ref.read(chatNotifierProvider(widget.sessionId).notifier);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Use chatState data
    final isProcessing = chatState.isProcessing;
    final processingStage = chatState.processingStage.index;
    final choices = chatState.currentChoices;
    final lastImageUrl = chatState.lastImageUrl;

    return EmotionBackground(
      sessionId: widget.sessionId,
      child: Scaffold(
        backgroundColor: Colors.transparent, 
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.go('/'),
          ),
          title: GestureDetector(
            onTap: () => _showStatusModal(context),
            child: Column(
              children: [
                // Avatar (TODO: Use Partner Profile)
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.5,
                    ),
                    image: const DecorationImage(
                      image: NetworkImage('https://placekitten.com/100/100'), // TODO: Real image from profile
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Name & Status
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     const Text(
                      'Sakura', // TODO: Real name
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.greenAccent, blurRadius: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // TODO: Implement next chapter logic
              },
              child: const Text('Next Chapter'),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                children: [
                  // Generated Image
                  if (lastImageUrl != null)
                    _buildImageMessage(isDark, lastImageUrl)
                  else
                    // Placeholder or nothing if no image yet
                    const SizedBox.shrink(),

                  const SizedBox(height: 16),
  
                  // Narrator (TODO: Dynamic)
                  const NarratorBlock(
                    text: 'The rain begins to fall softly. Both of you start getting wet, the droplets glistening on your clothes...',
                  ),
                  const SizedBox(height: 16),
  
                  // Partner Message (TODO: Dynamic from messages list)
                  MessageBubble(
                    isPartner: true,
                    partnerName: 'Sakura',
                    actions: const ['Blushes and looks down', 'Covers her cheeks with hands'],
                    dialogues: const ['Ah... it\'s raining...', 'You\'re getting wet too...'],
                    innerThought: 'My heart is beating so fast...',
                  ),
                  const SizedBox(height: 20),
  
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
            
            // User Panel - Bottom
            UserPanel(
              isProcessing: isProcessing,
              processingStage: processingStage,
              choices: choices,
              onChoiceSelected: (index) {
                if (choices != null) {
                  chatNotifier.handleUserChoice(choices[index]);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageMessage(bool isDark, String imageUrl) {
    return GlassCard(
      layer: GlassLayer.middle,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            width: double.infinity,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(
                height: 200,
                child: Center(child: Icon(Icons.image_not_supported, size: 40)),
              ),
            ),
          ),
          // ... (Rest of UI)
          // Gradient Overlay Bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),

          // Scale hint
          Positioned(
            bottom: 12,
            right: 12,
            child: GlassChip(
              label: 'Expand',
              icon: Icons.fullscreen,
              color: Colors.white,
              onTap: () {}, // TODO: Implement full screen view
            ),
          ),
        ],
      ),
    );
  }
/*
  void _selectChoice(int index) {
     // Replaced by chatNotifier call inline above
  }

  // Removed _simulateProcessing
*/

  void _showStatusModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const StatusModal(),
    );
  }
}
