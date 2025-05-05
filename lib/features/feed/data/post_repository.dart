import '../domain/post.dart';
import '../../friends/data/user_repository.dart';
import 'dart:developer' as developer;

class PostRepository {
  List<Post> getPosts() {
    // Mock data
    return [
      Post(
        id: '1',
        userId: 'user1',
        username: 'John Smith',
        userAvatar: 'https://i.pravatar.cc/150?img=1',
        content: 'Just reached a milestone in my personal development journey! Feeling grateful for all the support.',
        imageUrl: 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        likes: 42,
        comments: 7,
        shares: 3,
        topComments: [
          Comment(
            id: 'c1',
            userId: 'current_user',
            username: 'Emily Wilson',
            userAvatar: 'https://i.pravatar.cc/150?img=5',
            content: 'So proud of you! Keep up the great work!',
            createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
            likes: 12,
          ),
        ],
      ),
      Post(
        id: '2',
        userId: 'user3',
        username: 'Michael Brown',
        userAvatar: 'https://i.pravatar.cc/150?img=4',
        content: 'Today I practiced mindfulness for 30 minutes. Taking small steps towards better mental health every day.',
        imageUrl: null,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        likes: 18,
        comments: 3,
        shares: 1,
        topComments: [
          Comment(
            id: 'c2',
            userId: 'user4',
            username: 'Emma Wilson',
            userAvatar: 'https://i.pravatar.cc/150?img=9',
            content: 'Mindfulness has changed my life too! Would love to hear more about your practice.',
            createdAt: DateTime.now().subtract(const Duration(hours: 2)),
            likes: 5,
          ),
        ],
      ),
      Post(
        id: '3',
        userId: 'user5',
        username: 'David Chen',
        userAvatar: 'https://i.pravatar.cc/150?img=7',
        content: 'Just finished reading "Atomic Habits" by James Clear. Highly recommend it for anyone looking to build better habits!',
        imageUrl: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        likes: 31,
        comments: 12,
        shares: 8,
        topComments: [
          Comment(
            id: 'c3',
            userId: 'user6',
            username: 'Lisa Taylor',
            userAvatar: 'https://i.pravatar.cc/150?img=10',
            content: 'That book changed my life! The 1% better everyday concept is so powerful.',
            createdAt: DateTime.now().subtract(const Duration(hours: 18)),
            likes: 9,
          ),
        ],
      ),
    ];
  }
  
  // Fixed specific posts for the current user to ensure consistency
  List<Post> _getCurrentUserPosts() {
    final user = UserRepository().getCurrentUser();
    
    return [
      Post(
        id: 'current_1',
        userId: user.id,
        username: user.name,
        userAvatar: user.avatarUrl,
        content: 'Just completed my 30-day meditation challenge! Feeling more calm and centered than ever before. #MindfulnessJourney',
        imageUrl: 'https://images.unsplash.com/photo-1545389336-cf090694435e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2000&q=80',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        likes: 87,
        comments: 12,
        shares: 5,
        topComments: [
          Comment(
            id: 'current_c1',
            userId: 'user1',
            username: 'John Smith',
            userAvatar: 'https://i.pravatar.cc/150?img=1',
            content: 'That\'s amazing! Did you notice any changes in your sleep patterns?',
            createdAt: DateTime.now().subtract(const Duration(hours: 20)),
            likes: 8,
          ),
        ],
      ),
      Post(
        id: 'current_2',
        userId: user.id,
        username: user.name,
        userAvatar: user.avatarUrl,
        content: 'Feeling grateful for this supportive community. Thank you all for your encouragement and positivity!',
        imageUrl: null,
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        likes: 124,
        comments: 23,
        shares: 7,
        topComments: [
          Comment(
            id: 'current_c2',
            userId: 'user3',
            username: 'Michael Brown',
            userAvatar: 'https://i.pravatar.cc/150?img=4',
            content: 'We are all better because of your contributions! Keep shining!',
            createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 12)),
            likes: 15,
          ),
        ],
      ),
      Post(
        id: 'current_3',
        userId: user.id,
        username: user.name,
        userAvatar: user.avatarUrl,
        content: 'Just finished "The Power of Now" by Eckhart Tolle. This book completely changed my perspective on mindfulness and living in the present moment. Highly recommended! 📚✨',
        imageUrl: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        likes: 95,
        comments: 18,
        shares: 12,
        topComments: [
          Comment(
            id: 'current_c3',
            userId: 'user5',
            username: 'David Chen',
            userAvatar: 'https://i.pravatar.cc/150?img=7',
            content: 'Great book! I also loved his "A New Earth" - you should check that out next.',
            createdAt: DateTime.now().subtract(const Duration(days: 6, hours: 8)),
            likes: 10,
          ),
        ],
      ),
    ];
  }
  
  List<Post> getUserPosts(String userId) {
    developer.log('PostRepository: Getting posts for user ID: $userId');
    
    // Special case for current user - use fixed posts for consistency
    if (userId == 'current_user') {
      final currentUserPosts = _getCurrentUserPosts();
      developer.log('PostRepository: Returning ${currentUserPosts.length} specific posts for current user');
      return currentUserPosts;
    }
    
    // In a real app, this would fetch from an API
    // For now, filter the mock posts by userId or generate new ones if none exist
    
    final allPosts = getPosts();
    final userPosts = allPosts.where((post) => post.userId == userId).toList();
    
    // If we have posts for this user, return them
    if (userPosts.isNotEmpty) {
      developer.log('PostRepository: Found ${userPosts.length} existing posts for user $userId');
      return userPosts;
    }
    
    // Get the actual user data from UserRepository for consistency
    final userRepository = UserRepository();
    final user = userRepository.getUserById(userId);
    
    // Otherwise, generate some mock posts for this user
    final generatedPosts = List.generate(
      3 + (userId.hashCode % 4), // Random number of posts between 3-6
      (index) => Post(
        id: '${userId}_post_$index',
        userId: userId,
        username: user.name, // Use the actual user name
        userAvatar: user.avatarUrl, // Use the actual user avatar
        content: _getRandomContent(index),
        imageUrl: index % 2 == 0 ? _getRandomImage(index) : null, // Every other post has an image
        createdAt: DateTime.now().subtract(Duration(days: index * (userId.hashCode % 10 + 1))),
        likes: (userId.hashCode + index) % 100,
        comments: (userId.hashCode + index) % 20,
        shares: (userId.hashCode + index) % 10,
        topComments: index % 3 == 0 ? [] : [
          Comment(
            id: '${userId}_comment_$index',
            userId: 'commenter_${index + 1}',
            username: 'Commenter ${index + 1}',
            userAvatar: 'https://i.pravatar.cc/150?img=${(userId.hashCode + index) % 70}',
            content: 'This is a great post! I really appreciate your insights.',
            createdAt: DateTime.now().subtract(Duration(hours: index * 4)),
            likes: index * 2,
          ),
        ],
      ),
    );
    
    developer.log('PostRepository: Generated ${generatedPosts.length} posts for user $userId');
    return generatedPosts;
  }
  
  String _getRandomContent(int index) {
    final contents = [
      'Just had a breakthrough in my meditation practice! Feeling more centered than ever.',
      'Started a new book on personal development. Can\'t wait to share my insights!',
      'Grateful for this community and all the support I\'ve received on my journey.',
      'Today marks day 30 of my wellness journey. Small steps lead to big changes!',
      'Just completed a challenging yoga session. Mind and body feeling refreshed.',
      'Reflecting on how far I\'ve come this year. Growth isn\'t always linear, but it\'s worth it.',
    ];
    
    return contents[index % contents.length];
  }
  
  String _getRandomImage(int index) {
    final images = [
      'https://images.unsplash.com/photo-1517021897933-0e0319cfbc28?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1220&q=80',
      'https://images.unsplash.com/photo-1604480132736-44c188fe4d20?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      'https://images.unsplash.com/photo-1574201635302-388dd92a4c3f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    ];
    
    return images[index % images.length];
  }

  // Get a complete feed with both user and general posts
  List<Post> getCompleteFeed() {
    developer.log('PostRepository: Getting complete feed');
    
    // Get the current user
    final currentUser = UserRepository().getCurrentUser();
    
    // Get current user posts
    final userPosts = getUserPosts(currentUser.id);
    developer.log('PostRepository: Got ${userPosts.length} user posts for feed');
    
    // Get general feed posts
    final feedPosts = getPosts();
    developer.log('PostRepository: Got ${feedPosts.length} general posts for feed');
    
    // Combine all posts
    final allPosts = [...userPosts, ...feedPosts];
    
    // Remove duplicates (if any) by post ID
    final uniquePosts = <Post>[];
    final seenIds = <String>{};
    
    for (final post in allPosts) {
      if (!seenIds.contains(post.id)) {
        uniquePosts.add(post);
        seenIds.add(post.id);
      }
    }
    
    // Sort by date (newest first)
    uniquePosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    developer.log('PostRepository: Returning ${uniquePosts.length} posts in complete feed');
    return uniquePosts;
  }
} 