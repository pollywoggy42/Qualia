import 'package:flutter/material.dart';
import '../../../../widgets/glass_card.dart';

/// Message bubble widget - Premium iOS 26 style
/// Actions appear above bubble, inner thoughts below (partner only)
class MessageBubble extends StatelessWidget {
  final bool isPartner;
  final String? partnerName;
  final List<String>? actions;
  final List<String>? dialogues;
  final String? innerThought;

  const MessageBubble({
    super.key,
    required this.isPartner,
    this.partnerName,
    this.actions,
    this.dialogues,
    this.innerThought,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasDialogues = dialogues != null && dialogues!.isNotEmpty;
    final hasActions = actions != null && actions!.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(
        left: isPartner ? 0 : 60,
        right: isPartner ? 60 : 0,
      ),
      child: Column(
        crossAxisAlignment:
            isPartner ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          // Actions - Contextual narration
          if (hasActions)
            Padding(
              padding: const EdgeInsets.only(bottom: 6, left: 16, right: 16),
              child: Text(
                actions!.map((a) => '*$a*').join('\n'), // Multi-line actions support
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  fontStyle: FontStyle.italic,
                  color: isDark ? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.5),
                  letterSpacing: 0.2,
                ),
                textAlign: isPartner ? TextAlign.left : TextAlign.right,
              ),
            ),

          // Dialogue Bubble
          if (hasDialogues)
            ...dialogues!.map((dialogue) {
              final isLast = dialogues!.last == dialogue;
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 4),
                child: isPartner
                    ? _buildPartnerBubble(context, dialogue, isDark)
                    : _buildUserBubble(context, dialogue, isDark),
              );
            }),

          // Inner Thought - Hidden context
          if (isPartner && innerThought != null)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: GlassCard(
                layer: GlassLayer.base,
                borderRadius: 16,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.bubble_chart_outlined,
                      size: 14,
                      color: isDark ? Colors.purpleAccent.withOpacity(0.7) : Colors.purple.withOpacity(0.7),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        innerThought!,
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: isDark ? Colors.white.withOpacity(0.7) : Colors.black87.withOpacity(0.7),
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPartnerBubble(BuildContext context, String text, bool isDark) {
    return GlassCard(
      layer: GlassLayer.middle,
      borderRadius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          height: 1.4,
          letterSpacing: 0.1,
          color: isDark ? Colors.white.withOpacity(0.95) : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildUserBubble(BuildContext context, String text, bool isDark) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            primaryColor.withBlue(255).withRed(100), // Slight gradient shift
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(4),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          height: 1.4,
          letterSpacing: 0.1,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
