import 'package:flutter/material.dart';

import '../../../config/theme.dart';

/// Choice card widget for user action selection
class ChoiceCard extends StatelessWidget {
  final String action;
  final String? speech;
  final int successRate;
  final String reasoning;
  final bool isSpecial;
  final VoidCallback onTap;

  const ChoiceCard({
    super.key,
    required this.action,
    this.speech,
    required this.successRate,
    required this.reasoning,
    required this.isSpecial,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final successColor = _getSuccessColor();

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSpecial
            ? const BorderSide(color: Colors.amber, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Special indicator
              if (isSpecial)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        'Special Choice',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.amber[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              // Action
              Text(
                action,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              // Speech
              if (speech != null) ...[
                const SizedBox(height: 4),
                Text(
                  speech!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
              const SizedBox(height: 8),
              // Success Rate and Reasoning
              Row(
                children: [
                  Icon(
                    _getSuccessIcon(),
                    size: 14,
                    color: successColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$successRate%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '|',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      reasoning,
                      style: TextStyle(
                        fontSize: 12,
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
    );
  }

  Color _getSuccessColor() {
    if (successRate >= 70) return QualiaTheme.successHigh;
    if (successRate >= 40) return QualiaTheme.successMedium;
    return QualiaTheme.successLow;
  }

  IconData _getSuccessIcon() {
    if (successRate >= 70) return Icons.check_circle;
    if (successRate >= 40) return Icons.warning;
    return Icons.cancel;
  }
}
