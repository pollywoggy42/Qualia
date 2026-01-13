import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/session_provider.dart';

/// Emotion Background - Dynamic atmospheric background
/// Changes colors and intensity based on partner's emotional state
class EmotionBackground extends ConsumerWidget {
  final String sessionId;
  final Widget child;

  const EmotionBackground({
    super.key,
    required this.sessionId,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(currentSessionProvider(sessionId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Default base colors
    Color topColor = isDark ? const Color(0xFF0F0F12) : const Color(0xFFF2F2F7);
    Color bottomColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    Color accentColor = Colors.transparent;

    if (session != null) {
      final emotions = session.partner.emotionalState;
      
      // Calculate dominant emotion influence
      // Normalize values 0-100 to 0.0-1.0 opacity influence
      final double affection = (emotions.affection / 100).clamp(0.0, 1.0);
      final double trust = (emotions.trust / 100).clamp(0.0, 1.0);
      final double arousal = (emotions.arousal / 100).clamp(0.0, 1.0);

      // Mix colors based on emotions
      // Affection -> Warm Pink/Rose
      // Trust -> Calm Blue/Teal
      // Arousal -> Intense Purple/Red
      
      // We use a simplified blending strategy:
      // The background will shift its hue towards the dominant emotion
      
      if (arousal > 0.6) {
        // High arousal dominates
        accentColor = const Color(0xFF5E5CE6).withOpacity(arousal * 0.3); // Purple
        bottomColor = Color.lerp(bottomColor, const Color(0xFFFF2D55), arousal * 0.1)!;
      } else if (affection > 0.5) {
        // High affection
        accentColor = const Color(0xFFFF375F).withOpacity(affection * 0.25); // Pink
        bottomColor = Color.lerp(bottomColor, const Color(0xFFFF9F0A), affection * 0.1)!;
      } else if (trust > 0.5) {
        // High trust
        accentColor = const Color(0xFF64D2FF).withOpacity(trust * 0.25); // Blue
        bottomColor = Color.lerp(bottomColor, const Color(0xFF30B0C7), trust * 0.05)!;
      }
    }

    return Stack(
      children: [
        // Base Gradient Layer
        AnimatedContainer(
          duration: const Duration(seconds: 2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [topColor, bottomColor],
            ),
          ),
        ),
        
        // Emotional Ambient Glow (Top Right)
        Positioned(
          top: -100,
          right: -100,
          child: AnimatedContainer(
            duration: const Duration(seconds: 3),
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  accentColor,
                  accentColor.withOpacity(0),
                ],
              ),
            ),
          ),
        ),

        // Emotional Ambient Glow (Bottom Left)
         Positioned(
          bottom: -50,
          left: -100,
          child: AnimatedContainer(
            duration: const Duration(seconds: 4),
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  accentColor.withOpacity(0.5),
                  accentColor.withOpacity(0),
                ],
              ),
            ),
          ),
        ),

        // Content
        child,
      ],
    );
  }
}
