import 'package:flutter/material.dart';

/// Message bubble widget - iMessage style
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
        left: isPartner ? 0 : 48,
        right: isPartner ? 48 : 0,
      ),
      child: Column(
        crossAxisAlignment:
            isPartner ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          // Actions - Above bubble, small italic text
          if (hasActions)
            Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 12, right: 12),
              child: Text(
                actions!.map((a) => a).join(' '),
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ),

          // Dialogue Bubble
          if (hasDialogues)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isPartner
                    ? (isDark ? const Color(0xFF262628) : const Color(0xFFE9E9EB))
                    : const Color(0xFF007AFF),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isPartner ? 4 : 18),
                  bottomRight: Radius.circular(isPartner ? 18 : 4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: dialogues!
                    .map((dialogue) => Padding(
                          padding: EdgeInsets.only(
                            bottom: dialogues!.last == dialogue ? 0 : 4,
                          ),
                          child: Text(
                            dialogue,
                            style: TextStyle(
                              fontSize: 16,
                              color: isPartner
                                  ? (isDark ? Colors.white : Colors.black87)
                                  : Colors.white,
                              height: 1.3,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),

          // Inner Thought - Below bubble (Partner only)
          if (isPartner && innerThought != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '💭 ',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                  Flexible(
                    child: Text(
                      innerThought!,
                      style: TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: isDark ? Colors.grey[500] : Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
