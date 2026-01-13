import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/scheduler.dart';
import '../../providers/chat_provider.dart';
import '../../providers/session_provider.dart';
import '../../models/models.dart';

import '../../widgets/glass_card.dart';
import '../../widgets/image_lightbox.dart';
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
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    backgroundImage: chatState.profileImageUrl != null 
                        ? NetworkImage(chatState.profileImageUrl!) 
                        : null,
                    child: chatState.profileImageUrl == null && chatState.partner != null 
                        ? Text(
                            chatState.partner!.name[0], 
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ) 
                        : (chatState.partner == null ? const Icon(Icons.person, color: Colors.grey) : null),
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
        body: Stack(
          children: [
            // Chat messages
            ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 20,
                bottom: MediaQuery.of(context).size.height * 0.35, // Space for draggable panel
              ),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                
                // Wrap content including image if present
                return Column(
                  children: [
                    // 1. Dialogue/Action Bubble (Partner or User dialogue)
                    if (message.dialogues != null && message.dialogues!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: MessageBubble(
                          isPartner: message.type == MessageType.partner,
                          partnerName: chatState.partner?.name ?? 'Partner',
                          actions: message.actions,
                          dialogues: message.dialogues,
                          innerThought: message.innerThought,
                        ),
                      ),
                      
                    // 2. Narrator/Director Response (if present)
                    if (message.narration != null && message.narration!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: NarratorBlock(text: message.narration!),
                      ),
                      
                    // 3. Image (after director response)
                    if (message.imageId != null)
                      Builder(
                        builder: (context) {
                           final image = images.firstWhere(
                             (img) => img.id == message.imageId,
                             orElse: () => GeneratedImage(id: '', url: '', prompt: '', createdAt: DateTime.now()),
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
                  ],
                );
              },
            ),
            
            // Draggable User Panel
            DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.15,
              maxChildSize: 0.5,
              snap: true,
              snapSizes: const [0.15, 0.3, 0.5],
              builder: (context, scrollController) {
                return UserPanel(
                  scrollController: scrollController,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageMessage(bool isDark, String imageUrl) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: GestureDetector(
          onTap: () {
            // Open lightbox on tap
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => ImageLightbox(imageUrl: imageUrl),
              ),
            );
          },
          child: Hero(
            tag: 'image_$imageUrl',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    // Fade in when loaded
                    return AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 500),
                      child: child,
                    );
                  }
                  return AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 40),
                  ),
                ),
              ),
            ),
          ),
        ),
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
