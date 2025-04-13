import 'package:flutter/material.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../domain/models/user.dart';

class CommunityFriendsTab extends StatefulWidget {
  const CommunityFriendsTab({Key? key}) : super(key: key);

  @override
  State<CommunityFriendsTab> createState() => _CommunityFriendsTabState();
}

class _CommunityFriendsTabState extends State<CommunityFriendsTab> with SingleTickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      body: Column(
        children: [
          _buildFollowTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFollowingList(),
                _buildFollowersList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFollowTabBar() {
    return Container(
      color: Theme.of(context).colorScheme.surfaceBright,
      child: TabBar(
        controller: _tabController,
        labelColor: Theme.of(context).colorScheme.primary,
        unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        indicatorColor: Theme.of(context).colorScheme.primary,
        tabs: const [
          Tab(text: 'Following'),
          Tab(text: 'Followers'),
        ],
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
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSearchBar(),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Your Followers',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: friends.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                ),
                itemBuilder: (context, index) => _buildUserItem(friends[index], isFollowing: false),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Search for friends',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildYourFriendsSection(List<User> friends) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Your Friends',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friends.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            ),
            itemBuilder: (context, index) => _buildUserItem(friends[index]),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSuggestedFriendsSection(List<User> suggested) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Suggested Friends',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: suggested.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            ),
            itemBuilder: (context, index) => _buildUserItem(suggested[index]),
          ),
        ],
      ),
    );
  }
  
  Widget _buildUserItem(User user, {bool isFollowing = true}) {
    return Padding(
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
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  '@${user.username}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {
              // Follow/Unfollow action
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: isFollowing 
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.primary,
              side: BorderSide(
                color: isFollowing 
                  ? Theme.of(context).colorScheme.onSurface.withOpacity(0.3)
                  : Theme.of(context).colorScheme.primary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(isFollowing ? 'Following' : 'Follow'),
          ),
        ],
      ),
    );
  }
} 