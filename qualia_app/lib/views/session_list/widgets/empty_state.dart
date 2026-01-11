import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Empty state widget when no sessions exist
class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withAlpha(128),
            ),
            const SizedBox(height: 24),
            Text(
              'Start a New Story',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Create your first session and meet your partner',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.push('/new-session'),
              icon: const Icon(Icons.add),
              label: const Text('Create First Session'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 56),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
