import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:developer' as developer;
import '../view_model/user_profile_cubit.dart';
import '../../friends/data/user_repository.dart';
import '../data/post_repository.dart';
import '../../friends/domain/user.dart';
import 'post_widget.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;
  
  const UserProfileScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Debug log to track user ID
    developer.log('Opening user profile for userId: $userId');
    
    // Check if this is the current user being viewed
    final bool isCurrentUser = userId == 'current_user';
    developer.log('Is viewing current user profile: $isCurrentUser');
    
    return BlocProvider(
      create: (context) => UserProfileCubit(
        userRepository: UserRepository(),
        postRepository: PostRepository(),
      )..loadUserProfile(userId),
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state.error != null) {
            return Scaffold(
              body: Center(child: Text('Error: ${state.error}')),
            );
          }

          if (state.user == null) {
            return Scaffold(
              body: Center(child: Text('User not found')),
            );
          }

          final user = state.user!;
          
          // Validate that we're displaying the correct user profile
          if (user.id != userId) {
            developer.log('Warning: User ID mismatch. Expected: $userId, Got: ${user.id}');
          }
          
          final theme = Theme.of(context);
          
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: AppBar(
              title: Text(user.name),
              backgroundColor: theme.colorScheme.primary,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _showOptionsSheet(context);
                  },
                ),
              ],
            ),
            body: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildProfileHeader(context, user, state.isFollowing),
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildProfileInfo(context, user),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildUserStatsSection(context, user),
                ),
                const SizedBox(height: 16),
                // Wall section title with padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '${user.name}\'s Wall',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 8),
                // Posts without padding
                if (state.posts.isEmpty)
                  _buildEmptyWallState(context, user)
                else
                  ...state.posts.map((post) => PostWidget(post: post)).toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, User user, bool isFollowing) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      color: theme.colorScheme.primary,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              image: const DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1545389336-cf090694435e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2000&q=80'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: theme.colorScheme.surface,
              child: CircleAvatar(
                radius: 47,
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: _buildFollowButton(context, isFollowing),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowButton(BuildContext context, bool isFollowing) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () {
        context.read<UserProfileCubit>().toggleFollow();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isFollowing 
              ? Colors.white.withOpacity(0.3) 
              : theme.colorScheme.secondary.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isFollowing ? Icons.check : Icons.add,
              color: Colors.white,
              size: 14,
            ),
            const SizedBox(width: 4),
            Text(
              isFollowing ? 'Following' : 'Follow',
              style: const TextStyle(
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
  
  void _showOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.block),
                title: const Text('Block User'),
                onTap: () {
                  Navigator.pop(context);
                  _showBlockUserDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('Report User'),
                onTap: () {
                  Navigator.pop(context);
                  _showReportUserDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share Profile'),
                onTap: () {
                  Navigator.pop(context);
                  // Share profile functionality
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBlockUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Block User'),
          content: const Text(
            'Are you sure you want to block this user? You will no longer see their posts or receive messages from them.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User blocked')),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Block'),
            ),
          ],
        );
      },
    );
  }

  void _showReportUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Report User'),
          content: const Text(
            'Please let us know why you\'re reporting this user.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Report submitted')),
                );
              },
              child: const Text('Submit Report'),
            ),
          ],
        );
      },
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
    final theme = Theme.of(context);
    final levelTitle = context.read<UserProfileCubit>().getLevelTitle(user.level);
    final levelColor = context.read<UserProfileCubit>().getLevelColor(user.level);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'User Stats',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          _buildLevelIndicator(
            context,
            user.level,
            levelTitle,
            levelColor,
          ),
          const SizedBox(height: 16),
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
                  icon: null,
                  faIcon: FontAwesomeIcons.yinYang,
                  iconColor: Colors.purple,
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
    IconData? icon,
    IconData? faIcon,
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
          child: Center(
            child: faIcon != null 
                ? FaIcon(faIcon, color: iconColor, size: 24)
                : Icon(icon, color: iconColor, size: 24),
          ),
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

  Widget _buildEmptyWallState(BuildContext context, User user) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.post_add,
            size: 48,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 12),
          Text(
            'No posts yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${user.name} hasn\'t posted anything yet',
            style: TextStyle(
              fontSize: 14,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
} 