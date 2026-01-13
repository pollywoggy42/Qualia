import 'package:flutter/material.dart';

/// Web-only right-side image panel for split-screen layout
class ImagePanel extends StatefulWidget {
  final String? currentImageUrl;
  final List<String> imageHistory;
  final String? partnerProfileUrl;
  final String partnerName;
  final bool isGenerating;
  final double? generationProgress; // 0.0 to 1.0

  const ImagePanel({
    super.key,
    this.currentImageUrl,
    this.imageHistory = const [],
    this.partnerProfileUrl,
    required this.partnerName,
    this.isGenerating = false,
    this.generationProgress,
  });

  @override
  State<ImagePanel> createState() => _ImagePanelState();
}

class _ImagePanelState extends State<ImagePanel> {
  final TransformationController _transformationController = TransformationController();
  int _currentHistoryIndex = 0;

  @override
  void didUpdateWidget(ImagePanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset to latest image when new image arrives
    if (widget.currentImageUrl != oldWidget.currentImageUrl && widget.currentImageUrl != null) {
      setState(() {
        _currentHistoryIndex = widget.imageHistory.length - 1;
        _transformationController.value = Matrix4.identity();
      });
    }
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _zoomIn() {
    final currentScale = _transformationController.value.getMaxScaleOnAxis();
    if (currentScale < 4.0) {
      _transformationController.value = _transformationController.value * Matrix4.diagonal3Values(1.2, 1.2, 1.0);
    }
  }

  void _zoomOut() {
    final currentScale = _transformationController.value.getMaxScaleOnAxis();
    if (currentScale > 0.5) {
      _transformationController.value = _transformationController.value * Matrix4.diagonal3Values(0.8, 0.8, 1.0);
    }
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
  }

  void _navigatePrevious() {
    if (_currentHistoryIndex > 0) {
      setState(() {
        _currentHistoryIndex--;
        _resetZoom();
      });
    }
  }

  void _navigateNext() {
    if (_currentHistoryIndex < widget.imageHistory.length - 1) {
      setState(() {
        _currentHistoryIndex++;
        _resetZoom();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImages = widget.imageHistory.isNotEmpty;
    final displayImageUrl = hasImages ? widget.imageHistory[_currentHistoryIndex] : null;

    return Container(
      color: theme.colorScheme.surface.withOpacity(0.3),
      child: Stack(
        children: [
          // Main content
          if (displayImageUrl != null)
            _buildImageViewer(displayImageUrl, theme)
          else
            _buildEmptyState(theme),

          // Loading overlay
          if (widget.isGenerating)
            _buildLoadingOverlay(theme),

          // Controls
          if (hasImages)
            _buildControls(theme),
        ],
      ),
    );
  }

  Widget _buildImageViewer(String imageUrl, ThemeData theme) {
    return GestureDetector(
      onDoubleTap: _resetZoom,
      child: InteractiveViewer(
        transformationController: _transformationController,
        minScale: 0.5,
        maxScale: 4.0,
        child: Center(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.partnerProfileUrl != null)
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(widget.partnerProfileUrl!),
            )
          else
            Icon(Icons.image_outlined, size: 80, color: theme.colorScheme.onSurface.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            '곧 장면이 표시됩니다',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay(ThemeData theme) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '새로운 장면 생성 중...',
              style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                value: widget.generationProgress,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            if (widget.generationProgress != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${(widget.generationProgress! * 100).toInt()}%',
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildControls(ThemeData theme) {
    return SafeArea(
      child: Column(
        children: [
          // Zoom controls (top right)
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _zoomIn,
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.surface.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _zoomOut,
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.surface.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // Navigation controls (bottom)
          if (widget.imageHistory.length > 1)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: _currentHistoryIndex > 0 ? _navigatePrevious : null,
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.surface.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_currentHistoryIndex + 1} / ${widget.imageHistory.length}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: _currentHistoryIndex < widget.imageHistory.length - 1 ? _navigateNext : null,
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.surface.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
