import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../data/repositories/post_repository.dart';
import '../../../domain/models/post.dart';
import '../../../data/repositories/user_repository.dart';
import 'post_widget.dart';

class CommunityHomeTab extends StatelessWidget {
  const CommunityHomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posts = PostRepository().getCompleteFeed();
    final currentUser = UserRepository().getCurrentUser();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text('Community', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text(
                    'Connect with like-minded people and share your journey with others.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            // Create post card (without horizontal padding)
            _buildCreatePostCard(context, currentUser),

            // Separator
            const SizedBox(height: 16),

            // Feed section header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.dynamic_feed,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Latest Posts',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Post feed without extra padding
            Column(
              children: posts.map((post) => PostWidget(post: post)).toList(),
            ),

            const SizedBox(height: 100), // Add extra space at the bottom
          ],
        ),
      ),
    );
  }

  Widget _buildCreatePostCard(BuildContext context, user) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _showPostOptionsModal(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.edit, size: 28, color: Colors.grey),
                        SizedBox(width: 12),
                        Text(
                          'How is your journey?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPostOptionsModal(BuildContext context) {
    final theme = Theme.of(context);

    showCupertinoModalPopup(
      context: context,
      builder:
          (BuildContext context) => CupertinoActionSheet(
            title: const Text(
              'Create a Post',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            message: const Text(
              'Choose what type of content you want to share',
              style: TextStyle(fontSize: 14),
            ),
            actions: [
              _buildCustomActionButton(
                context,
                'Share an Affirmation',
                'Express positive intentions and manifest your goals',
                Icons.favorite,
                Colors.pink,
              ),
              _buildCustomActionButton(
                context,
                'Celebrate Progress',
                'Share your achievements and success stories',
                Icons.star,
                Colors.amber,
              ),
              _buildCustomActionButton(
                context,
                'Share an Insight',
                'Post a learning or realization from your journey',
                Icons.lightbulb,
                Colors.blue,
              ),
              _buildCustomActionButton(
                context,
                'Ask a Question',
                'Get support and advice from the community',
                Icons.question_answer,
                Colors.teal,
              ),
              _buildCustomActionButton(
                context,
                'Create an Event',
                'Organize a workshop or gathering',
                Icons.event,
                Colors.purple,
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildCustomActionButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
  ) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.pop(context);
        // TODO: Navigate to appropriate post creation screen
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Creating: $title')));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          // Dark background for contrast
          border: Border(bottom: BorderSide(width: 0.5)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}
