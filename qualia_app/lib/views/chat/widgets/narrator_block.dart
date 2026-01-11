import 'package:flutter/material.dart';

/// Narrator block - Visual novel style narration
/// Minimal, elegant design inspired by iMessage
class NarratorBlock extends StatelessWidget {
  final String text;

  const NarratorBlock({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        children: [
          // Divider line
          Container(
            height: 1,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  isDark ? Colors.white24 : Colors.black12,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Text
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
              height: 1.6,
              letterSpacing: 0.2,
            ),
          ),
          // Divider line
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  isDark ? Colors.white24 : Colors.black12,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
