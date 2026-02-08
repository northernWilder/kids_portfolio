import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/media_item.dart';

/// Service class for managing media items in Firestore.
/// 
/// This service provides methods to fetch, add, update, and delete
/// media items from the Firebase Firestore database.
class MediaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'media';

  /// Gets a stream of media items for a specific artist.
  ///
  /// Parameters:
  ///   - [artistName]: The name of the artist to filter by
  ///   - [category]: Optional category filter. If null, returns all categories.
  ///
  /// Returns a stream that updates whenever the data changes in Firestore.
  Stream<List<MediaItem>> getMediaForArtist({
    required String artistName,
    MediaCategory? category,
  }) {
    Query query = _firestore
        .collection(_collectionName)
        .where('artistName', isEqualTo: artistName)
        .orderBy('timestamp', descending: true);

    if (category != null && category != MediaCategory.all) {
      query = query.where('category', isEqualTo: category.toString().split('.').last);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => MediaItem.fromFirestore(doc))
          .toList();
    });
  }

  /// Gets a single media item by ID.
  ///
  /// Returns null if the item doesn't exist.
  Future<MediaItem?> getMediaById(String id) async {
    try {
      final doc = await _firestore.collection(_collectionName).doc(id).get();
      if (doc.exists) {
        return MediaItem.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      // TODO: Implement proper error logging
      // Consider using a logging package like 'logger' in production
      // ignore: avoid_print
      debugPrint('Error fetching media item: $e');
      return null;
    }
  }

  /// Adds a new media item to Firestore.
  ///
  /// Returns the ID of the newly created document.
  Future<String?> addMediaItem(MediaItem item) async {
    try {
      final docRef = await _firestore
          .collection(_collectionName)
          .add(item.toFirestore());
      return docRef.id;
    } catch (e) {
      // TODO: Implement proper error logging
      // ignore: avoid_print
      debugPrint('Error adding media item: $e');
      return null;
    }
  }

  /// Updates an existing media item.
  ///
  /// Returns true if successful, false otherwise.
  Future<bool> updateMediaItem(String id, MediaItem item) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(id)
          .update(item.toFirestore());
      return true;
    } catch (e) {
      // TODO: Implement proper error logging
      // ignore: avoid_print
      debugPrint('Error updating media item: $e');
      return false;
    }
  }

  /// Deletes a media item from Firestore.
  ///
  /// Returns true if successful, false otherwise.
  Future<bool> deleteMediaItem(String id) async {
    try {
      await _firestore.collection(_collectionName).doc(id).delete();
      return true;
    } catch (e) {
      // TODO: Implement proper error logging
      // ignore: avoid_print
      debugPrint('Error deleting media item: $e');
      return false;
    }
  }

  /// Gets all media items across all artists.
  ///
  /// Useful for admin panels or global search functionality.
  Stream<List<MediaItem>> getAllMedia() {
    return _firestore
        .collection(_collectionName)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MediaItem.fromFirestore(doc))
          .toList();
    });
  }

  /// Gets media items by category across all artists.
  Stream<List<MediaItem>> getMediaByCategory(MediaCategory category) {
    if (category == MediaCategory.all) {
      return getAllMedia();
    }

    return _firestore
        .collection(_collectionName)
        .where('category', isEqualTo: category.toString().split('.').last)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MediaItem.fromFirestore(doc))
          .toList();
    });
  }

  /// Searches media items by title or description.
  ///
  /// Note: This is a simple client-side search. For production,
  /// consider using Algolia or Firebase Extensions for better search.
  Stream<List<MediaItem>> searchMedia(String query) {
    return getAllMedia().map((items) {
      final lowerQuery = query.toLowerCase();
      return items.where((item) {
        return item.title.toLowerCase().contains(lowerQuery) ||
            item.description.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }
}
