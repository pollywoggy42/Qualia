import 'dart:ui';

import 'package:flutter/material.dart';

/// Glass Card - Glassmorphism 효과가 적용된 카드 위젯
/// 웹 호환, Light/Dark 모드 대응
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blurAmount;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? selectedBorderColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 16,
    this.blurAmount = 10,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.onTap,
    this.isSelected = false,
    this.selectedBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Glass 배경색 (iOS 26 Liquid Glass)
    final bgColor = backgroundColor ??
        (isDark
            ? Colors.white.withAlpha(20) // Slightly increased for better visibility
            : Colors.white.withAlpha(180));

    // Border 색상
    final effectiveBorderColor = isSelected
        ? (selectedBorderColor ?? Theme.of(context).colorScheme.primary)
        : (borderColor ??
            (isDark
                ? Colors.white.withAlpha(25)
                : Colors.white.withAlpha(100)));

    // iOS 26 Multi-layer shadows for depth
    final shadows = [
      // Near shadow (sharp, close)
      BoxShadow(
        color: isDark ? Colors.black.withAlpha(80) : Colors.black.withAlpha(8),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
      // Mid shadow (medium depth)
      BoxShadow(
        color: isDark ? Colors.black.withAlpha(40) : Colors.black.withAlpha(5),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
      // Far shadow (soft, ambient)
      BoxShadow(
        color: isDark ? Colors.black.withAlpha(20) : Colors.black.withAlpha(3),
        blurRadius: 40,
        offset: const Offset(0, 16),
      ),
    ];

    final container = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: effectiveBorderColor,
          width: isSelected ? 2 : borderWidth,
        ),
        boxShadow: shadows,
      ),
      child: child,
    );

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurAmount,
            sigmaY: blurAmount,
          ),
          child: onTap == null
              ? container  // No GestureDetector - allow child taps
              : GestureDetector(
                  onTap: onTap,
                  child: container,
                ),
        ),
      ),
    );
  }
}

/// Glass Button - Glassmorphism 스타일 버튼
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
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isPrimary
                    ? primaryColor.withAlpha(200)
                    : (isDark
                        ? Colors.white.withAlpha(20)
                        : Colors.white.withAlpha(150)),
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: isPrimary
                      ? primaryColor
                      : (isDark
                          ? Colors.white.withAlpha(30)
                          : Colors.white.withAlpha(100)),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: 18,
                      color: isPrimary ? Colors.white : null,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isPrimary ? Colors.white : null,
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

/// Glass Container - 배경 없는 Glass 효과 컨테이너
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blurAmount;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 16,
    this.blurAmount = 15,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurAmount,
          sigmaY: blurAmount,
        ),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black.withAlpha(40)
                : Colors.white.withAlpha(120),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: isDark
                  ? Colors.white.withAlpha(20)
                  : Colors.white.withAlpha(80),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Glass Modal - 모달/다이얼로그용 Glass 컨테이너
class GlassModal extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double maxWidth;

  const GlassModal({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 24,
    this.maxWidth = 400,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: padding ?? const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.grey[900]!.withAlpha(220)
                    : Colors.white.withAlpha(230),
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withAlpha(30)
                      : Colors.white.withAlpha(150),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 40,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Glass Chip - 태그/라벨용 Glass 칩
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
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: chipColor.withAlpha(isDark ? 50 : 30),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: chipColor.withAlpha(100),
                  width: 1,
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
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
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
