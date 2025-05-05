import 'package:flutter/material.dart';
import '../data/post_repository.dart';
import '../../friends/data/user_repository.dart';
import '../domain/post.dart';
import '../../friends/domain/user.dart';
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
        padding: EdgeInsets.zero,
        children: [
          _buildProfileHeader(context, user),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildProfileInfo(context, user),
          ),
          const SizedBox(height: 16),
          _buildUserStatsSection(context, user),
          const SizedBox(height: 12),
          _buildWallSection(context, user, posts),
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
            // backgroundColor: Theme.of(context).colorScheme.surface,
            child: CircleAvatar(
              radius: 47,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: _buildEditProfileButton(context),
        ),
      ],
    );
  }

  Widget _buildEditProfileButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // Edit profile
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 14,
            ),
            SizedBox(width: 4),
            Text(
              'Edit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, User user) {
    return Column(
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
            _buildStatColumn(context, '${user.postCount}', 'Posts'),
            Container(
              height: 30,
              width: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
            _buildStatColumn(context, '${user.following}', 'Following'),
            Container(
              height: 30,
              width: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
            _buildStatColumn(context, '${user.followers}', 'Followers'),
          ],
        ),
      ],
    );
  }

  Widget _buildUserStatsSection(BuildContext context, User user) {
    // Determine level title based on user's level
    String levelTitle;
    Color levelColor;
    
    switch (user.level) {
      case 1:
      case 2:
        levelTitle = "Seeker (Newcomer)";
        levelColor = Colors.teal;
        break;
      case 3:
      case 4:
        levelTitle = "Awakener (Engaged)";
        levelColor = Colors.blue;
        break;
      case 5:
      case 6:
        levelTitle = "Guide (Contributor)";
        levelColor = Colors.purple;
        break;
      case 7:
      case 8:
        levelTitle = "Luminary (Ambassador)";
        levelColor = Colors.amber;
        break;
      default:
        levelTitle = "Ascended (Mastery)";
        levelColor = Colors.orange;
    }
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Activity Stats',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Karma Level Indicator
          _buildLevelIndicator(context, user.level, levelTitle, levelColor),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: _buildStatCard(
                  context,
                  icon: Icons.local_fire_department,
                  iconColor: Colors.orange,
                  value: user.streak.toString(),
                  label: 'Day Streak',
                ),
              ),
              Expanded(
                flex: 1,
                child: _buildStatCard(
                  context,
                  icon: Icons.stars,
                  iconColor: Colors.amber,
                  value: user.karmaPoints.toString(),
                  label: 'Karma Points',
                ),
              ),
              Expanded(
                flex: 1,
                child: _buildStatCard(
                  context,
                  icon: Icons.people,
                  iconColor: Colors.blue,
                  value: user.communityScore.toString(),
                  label: 'Community Score',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildLevelIndicator(BuildContext context, int level, String levelTitle, Color levelColor) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    levelColor,
                    levelColor.withOpacity(0.7),
                    levelColor.withOpacity(0.3),
                  ],
                  stops: const [0.4, 0.7, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: levelColor.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            Text(
              '$level',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          levelTitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: levelColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Karma Level',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
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

  Widget _buildWallSection(BuildContext context, User user, List<Post> posts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.all(16),
          child: Text(
            '${user.name}\'s Wall',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        if (posts.isEmpty)
          _buildEmptyWallState(context)
        else
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return PostWidget(post: posts[index]);
            },
          ),
      ],
    );
  }

  Widget _buildEmptyWallState(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.post_add,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No posts yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your posts will appear here',
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