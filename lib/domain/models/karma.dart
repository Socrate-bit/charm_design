class Karma {
  final int points;
  final String level;
  final int levelProgress;
  final int nextLevelPoints;
  final List<KarmaActivity> recentActivities;
  final List<KarmaReward> availableRewards;

  Karma({
    required this.points,
    required this.level,
    required this.levelProgress,
    required this.nextLevelPoints,
    required this.recentActivities,
    required this.availableRewards,
  });

  factory Karma.empty() {
    return Karma(
      points: 0,
      level: 'Seeker',
      levelProgress: 0,
      nextLevelPoints: 100,
      recentActivities: [],
      availableRewards: [],
    );
  }

  Karma copyWith({
    int? points,
    String? level,
    int? levelProgress,
    int? nextLevelPoints,
    List<KarmaActivity>? recentActivities,
    List<KarmaReward>? availableRewards,
  }) {
    return Karma(
      points: points ?? this.points,
      level: level ?? this.level,
      levelProgress: levelProgress ?? this.levelProgress,
      nextLevelPoints: nextLevelPoints ?? this.nextLevelPoints,
      recentActivities: recentActivities ?? this.recentActivities,
      availableRewards: availableRewards ?? this.availableRewards,
    );
  }
}

class KarmaActivity {
  final String title;
  final String description;
  final int points;
  final DateTime date;
  final KarmaActivityCategory category;

  KarmaActivity({
    required this.title,
    required this.description,
    required this.points,
    required this.date,
    required this.category,
  });
}

enum KarmaActivityCategory {
  dailyActivity,
  communityEngagement,
  socialReferral,
  challenge
}

class KarmaReward {
  final String title;
  final String description;
  final int cost;
  final KarmaRewardCategory category;
  final bool isAvailable;

  KarmaReward({
    required this.title,
    required this.description,
    required this.cost,
    required this.category,
    required this.isAvailable,
  });
}

enum KarmaRewardCategory {
  exclusiveContent,
  subscriptionBenefit,
  physicalDigital,
  gamifiedPerk
}

class KarmaLevel {
  final String name;
  final String description;
  final int requiredPoints;

  KarmaLevel({
    required this.name,
    required this.description,
    required this.requiredPoints,
  });

  static List<KarmaLevel> get levels => [
    KarmaLevel(
      name: 'Seeker',
      description: 'Beginning the journey, earning basic karma',
      requiredPoints: 0,
    ),
    KarmaLevel(
      name: 'Awakener',
      description: 'Deepening involvement, sharing energy with the community',
      requiredPoints: 100,
    ),
    KarmaLevel(
      name: 'Guide',
      description: 'Unlocking wisdom, uplifting others through contributions',
      requiredPoints: 500,
    ),
    KarmaLevel(
      name: 'Luminary',
      description: 'Recognized as a beacon, inspiring transformation',
      requiredPoints: 1000,
    ),
    KarmaLevel(
      name: 'Ascended',
      description: 'Reaching full alignment, unlocking exclusive rewards, and mentoring others',
      requiredPoints: 2000,
    ),
  ];
} 