import 'package:flutter/material.dart';
import '../../../data/repositories/group_repository.dart';
import '../../../domain/models/group.dart';

class CommunityGroupsTab extends StatelessWidget {
  const CommunityGroupsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myGroups = GroupRepository().getMyGroups();
    final suggestedGroups = GroupRepository().getSuggestedGroups();
    final groupCategories = GroupRepository().getGroupCategories();
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'Groups',
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Join groups of like-minded people and participate in group discussions and activities.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 24),
              _buildSearchBar(context),
              _buildMyGroupsSection(context, myGroups),
              _buildGroupCategoriesSection(context, groupCategories),
              _buildMoreGroupsSection(context, suggestedGroups),
              const SizedBox(height: 100), // Add extra space at the bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 6),
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
            size: 20
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a group',
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

  Widget _buildMyGroupsSection(BuildContext context, List<Group> groups) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
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
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Text(
              'My Groups',
              style: theme.textTheme.titleMedium,
            ),
          ),
          ...groups.map((group) => _buildGroupItem(context, group, isJoined: true)).toList(),
          _buildCreateGroupButton(context),
        ],
      ),
    );
  }

  Widget _buildMoreGroupsSection(BuildContext context, List<Group> groups) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
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
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Text(
              'More Groups',
              style: theme.textTheme.titleMedium,
            ),
          ),
          ...groups.map((group) => _buildGroupItem(context, group)).toList(),
        ],
      ),
    );
  }
  
  Widget _buildGroupCategoriesSection(BuildContext context, List<GroupCategory> categories) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
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
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Text(
              'Group Categories',
              style: theme.textTheme.titleMedium,
            ),
          ),
          ...categories.map((category) => _buildCategoryItem(context, category)).toList(),
        ],
      ),
    );
  }

  Widget _buildGroupItem(BuildContext context, Group group, {bool isJoined = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              _buildGroupAvatar(context, group),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      '${_formatMemberCount(group.members)} members',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isJoined)
                TextButton(
                  onPressed: () {
                    // Join group
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text(
                    'Join',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
      ],
    );
  }

  Widget _buildGroupAvatar(BuildContext context, Group group) {
    // Extract initials from group name for fallback
    final initials = group.name.split(' ')
        .map((e) => e.isNotEmpty ? e[0].toUpperCase() : '')
        .join('')
        .substring(0, group.name.split(' ').length > 1 ? 2 : 1);
    
    // Generate color based on group name (consistent for same name)
    final int hashCode = group.name.hashCode;
    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
    ];
    final color = colors[hashCode.abs() % colors.length];
    
    if (group.imageUrl.startsWith('http')) {
      return CircleAvatar(
        radius: 24,
        backgroundColor: color,
        child: Text(
          initials,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        foregroundImage: NetworkImage(group.imageUrl),
      );
    } else {
      // For assets or other image sources
      return CircleAvatar(
        radius: 24,
        backgroundColor: color,
        child: Text(
          initials,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  Widget _buildCreateGroupButton(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                child: Icon(
                  Icons.add, 
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Create Group',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
      ],
    );
  }

  Widget _buildCategoryItem(BuildContext context, GroupCategory category) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: InkWell(
            onTap: () {
              // Navigate to category
            },
            child: Row(
              children: [
                Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: Text(
                    category.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        category.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
        Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
      ],
    );
  }

  String _formatMemberCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(count % 1000000 == 0 ? 0 : 1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(count % 1000 == 0 ? 0 : 1)}K';
    }
    return count.toString();
  }
} 