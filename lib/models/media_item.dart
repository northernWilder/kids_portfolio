import 'package:cloud_firestore/cloud_firestore.dart';

enum MediaCategory {
  all,
  stories,
  photos,
  writing,
}

class MediaItem {
  final String id;
  final String artistName;
  final String title;
  final String description;
  final MediaCategory category;
  final String? imageUrl;
  final String? audioUrl;
  final String? documentUrl;
  final DateTime timestamp;

  MediaItem({
    required this.id,
    required this.artistName,
    required this.title,
    required this.description,
    required this.category,
    this.imageUrl,
    this.audioUrl,
    this.documentUrl,
    required this.timestamp,
  });

  factory MediaItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return MediaItem(
      id: doc.id,
      artistName: data['artistName'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: _categoryFromString(data['category'] ?? 'all'),
      imageUrl: data['imageUrl'],
      audioUrl: data['audioUrl'],
      documentUrl: data['documentUrl'],
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'artistName': artistName,
      'title': title,
      'description': description,
      'category': category.toString().split('.').last,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'documentUrl': documentUrl,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  static MediaCategory _categoryFromString(String category) {
    switch (category) {
      case 'stories':
        return MediaCategory.stories;
      case 'photos':
        return MediaCategory.photos;
      case 'writing':
        return MediaCategory.writing;
      default:
        return MediaCategory.all;
    }
  }

  String get categoryDisplayName {
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
}
