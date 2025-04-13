import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/karma.dart';

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
        points: 435,
        level: 'Awakener',
        levelProgress: 435,
        nextLevelPoints: 500,
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

  void changeTab(KarmaTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }
} 