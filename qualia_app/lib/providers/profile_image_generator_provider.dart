import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/agents/profile_image_generator.dart';
import 'storage_provider.dart';

part 'profile_image_generator_provider.g.dart';

@riverpod
ProfileImageGenerator? profileImageGeneratorAgent(ProfileImageGeneratorAgentRef ref) {
  final storage = ref.watch(storageServiceProvider);
  final apiKey = storage.getOpenRouterApiKey();
  
  if (apiKey == null || apiKey.isEmpty) {
    return null;
  }

  return ProfileImageGenerator(apiKey: apiKey);
}
