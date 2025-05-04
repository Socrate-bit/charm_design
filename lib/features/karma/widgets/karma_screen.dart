import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../view_model/karma_cubit.dart';
import '../../../domain/models/karma.dart';
import '../../../ui/core/themes/theme.dart';
import '../../../data/repositories/user_repository.dart';

class KarmaScreen extends StatefulWidget {
  const KarmaScreen({Key? key}) : super(key: key);

  @override
  State<KarmaScreen> createState() => _KarmaScreenState();
}

class _KarmaScreenState extends State<KarmaScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<KarmaCubit>().loadKarmaData();

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        context.read<KarmaCubit>().changeTab(KarmaTab.values[_tabController.index]);
        // Force rebuild to update IndexedStack
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Karma Points'),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: BlocConsumer<KarmaCubit, KarmaState>(
        listener: (context, state) {
          if (state.selectedTab != KarmaTab.values[_tabController.index]) {
            _tabController.animateTo(state.selectedTab.index);
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildKarmaHeader(context, state.karma),
                TabBar(
                  controller: _tabController,
                  labelColor: theme.colorScheme.primary,
                  unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(0.7),
                  indicatorColor: theme.colorScheme.primary,
                  tabs: const [
                    Tab(text: 'EARNING'),
                    Tab(text: 'REWARDS'),
                    Tab(text: 'LEVELS'),
                  ],
                ),
                // Replace IndexedStack with conditional content display
                Visibility(
                  visible: _tabController.index == 0,
                  maintainState: true,
                  child: _buildEarningTab(context, state.karma),
                ),
                Visibility(
                  visible: _tabController.index == 1,
                  maintainState: true,
                  child: _buildRewardsTab(context, state.karma),
                ),
                Visibility(
                  visible: _tabController.index == 2,
                  maintainState: true,
                  child: _buildLevelingTab(context, state.karma),
                ),
                // Add extra space at the bottom for better scrolling
                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildKarmaHeader(BuildContext context, Karma karma) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            'Your Karma',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Positive actions earn karma points that unlock rewards and special features.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
          
          // Current Karma Card
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFFE1BEE7), // Pastel purple color
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                // Left side with karma points number
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 180,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${karma.points}',
                            style: const TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      const Text(
                        'karma points',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
                // Right side with yin-yang icon
                Expanded(
                  flex: 1,
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.yinYang,
                      size: 120,
                      color: Colors.purple.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Level and Next Level Cards
          Row(
            children: [
              // Current Level
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: 48,
                        color: context.read<KarmaCubit>().getLevelColor(UserRepository().getCurrentUser().level),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        karma.level,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Current level',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Next Level Progress
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.arrow_upward,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${karma.levelProgress}/${karma.nextLevelPoints}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Next level',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildEarningTab(BuildContext context, Karma karma) {
    // Group activities by category
    final Map<KarmaActivityCategory, List<KarmaActivity>> groupedActivities = {};
    for (final activity in karma.recentActivities) {
      if (!groupedActivities.containsKey(activity.category)) {
        groupedActivities[activity.category] = [];
      }
      groupedActivities[activity.category]!.add(activity);
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'Recent Activities',
            'Your latest karma-earning activities',
          ),
          const SizedBox(height: 16),
          if (karma.recentActivities.isEmpty)
            const Center(
              child: Text('No recent activities'),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: karma.recentActivities.length,
              itemBuilder: (context, index) {
                final activity = karma.recentActivities[index];
                return _buildActivityItem(context, activity);
              },
            ),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'Daily Activities',
            'Complete these to earn karma points',
          ),
          const SizedBox(height: 16),
          _buildActivityCard(
            'Affirmations Practice',
            'Complete your daily affirmations',
            Icons.format_quote,
            '+10 karma',
            Colors.blue,
          ),
          _buildActivityCard(
            'Maintain Streaks',
            'Get bonus points for streak milestones',
            Icons.local_fire_department,
            '+25 karma\nper milestone',
            Colors.orange,
          ),
          _buildActivityCard(
            'Growth Toolkit',
            'Complete exercises from the growth toolkit',
            Icons.lightbulb,
            '+15 karma per exercise',
            Colors.green,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'Community Engagement',
            'Interact with the community to earn karma',
          ),
          const SizedBox(height: 16),
          _buildActivityCard(
            'Post Reflections',
            'Share your affirmations or reflections',
            Icons.post_add,
            '+15 karma per post',
            Colors.purple,
          ),
          _buildActivityCard(
            'Get Likes & Comments',
            'Receive engagement on your posts',
            Icons.favorite,
            '+2 karma per like/comment',
            Colors.red,
          ),
          _buildActivityCard(
            'Answer Questions',
            'Help others in the community',
            Icons.question_answer,
            '+10 karma per answer',
            Colors.amber,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'Social & Referrals',
            'Grow your network to earn karma',
          ),
          const SizedBox(height: 16),
          _buildActivityCard(
            'Invite Friends',
            'Bonus points when they join',
            Icons.people,
            '+50 karma per friend',
            Colors.indigo,
          ),
          _buildActivityCard(
            'Group Sessions',
            'Host group affirmation sessions',
            Icons.group_work,
            '+30 karma per session',
            Colors.teal,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'Challenges & Events',
            'Participate in special activities',
          ),
          const SizedBox(height: 16),
          _buildActivityCard(
            'Weekly Challenges',
            'Complete the weekly challenge',
            Icons.event,
            '+50 karma',
            Colors.deepPurple,
          ),
          _buildActivityCard(
            'Monthly Challenges',
            'Complete the monthly challenge',
            Icons.calendar_month,
            '+75 karma',
            Colors.deepOrange,
          ),
          _buildActivityCard(
            'Full Moon Karma Boost',
            'Double karma points during full moon',
            Icons.brightness_3,
            '2x karma for activities',
            Colors.blueGrey,
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsTab(BuildContext context, Karma karma) {
    // Group rewards by category
    final Map<KarmaRewardCategory, List<KarmaReward>> groupedRewards = {};
    for (final reward in karma.availableRewards) {
      if (!groupedRewards.containsKey(reward.category)) {
        groupedRewards[reward.category] = [];
      }
      groupedRewards[reward.category]!.add(reward);
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'Exclusive Content',
            'Unlock premium content with your karma points',
          ),
          const SizedBox(height: 16),
          if (groupedRewards[KarmaRewardCategory.exclusiveContent] == null ||
              groupedRewards[KarmaRewardCategory.exclusiveContent]!.isEmpty)
            const Center(
              child: Text('No rewards available in this category'),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groupedRewards[KarmaRewardCategory.exclusiveContent]!.length,
              itemBuilder: (context, index) {
                final reward = groupedRewards[KarmaRewardCategory.exclusiveContent]![index];
                return _buildRewardItem(context, reward, karma);
              },
            ),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'Subscription Benefits',
            'Get premium subscription perks',
          ),
          const SizedBox(height: 16),
          if (groupedRewards[KarmaRewardCategory.subscriptionBenefit] == null ||
              groupedRewards[KarmaRewardCategory.subscriptionBenefit]!.isEmpty)
            const Center(
              child: Text('No rewards available in this category'),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groupedRewards[KarmaRewardCategory.subscriptionBenefit]!.length,
              itemBuilder: (context, index) {
                final reward = groupedRewards[KarmaRewardCategory.subscriptionBenefit]![index];
                return _buildRewardItem(context, reward, karma);
              },
            ),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'Physical & Digital Rewards',
            'Redeem for real-world items',
          ),
          const SizedBox(height: 16),
          if (groupedRewards[KarmaRewardCategory.physicalDigital] == null ||
              groupedRewards[KarmaRewardCategory.physicalDigital]!.isEmpty)
            const Center(
              child: Text('No rewards available in this category'),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groupedRewards[KarmaRewardCategory.physicalDigital]!.length,
              itemBuilder: (context, index) {
                final reward = groupedRewards[KarmaRewardCategory.physicalDigital]![index];
                return _buildRewardItem(context, reward, karma);
              },
            ),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'Gamified Perks',
            'Unlock special features and status symbols',
          ),
          const SizedBox(height: 16),
          if (groupedRewards[KarmaRewardCategory.gamifiedPerk] == null ||
              groupedRewards[KarmaRewardCategory.gamifiedPerk]!.isEmpty)
            const Center(
              child: Text('No rewards available in this category'),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groupedRewards[KarmaRewardCategory.gamifiedPerk]!.length,
              itemBuilder: (context, index) {
                final reward = groupedRewards[KarmaRewardCategory.gamifiedPerk]![index];
                return _buildRewardItem(context, reward, karma);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildLevelingTab(BuildContext context, Karma karma) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'Karma Leveling System',
            'Your journey of spiritual growth',
          ),
          const SizedBox(height: 24),
          for (int i = 0; i < KarmaLevel.levels.length; i++) ...[
            _buildLevelItem(
              context,
              KarmaLevel.levels[i],
              isCurrentLevel: KarmaLevel.levels[i].name == karma.level,
              isCompleted: karma.points >= KarmaLevel.levels[i].requiredPoints,
              isLast: i == KarmaLevel.levels.length - 1,
            ),
            if (i < KarmaLevel.levels.length - 1)
              Container(
                margin: const EdgeInsets.only(left: 24),
                width: 2,
                height: 40,
                color: karma.points >= KarmaLevel.levels[i + 1].requiredPoints
                    ? Colors.purple
                    : Colors.grey.shade300,
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(BuildContext context, KarmaActivity activity) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getActivityColor(activity.category).withOpacity(0.2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Icon(
                  _getActivityIcon(activity.category),
                  color: _getActivityColor(activity.category),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    activity.description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(activity.date),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '+${activity.points}',
                style: const TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(
    String title,
    String description,
    IconData icon,
    String points,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 85,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                points,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardItem(BuildContext context, KarmaReward reward, Karma karma) {
    final bool canAfford = karma.points >= reward.cost;
    final bool isAvailable = reward.isAvailable;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getRewardColor(reward.category).withOpacity(0.2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Icon(
                  _getRewardIcon(reward.category),
                  color: _getRewardColor(reward.category),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    reward.description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${reward.cost} karma',
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: isAvailable && canAfford
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Redeemed ${reward.title}!'),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    disabledForegroundColor: Colors.grey.shade500,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    minimumSize: const Size(80, 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text(
                    isAvailable
                        ? canAfford
                            ? 'Redeem'
                            : 'Not Enough'
                        : 'Unavailable',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelItem(
    BuildContext context,
    KarmaLevel level, {
    required bool isCurrentLevel,
    required bool isCompleted,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isCompleted ? Colors.purple : Colors.grey.shade300,
            shape: BoxShape.circle,
            border: isCurrentLevel
                ? Border.all(
                    color: Colors.purple,
                    width: 3,
                  )
                : null,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : Text(
                    '${level.requiredPoints}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    level.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isCurrentLevel ? Colors.purple : Colors.black87,
                    ),
                  ),
                  if (isCurrentLevel)
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'CURRENT',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                level.description,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              if (!isLast) const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getActivityIcon(KarmaActivityCategory category) {
    switch (category) {
      case KarmaActivityCategory.dailyActivity:
        return Icons.calendar_today;
      case KarmaActivityCategory.communityEngagement:
        return Icons.people;
      case KarmaActivityCategory.socialReferral:
        return Icons.share;
      case KarmaActivityCategory.challenge:
        return Icons.emoji_events;
    }
  }

  Color _getActivityColor(KarmaActivityCategory category) {
    switch (category) {
      case KarmaActivityCategory.dailyActivity:
        return Colors.green;
      case KarmaActivityCategory.communityEngagement:
        return Colors.blue;
      case KarmaActivityCategory.socialReferral:
        return Colors.orange;
      case KarmaActivityCategory.challenge:
        return Colors.purple;
    }
  }

  IconData _getRewardIcon(KarmaRewardCategory category) {
    switch (category) {
      case KarmaRewardCategory.exclusiveContent:
        return Icons.lock_open;
      case KarmaRewardCategory.subscriptionBenefit:
        return Icons.star;
      case KarmaRewardCategory.physicalDigital:
        return Icons.card_giftcard;
      case KarmaRewardCategory.gamifiedPerk:
        return Icons.workspace_premium;
    }
  }

  Color _getRewardColor(KarmaRewardCategory category) {
    switch (category) {
      case KarmaRewardCategory.exclusiveContent:
        return Colors.blue;
      case KarmaRewardCategory.subscriptionBenefit:
        return Colors.amber;
      case KarmaRewardCategory.physicalDigital:
        return Colors.green;
      case KarmaRewardCategory.gamifiedPerk:
        return Colors.purple;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
} 