import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../config/theme.dart';

/// User Panel - Shows loading states, choices, and current action
/// This replaces the separate choice cards with an integrated panel
class UserPanel extends StatelessWidget {
  final bool isProcessing;
  final int processingStage; // 0-3
  final List<StrategyChoice>? choices;
  final Function(int)? onChoiceSelected;

  const UserPanel({
    super.key,
    this.isProcessing = false,
    this.processingStage = 0,
    this.choices,
    this.onChoiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDark ? 40 : 15),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          _buildHeader(context, isDark),

          // Content - Loading or Choices
          if (isProcessing)
            _buildLoadingContent(context, isDark)
          else if (choices != null && choices!.isNotEmpty)
            _buildChoicesContent(context, isDark),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    final statusText = isProcessing
        ? _getProcessingText()
        : 'Your Turn';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withAlpha(8)
            : Colors.grey.withAlpha(15),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          if (isProcessing)
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          else
            Icon(
              Icons.touch_app_rounded,
              size: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          const SizedBox(width: 10),
          Text(
            statusText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const Spacer(),
          if (isProcessing)
            Text(
              '${processingStage + 1}/4',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingContent(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Progress dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              final isActive = index <= processingStage;
              final isCurrent = index == processingStage;
              return Container(
                width: isCurrent ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isActive
                      ? Theme.of(context).colorScheme.primary
                      : (isDark ? Colors.grey[700] : Colors.grey[300]),
                  borderRadius: BorderRadius.circular(4),
                ),
              ).animate(target: isCurrent ? 1 : 0).shimmer(
                    duration: const Duration(milliseconds: 1000),
                    color: Colors.white24,
                  );
            }),
          ),
          const SizedBox(height: 16),
          Text(
            _getProcessingDescription(),
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoicesContent(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Column(
        children: choices!.asMap().entries.map((entry) {
          final index = entry.key;
          final choice = entry.value;
          return _ChoiceItem(
            choice: choice,
            isDark: isDark,
            onTap: () => onChoiceSelected?.call(index),
          );
        }).toList(),
      ),
    );
  }

  String _getProcessingText() {
    switch (processingStage) {
      case 0:
        return 'Partner is responding...';
      case 1:
        return 'Scene is developing...';
      case 2:
        return 'Creating image...';
      case 3:
        return 'Preparing choices...';
      default:
        return 'Processing...';
    }
  }

  String _getProcessingDescription() {
    switch (processingStage) {
      case 0:
        return 'Thinking about your action...';
      case 1:
        return 'Writing the narrative...';
      case 2:
        return 'Generating visual scene...';
      case 3:
        return 'Analyzing possible actions...';
      default:
        return '';
    }
  }
}

class _ChoiceItem extends StatelessWidget {
  final StrategyChoice choice;
  final bool isDark;
  final VoidCallback onTap;

  const _ChoiceItem({
    required this.choice,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final successColor = _getSuccessColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withAlpha(8)
                  : Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(14),
              border: choice.isSpecial
                  ? Border.all(color: Colors.amber.withAlpha(150), width: 1.5)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Special badge
                if (choice.isSpecial)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome,
                            size: 12, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          'Special',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[700],
                          ),
                        ),
                      ],
                    ),
                  ),

                // Action text
                Text(
                  choice.action,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),

                // Speech
                if (choice.speech != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '"${choice.speech}"',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],

                const SizedBox(height: 8),

                // Success rate row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getSuccessIcon(),
                            size: 12,
                            color: successColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${choice.successRate}%',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        choice.reasoning,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getSuccessColor() {
    if (choice.successRate >= 70) return QualiaTheme.successHigh;
    if (choice.successRate >= 40) return QualiaTheme.successMedium;
    return QualiaTheme.successLow;
  }

  IconData _getSuccessIcon() {
    if (choice.successRate >= 70) return Icons.check_circle_outline;
    if (choice.successRate >= 40) return Icons.info_outline;
    return Icons.warning_amber_rounded;
  }
}

/// Strategy choice data class
class StrategyChoice {
  final String action;
  final String? speech;
  final int successRate;
  final String reasoning;
  final bool isSpecial;

  const StrategyChoice({
    required this.action,
    this.speech,
    required this.successRate,
    required this.reasoning,
    this.isSpecial = false,
  });
}
