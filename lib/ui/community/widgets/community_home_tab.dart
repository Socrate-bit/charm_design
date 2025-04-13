import 'package:flutter/material.dart';
import '../../../data/repositories/post_repository.dart';
import '../../../domain/models/post.dart';
import 'post_widget.dart';

class CommunityHomeTab extends StatelessWidget {
  const CommunityHomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posts = PostRepository().getPosts();
    
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCreatePostCard(context),
          const SizedBox(height: 16),
          ...posts.map((post) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: PostWidget(post: post),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildCreatePostCard(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // TODO: Navigate to post creation screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Post creation not implemented yet')),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.edit, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        'How is your journey?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 