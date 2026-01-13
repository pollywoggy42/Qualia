
/// Input for ProfileImageGenerator
class ProfileImageInput {
  final String faceTags;
  final String hairstyleTags;
  final String bodyTags;
  final String accessoriesTags;

  ProfileImageInput({
    required this.faceTags,
    required this.hairstyleTags,
    required this.bodyTags,
    required this.accessoriesTags,
  });
}

/// Output from ProfileImageGenerator
class ProfileImageOutput {
  final String sdxlPrompt;

  ProfileImageOutput({required this.sdxlPrompt});
}

/// ProfileImageGenerator - Generates SDXL prompts for partner profile portraits
class ProfileImageGenerator {
  final String apiKey;
  final String model;

  ProfileImageGenerator({
    required this.apiKey,
    this.model = 'openrouter/anthropic/claude-3.5-sonnet',
  });

  Future<ProfileImageOutput> generate(ProfileImageInput input) async {
    // Construct prompt using SDXL tags only
    final sdxlPrompt = _constructPrompt(input);
    
    return ProfileImageOutput(sdxlPrompt: sdxlPrompt);
  }

  String _constructPrompt(ProfileImageInput input) {
    final parts = <String>[
      // Base portrait setup
      'portrait',
      'front view',
      'looking at camera',
      'neutral expression',
      'professional headshot',
      
      // Character SDXL tags (no descriptions)
      input.faceTags,
      input.hairstyleTags,
      input.bodyTags,
      if (input.accessoriesTags.isNotEmpty) input.accessoriesTags,
      
      // Quality and lighting
      'studio lighting',
      'soft shadows',
      'clean white background',
      'high quality',
      'detailed',
      'masterpiece',
      'best quality',
      '8k',
    ];

    return parts.where((p) => p.isNotEmpty).join(', ');
  }
}
