import 'package:flutter_bloc/flutter_bloc.dart';

enum CommunityTab { home, groups, friends, chat, bookmarked }

class CommunityState {
  final CommunityTab selectedTab;
  
  const CommunityState({
    this.selectedTab = CommunityTab.home,
  });
  
  CommunityState copyWith({
    CommunityTab? selectedTab,
  }) {
    return CommunityState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(const CommunityState());
  
  void changeTab(CommunityTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }
} 