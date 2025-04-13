class User {
  final String id;
  final String name;
  final String username;
  final String avatarUrl;
  final String? bio;
  final int followers;
  final int following;
  final bool isFollowing;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarUrl,
    this.bio,
    required this.followers,
    required this.following,
    this.isFollowing = false,
  });
} 