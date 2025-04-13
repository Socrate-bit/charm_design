import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/community_cubit.dart';
import 'community_home_tab.dart';
import 'community_groups_tab.dart';
import 'community_friends_tab.dart';
import 'community_bookmarked_tab.dart';
import 'community_chat_tab.dart';
import 'community_profile_tab.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunityCubit(),
      child: const CommunityScreenContent(),
    );
  }
}

class CommunityScreenContent extends StatelessWidget {
  const CommunityScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      builder: (context, state) {
        return DefaultTabController(
          length: CommunityTab.values.length,
          initialIndex: state.selectedTab.index,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                color: Theme.of(context).colorScheme.surfaceBright,
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.green,
                  unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                  indicatorColor: Colors.green,
                  onTap: (index) {
                    context.read<CommunityCubit>().changeTab(CommunityTab.values[index]);
                  },
                  tabs: const [
                    Tab(text: 'Home'),
                    Tab(text: 'Groups'),
                    Tab(text: 'Friends'),
                    Tab(text: 'Bookmarked'),
                    Tab(text: 'Chat'),
                    Tab(text: 'Profile'),
                  ],
                ),
              ),
            ),
            body: IndexedStack(
              index: state.selectedTab.index,
              children: const [
                CommunityHomeTab(), // Home tab
                CommunityGroupsTab(), // Groups tab
                CommunityFriendsTab(), // Friends tab
                CommunityBookmarkedTab(), // Bookmarked tab
                CommunityChatTab(), // Chat tab
                CommunityProfileTab(), // Profile tab
              ],
            ),
          ),
        );
      },
    );
  }
} 