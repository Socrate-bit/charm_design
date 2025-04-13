import '../../domain/models/post.dart';

class PostRepository {
  List<Post> getPosts() {
    // Mock data
    return [
      Post(
        id: '1',
        userId: 'user1',
        username: 'John Doe',
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
            userId: 'user2',
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
        username: 'Sarah Johnson',
        userAvatar: 'https://i.pravatar.cc/150?img=3',
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
            username: 'Mike Brown',
            userAvatar: 'https://i.pravatar.cc/150?img=4',
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
            userAvatar: 'https://i.pravatar.cc/150?img=9',
            content: 'That book changed my life! The 1% better everyday concept is so powerful.',
            createdAt: DateTime.now().subtract(const Duration(hours: 18)),
            likes: 9,
          ),
        ],
      ),
    ];
  }
} 