import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../domain/karma.dart';
import '../../friends/data/user_repository.dart';

class KarmaState {
  final Karma karma;
  final bool isLoading;
  final String? error;
  final KarmaTab selectedTab;

  KarmaState({
    required this.karma,
    this.isLoading = false,
    this.error,
    this.selectedTab = KarmaTab.earning,
  });

  KarmaState copyWith({
    Karma? karma,
    bool? isLoading,
    String? error,
    KarmaTab? selectedTab,
  }) {
    return KarmaState(
      karma: karma ?? this.karma,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}

enum KarmaTab {
  earning,
  rewards,
  leveling,
}

class KarmaCubit extends Cubit<KarmaState> {
  KarmaCubit()
      : super(KarmaState(
          karma: Karma.empty(),
        ));

  Future<void> loadKarmaData() async {
    emit(state.copyWith(isLoading: true));
    try {
      // Simulated data - in a real app, you would fetch this from a repository
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Get user's karma points and level from UserRepository for consistency
      final currentUser = UserRepository().getCurrentUser();
      final userKarmaPoints = currentUser.karmaPoints;
      final userLevel = currentUser.level;
      
      // Get level title based on user's level
      final levelTitle = getLevelTitle(userLevel);
      
      // Mock Karma activities
      final recentActivities = [
        KarmaActivity(
          title: 'Daily Affirmation',
          description: 'Completed your daily affirmations practice',
          points: 10,
          date: DateTime.now().subtract(const Duration(hours: 2)),
          category: KarmaActivityCategory.dailyActivity,
        ),
        KarmaActivity(
          title: 'Streak Milestone',
          description: 'Maintained a 7-day streak',
          points: 25,
          date: DateTime.now().subtract(const Duration(days: 1)),
          category: KarmaActivityCategory.dailyActivity,
        ),
        KarmaActivity(
          title: 'Community Post',
          description: 'Shared a reflection on your journey',
          points: 15,
          date: DateTime.now().subtract(const Duration(days: 2)),
          category: KarmaActivityCategory.communityEngagement,
        ),
        KarmaActivity(
          title: 'Friend Invitation',
          description: 'Successfully invited a friend to join',
          points: 50,
          date: DateTime.now().subtract(const Duration(days: 3)),
          category: KarmaActivityCategory.socialReferral,
        ),
        KarmaActivity(
          title: 'Monthly Challenge',
          description: 'Completed the Full Moon Reflection challenge',
          points: 75,
          date: DateTime.now().subtract(const Duration(days: 5)),
          category: KarmaActivityCategory.challenge,
        ),
      ];
      
      // Mock Karma rewards
      final availableRewards = [
        KarmaReward(
          title: 'Premium Affirmations',
          description: 'Unlock exclusive guided affirmations',
          cost: 200,
          category: KarmaRewardCategory.exclusiveContent,
          isAvailable: true,
        ),
        KarmaReward(
          title: 'Streak Freeze',
          description: 'Preserve your streak for one day of inactivity',
          cost: 50,
          category: KarmaRewardCategory.gamifiedPerk,
          isAvailable: true,
        ),
        KarmaReward(
          title: 'Free Premium Trial',
          description: 'Get 7 days of premium membership',
          cost: 500,
          category: KarmaRewardCategory.subscriptionBenefit,
          isAvailable: true,
        ),
        KarmaReward(
          title: 'Mindfulness Journal',
          description: 'A physical journal for your reflections',
          cost: 1000,
          category: KarmaRewardCategory.physicalDigital,
          isAvailable: false,
        ),
        KarmaReward(
          title: 'Custom Profile Badge',
          description: 'Stand out with an exclusive profile badge',
          cost: 300,
          category: KarmaRewardCategory.gamifiedPerk,
          isAvailable: true,
        ),
      ];
      
      final karma = Karma(
        points: userKarmaPoints,
        level: levelTitle,
        levelProgress: userKarmaPoints,
        nextLevelPoints: 1500,
        recentActivities: recentActivities,
        availableRewards: availableRewards,
      );
      
      emit(state.copyWith(
        karma: karma,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  String getLevelTitle(int level) {
    switch (level) {
      case 1:
      case 2:
        return "Seeker (Newcomer)";
      case 3:
      case 4:
        return "Awakener (Engaged)";
      case 5:
      case 6:
        return "Guide (Contributor)";
      case 7:
        return "Luminary (Ambassador)";
      case 8:
        return "Luminary";
      default:
        return "Ascended (Mastery)";
    }
  }

  Color getLevelColor(int level) {
    switch (level) {
      case 1:
      case 2:
        return Colors.teal;
      case 3:
      case 4:
        return Colors.blue;
      case 5:
      case 6:
        return Colors.purple;
      case 7:
      case 8:
        return Colors.amber;
      default:
        return Colors.orange;
    }
  }

  void changeTab(KarmaTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }
} 