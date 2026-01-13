import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/scheduler.dart';
import '../../providers/chat_provider.dart';
import '../../providers/session_provider.dart';
import '../../models/models.dart';

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
    final messages = ref.watch(sessionMessagesProvider(widget.sessionId));
    final images = ref.watch(sessionImagesProvider(widget.sessionId));

    // Auto-scroll on new messages
    ref.listen(sessionMessagesProvider(widget.sessionId), (previous, next) {
      if (next.length > (previous?.length ?? 0)) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });

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
                  // Avatar
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
                      // TODO: Use partner face description or a placeholder that isn't network for now if offline
                      image: null, // Removed unstable NetworkImage
                    ),
                     child: chatState.partner != null 
                        ? Center(child: Text(chatState.partner!.name[0], style: const TextStyle(fontWeight: FontWeight.bold))) 
                        : const Center(child: Icon(Icons.person, color: Colors.grey)),
                  ),
                  const SizedBox(height: 4),
                  // Name & Status
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Text(
                        chatState.partner?.name ?? 'Loading...',
                        style: const TextStyle(
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
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: messages.length + 1, // +1 for spacing at bottom
                itemBuilder: (context, index) {
                  if (index == messages.length) {
                    return const SizedBox(height: 100); // Space for user panel
                  }
                  
                  final message = messages[index];
                  
                  // Wrap content including image if present
                  return Column(
                    children: [
                      // 1. Image (if present)
                      if (message.imageId != null)
                        Builder(
                          builder: (context) {
                             final image = images.firstWhere(
                               (img) => img.id == message.imageId,
                               orElse: () => GeneratedImage(id: '', url: '', prompt: '', createdAt: DateTime.now()), // Dummy
                             );
                             if (image.url.isNotEmpty) {
                               return Padding(
                                 padding: const EdgeInsets.only(bottom: 16.0),
                                 child: _buildImageMessage(isDark, image.url),
                               );
                             }
                             return const SizedBox.shrink();
                          }
                        ),
                        
                      // 2. Narrator (if present)
                      if (message.narration != null && message.narration!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: NarratorBlock(text: message.narration!),
                        ),
                        
                      // 3. Dialogue/Action Bubble
                      // Only show if there's dialogue, action, or inner thought
                      if ((message.dialogues != null && message.dialogues!.isNotEmpty) ||
                          (message.actions != null && message.actions!.isNotEmpty) ||
                          (message.innerThought != null && message.innerThought!.isNotEmpty))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: MessageBubble(
                            isPartner: message.type == MessageType.partner,
                            partnerName: message.type == MessageType.partner 
                                ? (chatState.partner?.name ?? 'Partner') 
                                : 'You',
                            actions: message.actions,
                            dialogues: message.dialogues,
                            innerThought: message.innerThought,
                          ),
                        ),
                    ],
                  );
                },
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
              onRefresh: () => chatNotifier.refreshChoices(),
              onDirectInputSubmitted: (text) => chatNotifier.handleDirectInput(text),
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
