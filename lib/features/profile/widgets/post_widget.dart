import 'package:flutter/material.dart';
import '../../feed/domain/post.dart';
import '../../../utils/date_utils.dart';
import '../../feed/widgets/user_profile_screen.dart';
import 'dart:developer' as developer;

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      color: Theme.of(context).colorScheme.surfaceBright,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostHeader(context),
            const SizedBox(height: 12),
            Text(post.content),
            if (post.imageUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  post.imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 16),
            _buildActionButtons(context),
            if (post.topComments.isNotEmpty) ...[
              const Divider(),
              const SizedBox(height: 8),
              _buildTopComment(context),
              const SizedBox(height: 16),
              Transform.scale(
                scaleX: 2,
                child: Container(height: 8, color: Colors.grey.shade100),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPostHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _navigateToUserProfile(context),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(post.userAvatar),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => _navigateToUserProfile(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormatter.formatPostDate(post.createdAt),
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () {
            // Show post options
          },
        ),
      ],
    );
  }

  void _navigateToUserProfile(BuildContext context) {
    // Debug logging to track which user ID we're trying to navigate to
    developer.log(
      'Profile screen: Navigating to user profile. Post userId: ${post.userId}, username: ${post.username}',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(userId: post.userId),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: Icons.thumb_up_outlined,
            label: '${post.likes}',
            onPressed: () {
              // Like post
            },
          ),
          _buildActionButton(
            icon: Icons.comment_outlined,
            label: '${post.comments}',
            onPressed: () {
              // Show comments
            },
          ),
          _buildActionButton(
            icon: Icons.share_outlined,
            label: '${post.shares}',
            onPressed: () {
              // Share post
            },
          ),
          _buildActionButton(
            icon: Icons.bookmark_border_outlined,
            label: '',
            onPressed: () {
              // Bookmark post
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 26, color: Colors.black),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTopComment(BuildContext context) {
    final topComment = post.topComments.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap:
                  () => _navigateToCommenterProfile(context, topComment.userId),
              child: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(topComment.userAvatar),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap:
                  () => _navigateToCommenterProfile(context, topComment.userId),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topComment.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    DateFormatter.formatPostDate(topComment.createdAt),
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(topComment.content),
              const SizedBox(height: 8),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Like comment
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.thumb_up_outlined,
                          size: 14,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${topComment.likes}',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      // Reply to comment
                    },
                    child: Text(
                      'Reply',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToCommenterProfile(BuildContext context, String userId) {
    // Debug logging to track which commenter we're navigating to
    final topComment = post.topComments.first;
    developer.log(
      'Profile screen: Navigating to commenter profile. Comment userId: $userId, username: ${topComment.username}',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(userId: userId),
      ),
    );
  }
}
