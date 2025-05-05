import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../../friends/data/user_repository.dart';
import '../../friends/domain/user.dart';
import 'user_profile_screen.dart';

class CommunityFriendsTab extends StatefulWidget {
  const CommunityFriendsTab({Key? key}) : super(key: key);

  @override
  State<CommunityFriendsTab> createState() => _CommunityFriendsTabState();
}

class _CommunityFriendsTabState extends State<CommunityFriendsTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Column(
        children: [
          _buildFollowTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildFollowingList(), _buildFollowersList()],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new friends
        },
        heroTag: 'friendsFAB',
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFollowTabBar() {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.surface,
      child: TabBar(
        dividerHeight: 0,
        controller: _tabController,
        labelColor: theme.colorScheme.primary,
        unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(0.7),
        indicatorColor: theme.colorScheme.primary,
        tabs: const [Tab(text: 'Following'), Tab(text: 'Followers')],
      ),
    );
  }

  Widget _buildFollowingList() {
    final friends = UserRepository().getFriends();
    final suggested = UserRepository().getSuggestedFriends();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSearchBar(),
        const SizedBox(height: 16),
        _buildYourFriendsSection(friends),
        const SizedBox(height: 16),
        _buildSuggestedFriendsSection(suggested),
      ],
    );
  }

  Widget _buildFollowersList() {
    final friends = UserRepository().getFriends();
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSearchBar(),
        const SizedBox(height: 16),
        Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Your Followers',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: friends.length,
                separatorBuilder:
                    (context, index) => Divider(
                      height: 1,
                      color: theme.colorScheme.onSurface.withOpacity(0.1),
                    ),
                itemBuilder:
                    (context, index) =>
                        _buildUserItem(friends[index], isFollowing: false),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for friends',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onChanged: (value) {
                // TODO: Implement search functionality
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYourFriendsSection(List<User> friends) {
    final theme = Theme.of(context);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Your Friends', style: theme.textTheme.titleMedium),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friends.length,
            separatorBuilder:
                (context, index) => Divider(
                  height: 1,
                  color: theme.colorScheme.onSurface.withOpacity(0.1),
                ),
            itemBuilder: (context, index) => _buildUserItem(friends[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedFriendsSection(List<User> suggested) {
    final theme = Theme.of(context);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Suggested Friends',
              style: theme.textTheme.titleMedium,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: suggested.length,
            separatorBuilder:
                (context, index) => Divider(
                  height: 1,
                  color: theme.colorScheme.onSurface.withOpacity(0.1),
                ),
            itemBuilder:
                (context, index) =>
                    _buildUserItem(suggested[index], isSuggestion: true),
          ),
        ],
      ),
    );
  }

  Widget _buildUserItem(
    User user, {
    bool isFollowing = true,
    bool isSuggestion = false,
  }) {
    final theme = Theme.of(context);

    // Create the follow/unfollow button
    final Widget followButton = SizedBox(
      height: 34,
      child:
          isFollowing
              ? OutlinedButton(
                onPressed: () => _toggleFollow(user),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.onSurface,
                  backgroundColor: Colors.transparent,
                  side: BorderSide(
                    color: theme.colorScheme.onSurface.withOpacity(0.2),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 0,
                  ),
                  minimumSize: Size.zero,
                ),
                child: const Text(
                  'Following',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              )
              : ElevatedButton(
                onPressed: () => _toggleFollow(user),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: theme.colorScheme.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 0,
                  ),
                  minimumSize: Size.zero,
                ),
                child: const Text(
                  'Follow',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _navigateToUserProfile(context, user),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      '@${user.username}',
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              // Special handling for the button - we want to stop propagation
              // but still allow the button's click to work
              Material(color: Colors.transparent, child: followButton),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToUserProfile(BuildContext context, User user) {
    developer.log(
      'Friends tab: Navigating to user profile. userId: ${user.id}, name: ${user.name}',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(userId: user.id),
      ),
    );
  }

  void _toggleFollow(User user) {
    developer.log('Toggling follow status for user: ${user.name} (${user.id})');
    // In a real app, this would call the API to follow/unfollow
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          user.isFollowing
              ? 'Unfollowed ${user.name}'
              : 'Following ${user.name}',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
