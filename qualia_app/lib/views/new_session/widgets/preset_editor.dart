import 'package:flutter/material.dart';

import '../../../models/comfyui_model_preset.dart';

/// Preset Editor - 프리셋 커스터마이징 위젯
class PresetEditor extends StatefulWidget {
  final ComfyUIModelPreset preset;
  final ValueChanged<ComfyUIModelPreset> onChanged;

  const PresetEditor({
    super.key,
    required this.preset,
    required this.onChanged,
  });

  @override
  State<PresetEditor> createState() => _PresetEditorState();
}

class _PresetEditorState extends State<PresetEditor> {
  late TextEditingController _checkpointController;
  late TextEditingController _vaeController;
  late TextEditingController _upscaleController;
  late TextEditingController _positiveController;
  late TextEditingController _negativeController;
  late TextEditingController _stepsController;
  late TextEditingController _cfgController;

  late ImageSize _imageSize;
  late String _sampler;
  late String _scheduler;

  final _samplers = [
    'Euler a',
    'Euler',
    'DPM++ 2M Karras',
    'DPM++ 2M SDE Karras',
    'DPM++ 3M SDE Karras',
    'DDIM',
    'UniPC',
  ];

  final _schedulers = [
    'normal',
    'karras',
    'exponential',
    'sgm_uniform',
  ];

  @override
  void initState() {
    super.initState();
    _checkpointController = TextEditingController(text: widget.preset.checkpointModel);
    _vaeController = TextEditingController(text: widget.preset.vae ?? '');
    _upscaleController = TextEditingController(text: widget.preset.upscaleModel ?? '');
    _positiveController = TextEditingController(text: widget.preset.defaultPositive);
    _negativeController = TextEditingController(text: widget.preset.defaultNegative);
    _stepsController = TextEditingController(text: widget.preset.steps.toString());
    _cfgController = TextEditingController(text: widget.preset.cfgScale.toString());
    _imageSize = widget.preset.latentImageSize;
    _sampler = widget.preset.sampler;
    _scheduler = widget.preset.scheduler;
  }

  @override
  void dispose() {
    _checkpointController.dispose();
    _vaeController.dispose();
    _upscaleController.dispose();
    _positiveController.dispose();
    _negativeController.dispose();
    _stepsController.dispose();
    _cfgController.dispose();
    super.dispose();
  }

  void _notifyChange() {
    final updated = widget.preset.copyWith(
      checkpointModel: _checkpointController.text,
      vae: _vaeController.text.isEmpty ? null : _vaeController.text,
      upscaleModel: _upscaleController.text.isEmpty ? null : _upscaleController.text,
      defaultPositive: _positiveController.text,
      defaultNegative: _negativeController.text,
      steps: int.tryParse(_stepsController.text) ?? widget.preset.steps,
      cfgScale: double.tryParse(_cfgController.text) ?? widget.preset.cfgScale,
      latentImageSize: _imageSize,
      sampler: _sampler,
      scheduler: _scheduler,
    );
    widget.onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Section: Model
        _buildSectionHeader('Model Configuration'),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _checkpointController,
          label: 'Checkpoint Model',
          hint: 'model.safetensors',
          icon: Icons.layers,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _vaeController,
                label: 'VAE (optional)',
                hint: 'vae.safetensors',
                icon: Icons.photo_filter,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _upscaleController,
                label: 'Upscaler (optional)',
                hint: '4x-AnimeSharp',
                icon: Icons.zoom_out_map,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Section: Generation Parameters
        _buildSectionHeader('Generation Parameters'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _stepsController,
                label: 'Steps',
                hint: '30',
                icon: Icons.repeat,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _cfgController,
                label: 'CFG Scale',
                hint: '7.0',
                icon: Icons.tune,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                label: 'Sampler',
                value: _sampler,
                items: _samplers,
                onChanged: (v) {
                  setState(() => _sampler = v!);
                  _notifyChange();
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDropdown(
                label: 'Scheduler',
                value: _scheduler,
                items: _schedulers,
                onChanged: (v) {
                  setState(() => _scheduler = v!);
                  _notifyChange();
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Section: Image Size
        _buildSectionHeader('Image Size'),
        const SizedBox(height: 12),
        _buildImageSizeSelector(isDark),

        const SizedBox(height: 24),

        // Section: Prompts
        _buildSectionHeader('Default Prompts'),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _positiveController,
          label: 'Positive Prompt',
          hint: 'masterpiece, best quality...',
          icon: Icons.add_circle_outline,
          maxLines: 3,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _negativeController,
          label: 'Negative Prompt',
          hint: 'worst quality, low quality...',
          icon: Icons.remove_circle_outline,
          maxLines: 3,
        ),

        const SizedBox(height: 32),
      ],
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

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: items.contains(value) ? value : items.first,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: items.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildImageSizeSelector(bool isDark) {
    return Row(
      children: [
        _buildSizeOption(
          ImageSize.portrait,
          'Portrait',
          '832×1216',
          Icons.crop_portrait,
          isDark,
        ),
        const SizedBox(width: 12),
        _buildSizeOption(
          ImageSize.square,
          'Square',
          '1024×1024',
          Icons.crop_square,
          isDark,
        ),
        const SizedBox(width: 12),
        _buildSizeOption(
          ImageSize.landscape,
          'Landscape',
          '1216×832',
          Icons.crop_landscape,
          isDark,
        ),
      ],
    );
  }

  Widget _buildSizeOption(
    ImageSize size,
    String label,
    String dimensions,
    IconData icon,
    bool isDark,
  ) {
    final isSelected = _imageSize == size;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() => _imageSize = size);
          _notifyChange();
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary.withAlpha(30)
                : (isDark ? Colors.grey[850] : Colors.grey[100]),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 28,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
              ),
              Text(
                dimensions,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
