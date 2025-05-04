class User {
  final String id;
  final String name;
  final String username;
  final String avatarUrl;
  final String? bio;
  final int followers;
  final int following;
  final bool isFollowing;
  final int streak;
  final int karmaPoints;
  final int level;
  final int communityScore;
  final int postCount;
  final int messageCount;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarUrl,
    this.bio,
    required this.followers,
    required this.following,
    this.isFollowing = false,
    this.streak = 0,
    this.karmaPoints = 0,
    this.level = 1,
    this.communityScore = 0,
    this.postCount = 0,
    this.messageCount = 0,
  });
} 