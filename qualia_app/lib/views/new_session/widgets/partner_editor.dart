import 'package:flutter/material.dart';

import '../../../models/partner_profile.dart';
import '../../../models/visual_descriptor.dart';
import '../../../models/personality.dart';
import '../../../models/partner_emotional_state.dart';
import '../../../widgets/glass_card.dart';

/// Partner Editor - 생성된 파트너 프로필 편집 위젯
class PartnerEditor extends StatefulWidget {
  final PartnerProfile profile;
  final ValueChanged<PartnerProfile> onChanged;

  const PartnerEditor({
    super.key,
    required this.profile,
    required this.onChanged,
  });

  @override
  State<PartnerEditor> createState() => _PartnerEditorState();
}

class _PartnerEditorState extends State<PartnerEditor>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Basic Info
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _occupationController;
  late TextEditingController _locationController;

  // Appearance Controllers
  late TextEditingController _faceDescController;
  late TextEditingController _faceTagsController;
  late TextEditingController _hairstyleDescController;
  late TextEditingController _hairstyleTagsController;
  late TextEditingController _bodyDescController;
  late TextEditingController _bodyTagsController;
  late TextEditingController _accessoriesDescController;
  late TextEditingController _accessoriesTagsController;
  late TextEditingController _outfitDescController;
  late TextEditingController _outfitTagsController;

  // Personality
  late TextEditingController _mbtiController;
  late TextEditingController _speechStyleController;
  late TextEditingController _traitsController;
  late TextEditingController _secretController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initControllers();
  }

  void _initControllers() {
    // Basic Info
    _nameController = TextEditingController(text: widget.profile.name);
    _ageController = TextEditingController(text: widget.profile.age.toString());
    _occupationController = TextEditingController(text: widget.profile.occupation);
    _locationController = TextEditingController(text: widget.profile.location);

    // Appearance
    _faceDescController = TextEditingController(text: widget.profile.face.description);
    _faceTagsController = TextEditingController(text: widget.profile.face.sdxlTags);
    _hairstyleDescController = TextEditingController(text: widget.profile.hairstyle.description);
    _hairstyleTagsController = TextEditingController(text: widget.profile.hairstyle.sdxlTags);
    _bodyDescController = TextEditingController(text: widget.profile.body.description);
    _bodyTagsController = TextEditingController(text: widget.profile.body.sdxlTags);
    _accessoriesDescController = TextEditingController(text: widget.profile.accessories.description);
    _accessoriesTagsController = TextEditingController(text: widget.profile.accessories.sdxlTags);
    _outfitDescController = TextEditingController(text: widget.profile.outfit.description);
    _outfitTagsController = TextEditingController(text: widget.profile.outfit.sdxlTags);

    // Personality
    _mbtiController = TextEditingController(text: widget.profile.personality.mbti);
    _speechStyleController = TextEditingController(text: widget.profile.personality.speechStyle);
    _traitsController = TextEditingController(text: widget.profile.personality.traits.join(', '));
    _secretController = TextEditingController(text: widget.profile.secret ?? '');
  }

  @override
  void dispose() {
    _tabController.dispose();
    // Basic Info
    _nameController.dispose();
    _ageController.dispose();
    _occupationController.dispose();
    _locationController.dispose();
    // Appearance
    _faceDescController.dispose();
    _faceTagsController.dispose();
    _hairstyleDescController.dispose();
    _hairstyleTagsController.dispose();
    _bodyDescController.dispose();
    _bodyTagsController.dispose();
    _accessoriesDescController.dispose();
    _accessoriesTagsController.dispose();
    _outfitDescController.dispose();
    _outfitTagsController.dispose();
    // Personality
    _mbtiController.dispose();
    _speechStyleController.dispose();
    _traitsController.dispose();
    _secretController.dispose();
    super.dispose();
  }

  void _notifyChange() {
    final updated = widget.profile.copyWith(
      name: _nameController.text,
      age: int.tryParse(_ageController.text) ?? widget.profile.age,
      occupation: _occupationController.text,
      location: _locationController.text,
      face: VisualDescriptor(
        description: _faceDescController.text,
        sdxlTags: _faceTagsController.text,
      ),
      hairstyle: VisualDescriptor(
        description: _hairstyleDescController.text,
        sdxlTags: _hairstyleTagsController.text,
      ),
      body: VisualDescriptor(
        description: _bodyDescController.text,
        sdxlTags: _bodyTagsController.text,
      ),
      accessories: VisualDescriptor(
        description: _accessoriesDescController.text,
        sdxlTags: _accessoriesTagsController.text,
      ),
      outfit: VisualDescriptor(
        description: _outfitDescController.text,
        sdxlTags: _outfitTagsController.text,
      ),
      personality: Personality(
        mbti: _mbtiController.text,
        speechStyle: _speechStyleController.text,
        traits: _traitsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
      ),
      secret: _secretController.text.isEmpty ? null : _secretController.text,
    );
    widget.onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab Bar
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.person), text: 'Basic'),
              Tab(icon: Icon(Icons.face), text: 'Appearance'),
              Tab(icon: Icon(Icons.psychology), text: 'Personality'),
            ],
          ),
        ),
        // Tab Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildBasicTab(),
              _buildAppearanceTab(),
              _buildPersonalityTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBasicTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Basic Information'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _nameController,
                label: 'Name',
                hint: 'Partner name',
                icon: Icons.badge,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _ageController,
                      label: 'Age',
                      hint: '25',
                      icon: Icons.cake,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: _buildTextField(
                      controller: _occupationController,
                      label: 'Occupation',
                      hint: 'Job or profession',
                      icon: Icons.work,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _locationController,
                label: 'Location',
                hint: 'Where did you meet?',
                icon: Icons.location_on,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppearanceTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildVisualDescriptorCard(
          title: 'Face',
          icon: Icons.face,
          descController: _faceDescController,
          tagsController: _faceTagsController,
        ),
        const SizedBox(height: 12),
        _buildVisualDescriptorCard(
          title: 'Hairstyle',
          icon: Icons.content_cut,
          descController: _hairstyleDescController,
          tagsController: _hairstyleTagsController,
        ),
        const SizedBox(height: 12),
        _buildVisualDescriptorCard(
          title: 'Body',
          icon: Icons.accessibility_new,
          descController: _bodyDescController,
          tagsController: _bodyTagsController,
        ),
        const SizedBox(height: 12),
        _buildVisualDescriptorCard(
          title: 'Accessories',
          icon: Icons.watch,
          descController: _accessoriesDescController,
          tagsController: _accessoriesTagsController,
        ),
        const SizedBox(height: 12),
        _buildVisualDescriptorCard(
          title: 'Outfit',
          icon: Icons.checkroom,
          descController: _outfitDescController,
          tagsController: _outfitTagsController,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPersonalityTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Personality'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _mbtiController,
                label: 'MBTI',
                hint: 'e.g., INFP, ENTJ',
                icon: Icons.psychology,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _speechStyleController,
                label: 'Speech Style',
                hint: 'How do they talk?',
                icon: Icons.chat_bubble,
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _traitsController,
                label: 'Traits',
                hint: 'Comma-separated traits (e.g., shy, kind, witty)',
                icon: Icons.star,
                maxLines: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Secret & Background'),
              const SizedBox(height: 8),
              Text(
                'This secret will be gradually revealed through gameplay',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _secretController,
                label: 'Secret',
                hint: 'A hidden truth about this character...',
                icon: Icons.lock,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildVisualDescriptorCard({
    required String title,
    required IconData icon,
    required TextEditingController descController,
    required TextEditingController tagsController,
  }) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: descController,
            label: 'Description',
            hint: 'Natural language description',
            icon: Icons.description,
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          _buildTextField(
            controller: tagsController,
            label: 'SDXL Tags',
            hint: 'tag1, tag2, tag3',
            icon: Icons.tag,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onChanged: (_) => _notifyChange(),
    );
  }
}

/// Generate Sample Partner - 테스트용 더미 데이터
PartnerProfile generateSamplePartner({required String gender}) {
  return PartnerProfile(
    name: gender == 'female' ? 'Emma' : gender == 'male' ? 'James' : 'Alex',
    age: 25,
    gender: gender,
    occupation: 'Photographer',
    location: 'Coffee shop in downtown',
    face: const VisualDescriptor(
      description: 'Warm brown eyes, gentle smile, light freckles',
      sdxlTags: 'brown eyes, warm smile, freckles, soft features',
    ),
    hairstyle: const VisualDescriptor(
      description: 'Shoulder-length wavy hair, natural brown color',
      sdxlTags: 'brown hair, wavy hair, medium hair, natural hair',
    ),
    body: const VisualDescriptor(
      description: 'Slim build, average height',
      sdxlTags: 'slim body, average height',
    ),
    accessories: const VisualDescriptor(
      description: 'Simple silver necklace, vintage camera',
      sdxlTags: 'silver necklace, camera, minimal accessories',
    ),
    outfit: const VisualDescriptor(
      description: 'Casual cream sweater, blue jeans',
      sdxlTags: 'cream sweater, blue jeans, casual clothes',
    ),
    personality: const Personality(
      mbti: 'INFP',
      speechStyle: 'Thoughtful and soft-spoken, often pauses to think',
      traits: ['Creative', 'Empathetic', 'Slightly shy', 'Passionate about art'],
    ),
    secret: 'Left a promising career to pursue photography after a life-changing trip',
    secretFragments: [],
    traumas: [],
    emotionalState: const PartnerEmotionalState(
      affection: 50,
      trust: 30,
      mood: 'Curious',
    ),
    physicalState: [],
    sexualExperience: 0,
    isNSFWAllowed: false,
    memorySnapshots: [],
  );
}
