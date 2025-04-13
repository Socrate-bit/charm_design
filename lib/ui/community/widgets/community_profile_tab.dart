import 'package:flutter/material.dart';
import '../../../data/repositories/post_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../domain/models/post.dart';
import '../../../domain/models/user.dart';
import 'post_widget.dart';

class CommunityProfileTab extends StatelessWidget {
  const CommunityProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = UserRepository().getCurrentUser();
    final posts = PostRepository().getPosts();
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      body: ListView(
        children: [
          _buildProfileHeader(context, user),
          const SizedBox(height: 16),
          _buildProfileInfo(context, user),
          const SizedBox(height: 16),
          _buildTabSection(context, posts),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, User user) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1554189097-ffe88e998a2b'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: CircleAvatar(
              radius: 47,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(BuildContext context, User user) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
      child: Column(
        children: [
          Text(
            user.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '@${user.username}',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 12),
          if (user.bio != null)
            Text(
              user.bio!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatColumn(context, '${user.following}', 'Following'),
              Container(
                height: 30,
                width: 1,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                margin: const EdgeInsets.symmetric(horizontal: 24),
              ),
              _buildStatColumn(context, '${user.followers}', 'Followers'),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Edit profile
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                ),
              ),
            ),
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildTabSection(BuildContext context, List<Post> posts) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                ),
              ),
            ),
            child: TabBar(
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              indicatorColor: Theme.of(context).colorScheme.primary,
              tabs: const [
                Tab(text: 'Posts'),
                Tab(text: 'Photos'),
                Tab(text: 'Saved'),
              ],
            ),
          ),
          SizedBox(
            height: 800, // Fixed height for demo; in real app, use constraints
            child: TabBarView(
              children: [
                _buildPostsTab(context, posts),
                _buildPhotosTab(context, posts),
                _buildSavedTab(context, posts),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsTab(BuildContext context, List<Post> posts) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: PostWidget(post: posts[index]),
        );
      },
    );
  }

  Widget _buildPhotosTab(BuildContext context, List<Post> posts) {
    // Filter posts with images
    final postsWithImages = posts.where((post) => post.imageUrl != null).toList();
    
    return postsWithImages.isEmpty
        ? _buildEmptyState(context, 'No photos yet', 'Photos you share will appear here')
        : GridView.builder(
            padding: const EdgeInsets.all(16),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: postsWithImages.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  postsWithImages[index].imageUrl!,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
  }

  Widget _buildSavedTab(BuildContext context, List<Post> posts) {
    // For demo, show fewer posts to simulate saved posts
    final savedPosts = posts.take(1).toList();
    
    return savedPosts.isEmpty
        ? _buildEmptyState(context, 'No saved posts', 'Bookmark posts to save them for later')
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: savedPosts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PostWidget(post: savedPosts[index]),
              );
            },
          );
  }

  Widget _buildEmptyState(BuildContext context, String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
} 