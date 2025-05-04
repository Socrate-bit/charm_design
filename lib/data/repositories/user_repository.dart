import '../../domain/models/user.dart';
import 'dart:developer' as developer;

class UserRepository {
  User getCurrentUser() {
    return User(
      id: 'current_user',
      name: 'Emily Wilson',
      username: 'emily_wilson',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      bio: 'Passionate about health and wellness. On a journey to become my best self.',
      followers: 256,
      following: 128,
      streak: 42,
      karmaPoints: 1250,
      level: 8,
      communityScore: 78,
      postCount: 87,
      messageCount: 324,
    );
  }

  List<User> getFriends() {
    return [
      User(
        id: 'user1',
        name: 'John Smith',
        username: 'john_smith',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        followers: 342,
        following: 156,
        isFollowing: true,
      ),
      User(
        id: 'user2',
        name: 'Sarah Johnson',
        username: 'sarah_j',
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
        followers: 523,
        following: 210,
        isFollowing: true,
      ),
      User(
        id: 'user3',
        name: 'Michael Brown',
        username: 'mike_brown',
        avatarUrl: 'https://i.pravatar.cc/150?img=4',
        followers: 167,
        following: 83,
        isFollowing: true,
      ),
      User(
        id: 'user4',
        name: 'Emma Wilson',
        username: 'emma_w',
        avatarUrl: 'https://i.pravatar.cc/150?img=9',
        followers: 428,
        following: 231,
        isFollowing: true,
      ),
      User(
        id: 'user5',
        name: 'David Chen',
        username: 'david_c',
        avatarUrl: 'https://i.pravatar.cc/150?img=7',
        followers: 289,
        following: 175,
        isFollowing: true,
      ),
    ];
  }

  List<User> getSuggestedFriends() {
    return [
      User(
        id: 'user6',
        name: 'Lisa Taylor',
        username: 'lisa_t',
        avatarUrl: 'https://i.pravatar.cc/150?img=10',
        followers: 189,
        following: 94,
      ),
      User(
        id: 'user7',
        name: 'James Miller',
        username: 'james_m',
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
        followers: 312,
        following: 163,
      ),
      User(
        id: 'user8',
        name: 'Jennifer White',
        username: 'jenny_white',
        avatarUrl: 'https://i.pravatar.cc/150?img=6',
        followers: 275,
        following: 132,
      ),
    ];
  }

  User getUserById(String userId) {
    // In a real app, this would fetch from an API
    // For now, return mock data based on the ID
    
    developer.log('Looking up user with ID: $userId');
    
    // First check if it's one of our known users from other methods
    final allUsers = [
      getCurrentUser(),
      ...getFriends(),
      ...getSuggestedFriends(),
    ];
    
    final foundUser = allUsers.where((user) => user.id == userId).firstOrNull;
    if (foundUser != null) {
      developer.log('Found existing user: ${foundUser.name} (${foundUser.id})');
      return foundUser;
    }
    
    // Special case for legacy posts that might use outdated IDs
    if (userId == 'user2') {
      // Sarah Johnson has been updated to match the mock data
      final sarahJohnson = User(
        id: 'user2',
        name: 'Sarah Johnson',
        username: 'sarah_j',
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
        followers: 523,
        following: 210,
        isFollowing: true,
        bio: 'Passionate about mindfulness and healthy living',
        streak: 75,
        karmaPoints: 1850,
        level: 6,
        communityScore: 82,
        postCount: 43,
        messageCount: 129,
      );
      developer.log('Returning special case user: Sarah Johnson');
      return sarahJohnson;
    }
    
    // If not found, generate a mock user
    developer.log('Generating mock user for ID: $userId');
    return User(
      id: userId,
      name: 'User $userId',
      username: 'user_$userId',
      avatarUrl: 'https://i.pravatar.cc/150?img=${userId.hashCode % 70}',
      bio: 'This is a sample bio for user $userId',
      followers: 100 + (userId.hashCode % 900),
      following: 50 + (userId.hashCode % 450),
      isFollowing: userId.hashCode.isEven,
      streak: userId.hashCode % 365,
      karmaPoints: 1000 + (userId.hashCode % 9000),
      level: 1 + (userId.hashCode % 10),
      communityScore: userId.hashCode % 100,
      postCount: userId.hashCode % 200,
      messageCount: userId.hashCode % 500,
    );
  }
} 