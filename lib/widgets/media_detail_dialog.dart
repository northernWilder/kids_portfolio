import 'package:flutter/material.dart';
import '../models/media_item.dart';

class MediaDetailDialog extends StatelessWidget {
  final MediaItem item;

  const MediaDetailDialog({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  Icon(
                    _getCategoryIcon(),
                    color: Colors.purple.shade700,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${item.categoryDisplayName} • ${_formatDate(item.timestamp)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.imageUrl != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: Icon(Icons.broken_image, size: 64),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    if (item.audioUrl != null) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.audiotrack,
                              color: Colors.purple.shade700,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Audio recording available',
                                style: TextStyle(
                                  color: Colors.purple.shade900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.play_arrow),
                              onPressed: () {
                                // TODO: Implement audio player
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Audio player coming soon!'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.description,
                      style: const TextStyle(height: 1.6),
                    ),
                    if (item.documentUrl != null) ...[
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Implement document viewer
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Document viewer coming soon!'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.description),
                        label: const Text('View Document'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon() {
    switch (item.category) {
      case MediaCategory.stories:
        return Icons.record_voice_over;
      case MediaCategory.photos:
        return Icons.photo_library;
      case MediaCategory.writing:
        return Icons.edit_note;
      default:
        return Icons.folder;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
