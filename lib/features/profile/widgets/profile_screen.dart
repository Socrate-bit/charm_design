import '../../../domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../view_model/profile_cubit.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/repositories/post_repository.dart';
import 'post_widget.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        userRepository: UserRepository(),
        postRepository: PostRepository(),
      )..loadProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
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

          final theme = Theme.of(context);
          
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: AppBar(
              title: const Text('Profile'),
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
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildProfileHeader(context, state.user),
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildProfileInfo(context, state.user),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildUserStatsSection(context, state),
                ),
                const SizedBox(height: 16),
                // Wall section title with padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '${state.user.name}\'s Wall',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 8),
                // Posts without padding
                _buildCreatePostCard(context, state.user),
                if (state.posts.isEmpty)
                  _buildEmptyWallState(context)
                else
                  ...state.posts.map((post) => PostWidget(post: post)).toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, User user) {
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
            child: _buildEditProfileButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfileButton(BuildContext context) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () {
        _showSettingsSheet(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: const Row(
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
  
  void _showSettingsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Edit Profile Information'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to edit profile screen
                },
              ),
              ListTile(
                leading: const Icon(Icons.image_outlined),
                title: const Text('Change Profile Picture'),
                onTap: () {
                  Navigator.pop(context);
                  _showImagePickerSheet(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.orange),
                title: const Text('Logout', style: TextStyle(color: Colors.orange)),
                onTap: () {
                  Navigator.pop(context);
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showImagePickerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  // In a real app, this would open the camera
                  context.read<ProfileCubit>().updateProfilePicture(
                    'https://i.pravatar.cc/150?img=${DateTime.now().second % 10}',
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  // In a real app, this would open the image picker
                  context.read<ProfileCubit>().updateProfilePicture(
                    'https://i.pravatar.cc/150?img=${DateTime.now().second % 10 + 10}',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<ProfileCubit>().logout().then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged out successfully')),
                  );
                });
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<ProfileCubit>().deleteAccount().then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Account deleted')),
                  );
                });
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
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

  Widget _buildUserStatsSection(BuildContext context, ProfileState state) {
    final user = state.user;
    final theme = Theme.of(context);
    final levelTitle = context.read<ProfileCubit>().getLevelTitle(user.level);
    final levelColor = context.read<ProfileCubit>().getLevelColor(user.level);
    
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
            'Your Stats',
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

  Widget _buildCreatePostCard(BuildContext context, User user) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.edit, size: 28, color: Colors.grey),
                        SizedBox(width: 12),
                        Text(
                          'Share something...',
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
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
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
          child: const Text(
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Creating: $title')),
        );
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

  Widget _buildEmptyWallState(BuildContext context) {
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
            'Your posts will appear here',
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