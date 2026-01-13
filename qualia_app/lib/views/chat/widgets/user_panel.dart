import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../models/models.dart';
import '../../../config/theme.dart';

/// User Panel - Shows loading states, choices, and current action
/// This replaces the separate choice cards with an integrated panel
class UserPanel extends StatefulWidget {
  final bool isProcessing;
  final int processingStage;
  final List<StrategyChoice>? choices;
  final ValueChanged<int>? onChoiceSelected;
  final VoidCallback? onRefresh;
  final ValueChanged<String>? onDirectInputSubmitted; // Changed to accept string

  const UserPanel({
    super.key,
    this.isProcessing = false,
    this.processingStage = 0,
    this.choices,
    this.onChoiceSelected,
    this.onRefresh,
    this.onDirectInputSubmitted,
  });

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  bool _isInputMode = false;
  final TextEditingController _inputController = TextEditingController();

  void _submitInput() {
    final text = _inputController.text.trim();
    if (text.isNotEmpty) {
      widget.onDirectInputSubmitted?.call(text);
      _inputController.clear();
      setState(() {
        _isInputMode = false;
      });
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isProcessing) {
      // Reset input mode if processing starts
      if (_isInputMode) {
        _isInputMode = false;
        _inputController.clear();
      }
      return _buildProcessingView(context);
    }
    
    // Check if we have choices to display
    final hasChoices = widget.choices != null && widget.choices!.isNotEmpty;
    
    // If no choices and not processing, generally shouldn't happen unless error or idle
    if (!hasChoices && !_isInputMode) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.4 : 0.15),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: _isInputMode 
          ? _buildInputView(context, isDark)
          : _buildChoicesView(context, isDark),
      ),
    );
  }

  Widget _buildProcessingView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.4 : 0.15),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context, isDark),
           Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Progress dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    final isCurrent = index == widget.processingStage;
                    final isActive = index <= widget.processingStage;
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
          ),
        ],
      ),
    );
  }

  Widget _buildChoicesView(BuildContext context, bool isDark) {
    return Column(
      key: const ValueKey('choices'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        _buildHeader(context, isDark),
        
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          child: Column(
            children: [
              // Choices List
              if (widget.choices != null)
                ...widget.choices!.asMap().entries.map((entry) {
                  return _ChoiceItem(
                    choice: entry.value,
                    isDark: isDark,
                    onTap: () => widget.onChoiceSelected?.call(entry.key),
                  );
                }),

              const SizedBox(height: 8),

              // Direct Input Card
              InkWell(
                onTap: () {
                  setState(() {
                    _isInputMode = true;
                  });
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Icon(
                       Icons.keyboard, 
                       size: 20,
                       color: Theme.of(context).colorScheme.primary,
                     ),
                     const SizedBox(width: 8),
                     Text(
                       '직접 입력하기', // "Direct Input"
                       style: TextStyle(
                         fontWeight: FontWeight.w600,
                         color: Theme.of(context).colorScheme.primary,
                       ),
                     ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputView(BuildContext context, bool isDark) {
    return Column(
      key: const ValueKey('input'),
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header with Back button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.03)
                : Colors.grey.withOpacity(0.06),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Row(
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.arrow_back_rounded, size: 20),
                onPressed: () {
                  setState(() {
                     _isInputMode = false;
                  });
                },
              ),
              const SizedBox(width: 8),
              Text(
                '직접 입력', // Direct Input
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),

        // Input Area
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _inputController,
                  autofocus: true, 
                  maxLines: 1,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: '행동이나 대사를 입력하세요...',
                    hintStyle: TextStyle(
                      color: isDark ? Colors.white30 : Colors.black38,
                    ),
                    filled: true,
                    fillColor: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onSubmitted: (_) => _submitInput(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                icon: const Icon(Icons.send_rounded, size: 20),
                onPressed: _submitInput,
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    final statusText = widget.isProcessing
        ? _getProcessingText()
        : 'Your Turn';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.03)
            : Colors.grey.withOpacity(0.06),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          if (widget.isProcessing)
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
          if (widget.isProcessing)
            Text(
              '${widget.processingStage + 1}/4',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            )
          else ...[
            if (widget.onRefresh != null)
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.refresh, size: 20),
                color: isDark ? Colors.white54 : Colors.grey[600],
                onPressed: widget.onRefresh,
                tooltip: 'New Choices',
              ),
          ],
        ],
      ),
    );
  }

  String _getProcessingText() {
    switch (widget.processingStage) {
      case 0: return 'Partner is responding...';
      case 1: return 'Scene is developing...';
      case 2: return 'Creating image...';
      case 3: return 'Preparing choices...';
      default: return 'Processing...';
    }
  }

  String _getProcessingDescription() {
    switch (widget.processingStage) {
      case 0: return 'Thinking about your action...';
      case 1: return 'Writing the narrative...';
      case 2: return 'Generating visual scene...';
      case 3: return 'Analyzing possible actions...';
      default: return '';
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
                  ? Colors.white.withOpacity(0.03) // fixed: withAlpha(8) -> withOpacity
                  : Colors.grey.withOpacity(0.08), // fixed: withAlpha(20) -> withOpacity
              borderRadius: BorderRadius.circular(14),
              border: choice.isSpecial
                  ? Border.all(color: Colors.amber.withOpacity(0.6), width: 1.5)
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
                  choice.action ?? 'Action',
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

                // Success rate & Reasoning
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: successColor.withOpacity(0.12),
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
                        choice.reasoning ?? '',
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
