import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/community_cubit.dart';
import 'community_home_tab.dart';
import 'community_groups_tab.dart';
import 'community_friends_tab.dart';
import 'community_bookmarked_tab.dart';
import 'community_chat_tab.dart';

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
    final theme = Theme.of(context);

    return BlocBuilder<CommunityCubit, CommunityState>(
      builder: (context, state) {
        return DefaultTabController(
          length: CommunityTab.values.length,
          initialIndex: state.selectedTab.index,
          child: Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                color: theme.colorScheme.surface,
                child: TabBar(
                  dividerHeight: 0,
                  isScrollable: true,
                  labelColor: theme.colorScheme.primary,
                  unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(
                    0.7,
                  ),
                  indicatorColor: theme.colorScheme.primary,
                  onTap: (index) {
                    context.read<CommunityCubit>().changeTab(
                      CommunityTab.values[index],
                    );
                  },
                  tabs: const [
                    Tab(text: 'Home'),
                    Tab(text: 'Groups'),
                    Tab(text: 'Friends'),
                    Tab(text: 'Chat'),
                    Tab(text: 'Bookmarked'),
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
                CommunityChatTab(), // Chat tab
                CommunityBookmarkedTab(), // Bookmarked tab
              ],
            ),
          ),
        );
      },
    );
  }
}
