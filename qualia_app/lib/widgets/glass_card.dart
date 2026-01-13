import 'dart:ui';
import 'package:flutter/material.dart';

enum GlassLayer {
  base, // Background layer (e.g. Navigation)
  middle, // Content info cards
  top, // Popups, distinct elements
}

/// Glass Card - High fidelity Glassmorphism card for iOS 26 style
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final GlassLayer layer;
  final VoidCallback? onTap;
  final bool isSelected;
  final Gradient? customGradient;
  final Color? selectedBorderColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 20,
    this.layer = GlassLayer.middle,
    this.onTap,
    this.isSelected = false,
    this.customGradient,
    this.selectedBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Layer-specific configurations
    final double blur = _getBlurAmount(layer);
    final Color tintColor = _getTintColor(context, layer, isDark);
    final Border? border = _getBorder(context, layer, isDark, isSelected);
    final List<BoxShadow> shadows = _getShadows(layer, isDark);

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: padding ?? const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: tintColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: border,
                boxShadow: shadows,
                gradient: customGradient ??
                    LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withAlpha(isDark ? 10 : 40),
                        Colors.white.withAlpha(isDark ? 5 : 10),
                      ],
                      stops: const [0.0, 1.0],
                    ),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  double _getBlurAmount(GlassLayer layer) {
    switch (layer) {
      case GlassLayer.base:
        return 20.0;
      case GlassLayer.middle:
        return 12.0;
      case GlassLayer.top:
        return 8.0;
    }
  }

  Color _getTintColor(BuildContext context, GlassLayer layer, bool isDark) {
    if (isSelected) {
      return Theme.of(context).colorScheme.primary.withAlpha(40);
    }

    // Spec: Balanced opacity (Dark ~8%, Light ~71%)
    // Adjusting based on layer hierarchy
    switch (layer) {
      case GlassLayer.base:
        return isDark
            ? Colors.white.withAlpha(15)  // ~6%
            : Colors.white.withAlpha(160); // ~63%
      case GlassLayer.middle:
        return isDark
            ? Colors.white.withAlpha(20)  // ~8%
            : Colors.white.withAlpha(180); // ~71%
      case GlassLayer.top:
        return isDark
            ? Colors.white.withAlpha(30)  // ~12%
            : Colors.white.withAlpha(200); // ~78%
    }
  }

  Border? _getBorder(
      BuildContext context, GlassLayer layer, bool isDark, bool isSelected) {
    if (isSelected) {
      final color = selectedBorderColor ?? Theme.of(context).colorScheme.primary.withAlpha(150);
      return Border.all(
        color: color,
        width: 1.5,
      );
    }

    final double alpha = isDark ? 0.2 : 0.5; // Slightly reduced for cleaner look
    final Color borderColor = Colors.white.withOpacity(alpha);

    return Border.all(
      color: borderColor.withAlpha(layer == GlassLayer.top ? 40 : 20),
      width: 0.5,
    );
  }

  List<BoxShadow> _getShadows(GlassLayer layer, bool isDark) {
    // Spec: Multi-layer shadows for depth
    // Not strictly following layer logic for now, using the robust shadow stack for all non-base cards
    if (layer == GlassLayer.base) return [];

    return [
      BoxShadow(
        color: Colors.black.withAlpha(isDark ? 80 : 8),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
      BoxShadow(
        color: Colors.black.withAlpha(isDark ? 40 : 5),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
      BoxShadow(
        color: Colors.black.withAlpha(isDark ? 20 : 3),
        blurRadius: 40,
        offset: const Offset(0, 16),
      ),
    ];
  }
}

/// Glass Button - Premium interactive button
class GlassButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final double borderRadius;

  const GlassButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.isPrimary = false,
    this.borderRadius = 14,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return ScaleTransition(
      scale: const AlwaysStoppedAnimation(1.0), // Placeholder for press scale
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              splashColor: primaryColor.withAlpha(40),
              highlightColor: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(borderRadius),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                decoration: BoxDecoration(
                  color: isPrimary
                      ? primaryColor.withAlpha(200)
                      : (isDark
                          ? Colors.white.withAlpha(25)
                          : Colors.white.withAlpha(160)),
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: isPrimary
                        ? Colors.white.withAlpha(50)
                        : Colors.white.withAlpha(isDark ? 30 : 100),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        size: 18,
                        color: isPrimary
                            ? Colors.white
                            : (isDark ? Colors.white : Colors.black87),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: isPrimary
                            ? Colors.white
                            : (isDark ? Colors.white : Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Glass Chip - Compact tag element
class GlassChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;

  const GlassChip({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipColor = color ?? Theme.of(context).colorScheme.primary;

    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: chipColor.withAlpha(isDark ? 40 : 25),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: chipColor.withAlpha(80),
                  width: 0.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 14, color: chipColor),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: chipColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
