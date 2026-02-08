import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/media_item.dart';
import '../widgets/media_grid.dart';
import '../widgets/media_category_tabs.dart';

class ArtistPortfolioScreen extends StatefulWidget {
  final String artistName;

  const ArtistPortfolioScreen({
    super.key,
    required this.artistName,
  });

  @override
  State<ArtistPortfolioScreen> createState() => _ArtistPortfolioScreenState();
}

class _ArtistPortfolioScreenState extends State<ArtistPortfolioScreen> {
  MediaCategory _selectedCategory = MediaCategory.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.artistName),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          MediaCategoryTabs(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _getMediaStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading portfolio',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          snapshot.error.toString(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No items yet',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Check back soon for new creative work!',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final items = snapshot.data!.docs
                    .map((doc) => MediaItem.fromFirestore(doc))
                    .toList();

                return MediaGrid(items: items);
              },
            ),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> _getMediaStream() {
    Query query = FirebaseFirestore.instance
        .collection('media')
        .where('artistName', isEqualTo: widget.artistName)
        .orderBy('timestamp', descending: true);

    if (_selectedCategory != MediaCategory.all) {
      query = query.where('category', isEqualTo: _selectedCategory.toString().split('.').last);
    }

    return query.snapshots();
  }
}
