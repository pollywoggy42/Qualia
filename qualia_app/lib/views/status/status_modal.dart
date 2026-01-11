import 'package:flutter/material.dart';

import '../../config/theme.dart';

/// Status Modal - Shows Partner, User, and Director information
class StatusModal extends StatefulWidget {
  const StatusModal({super.key});

  @override
  State<StatusModal> createState() => _StatusModalState();
}

class _StatusModalState extends State<StatusModal>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status Info',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              // Tab Bar
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Partner'),
                  Tab(text: 'User'),
                  Tab(text: 'Director'),
                ],
              ),
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPartnerTab(scrollController),
                    _buildUserTab(scrollController),
                    _buildDirectorTab(scrollController),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPartnerTab(ScrollController scrollController) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        // Profile Image
        Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: const Icon(Icons.person, size: 60, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 16),
        // Name and Age
        Center(
          child: Text(
            'Sakura, 22',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Center(
          child: Text(
            'University Student',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ),
        const SizedBox(height: 24),
        // Emotional State
        _buildSectionTitle('Emotional State', Icons.favorite),
        const SizedBox(height: 12),
        _buildStatBar('Affection', 65, QualiaTheme.affectionPink),
        _buildStatBar('Trust', 70, QualiaTheme.trustBlue),
        _buildStatBar('Arousal', 60, QualiaTheme.arousalOrange),
        _buildStatBar('Lust', 45, QualiaTheme.lustRed),
        _buildDominanceBar('Dominance', -20),
        _buildMoodRow('Flustered', '😳'),
        const SizedBox(height: 24),
        // Personality
        _buildSectionTitle('Personality', Icons.person),
        const SizedBox(height: 12),
        _buildInfoRow('MBTI', 'INFP'),
        _buildInfoRow('Speech Style', 'Polite'),
        _buildInfoRow('Traits', 'Introverted, Emotional, Caring'),
        const SizedBox(height: 24),
        // Appearance
        _buildSectionTitle('Appearance', Icons.brush),
        const SizedBox(height: 12),
        _buildInfoRow('Face', 'Large eyes, soft smile'),
        _buildInfoRow('Hair', 'Blonde ponytail'),
        _buildInfoRow('Body', 'Slender and elegant'),
        _buildInfoRow('Outfit', 'White blouse, black skirt'),
        const SizedBox(height: 24),
        // Secret
        _buildSectionTitle('Secret', Icons.lock),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.lock, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                '??? (Trust 80+ to reveal)',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserTab(ScrollController scrollController) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        // Basic Info
        Center(
          child: Text(
            'Junho, 24',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Center(
          child: Text(
            'Graduate Student',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ),
        const SizedBox(height: 24),
        // Personality
        _buildSectionTitle('Personality', Icons.person),
        const SizedBox(height: 12),
        _buildInfoRow('MBTI', 'ENFP'),
        _buildInfoRow('Speech Style', 'Casual'),
        _buildInfoRow('Traits', 'Extroverted, Curious, Optimistic'),
        const SizedBox(height: 24),
        // Appearance
        _buildSectionTitle('Appearance', Icons.brush),
        const SizedBox(height: 12),
        _buildInfoRow('Face', 'Average, friendly'),
        _buildInfoRow('Hair', 'Short black hair'),
        _buildInfoRow('Body', 'Average build'),
        _buildInfoRow('Outfit', 'Gray hoodie, jeans'),
      ],
    );
  }

  Widget _buildDirectorTab(ScrollController scrollController) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        // World State
        _buildSectionTitle('World State', Icons.public),
        const SizedBox(height: 12),
        _buildInfoRow('Time', '2024-01-10 18:30 (Evening)'),
        _buildInfoRow('Weather', 'Rainy 🌧️'),
        _buildInfoRow('Partner Location', 'Park'),
        _buildInfoRow('User Location', 'Park'),
        _buildInfoRow('Atmosphere', 'Romantic'),
        const SizedBox(height: 24),
        // Current Situation
        _buildSectionTitle('Current Situation', Icons.place),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            '"The rain is falling and both of you are getting wet..."',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(height: 24),
        // Progress
        _buildSectionTitle('Progress', Icons.timeline),
        const SizedBox(height: 12),
        _buildInfoRow('Turn Count', '15'),
        _buildInfoRow('Genre', 'Pure Romance'),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildStatBar(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text('$value/100'),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: value / 100,
            backgroundColor: color.withAlpha(51),
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildDominanceBar(String label, int value) {
    // -100 to +100 scale
    final normalized = (value + 100) / 200;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text('$value'),
            ],
          ),
          const SizedBox(height: 4),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: QualiaTheme.dominancePurple.withAlpha(51),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: normalized,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: QualiaTheme.dominancePurple,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // Center marker
              Positioned.fill(
                child: Center(
                  child: Container(
                    width: 2,
                    height: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoodRow(String mood, String emoji) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Text('Mood: '),
          Text(
            mood,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text(emoji, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
