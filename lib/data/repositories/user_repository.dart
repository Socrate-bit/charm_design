import '../../domain/models/user.dart';

class UserRepository {
  User getCurrentUser() {
    return User(
      id: 'current_user',
      name: 'Jane Doe',
      username: 'jane_doe',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      bio: 'Passionate about health and wellness. On a journey to become my best self.',
      followers: 256,
      following: 128,
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
} 