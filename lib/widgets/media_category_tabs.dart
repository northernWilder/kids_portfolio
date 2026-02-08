import 'package:flutter/material.dart';
import '../models/media_item.dart';

class MediaCategoryTabs extends StatelessWidget {
  final MediaCategory selectedCategory;
  final Function(MediaCategory) onCategorySelected;

  const MediaCategoryTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: MediaCategory.values.map((category) {
            final isSelected = category == selectedCategory;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ChoiceChip(
                label: Text(_getCategoryLabel(category)),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    onCategorySelected(category);
                  }
                },
                selectedColor: Colors.purple.shade100,
                backgroundColor: Colors.grey.shade100,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.purple.shade900 : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                avatar: Icon(
                  _getCategoryIcon(category),
                  size: 18,
                  color: isSelected ? Colors.purple.shade700 : Colors.grey.shade600,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getCategoryLabel(MediaCategory category) {
    switch (category) {
      case MediaCategory.all:
        return 'All';
      case MediaCategory.stories:
        return 'Stories';
      case MediaCategory.photos:
        return 'Photos';
      case MediaCategory.writing:
        return 'Writing';
    }
  }

  IconData _getCategoryIcon(MediaCategory category) {
    switch (category) {
      case MediaCategory.all:
        return Icons.grid_view;
      case MediaCategory.stories:
        return Icons.record_voice_over;
      case MediaCategory.photos:
        return Icons.photo_library;
      case MediaCategory.writing:
        return Icons.edit_note;
    }
  }
}
