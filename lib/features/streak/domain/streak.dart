class Streak {
  final int currentStreak;
  final int longestStreak;
  final int nextMilestone;
  final Map<DateTime, bool> streakDays;

  Streak({
    required this.currentStreak,
    required this.longestStreak,
    required this.nextMilestone,
    required this.streakDays,
  });

  factory Streak.empty() {
    return Streak(
      currentStreak: 0,
      longestStreak: 0,
      nextMilestone: 3,
      streakDays: {},
    );
  }

  Streak copyWith({
    int? currentStreak,
    int? longestStreak,
    int? nextMilestone,
    Map<DateTime, bool>? streakDays,
  }) {
    return Streak(
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      nextMilestone: nextMilestone ?? this.nextMilestone,
      streakDays: streakDays ?? this.streakDays,
    );
  }
} 