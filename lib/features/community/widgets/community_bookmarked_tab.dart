import 'package:flutter/material.dart';
import '../../../data/repositories/post_repository.dart';
import '../../../domain/models/post.dart';
import 'post_widget.dart';

class CommunityBookmarkedTab extends StatelessWidget {
  const CommunityBookmarkedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using the same posts for demonstration
    final bookmarkedPosts = PostRepository().getPosts();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      body:
          bookmarkedPosts.isEmpty
              ? _buildEmptyState(context)
              : ListView(
                padding: EdgeInsets.zero,
                children: [
                  ...bookmarkedPosts
                      .map((post) => PostWidget(post: post))
                      .toList(),
                ],
              ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No bookmarked posts yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bookmark posts you want to save for later',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to home feed
            },
            icon: const Icon(Icons.explore),
            label: const Text('Explore Feed'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bookmarked Posts',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Posts you\'ve saved to revisit later',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
