import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/repositories/post_repository.dart';
import '../../../domain/models/user.dart';
import '../../../domain/models/post.dart';

class UserProfileState {
  final User? user;
  final List<Post> posts;
  final bool isLoading;
  final String? error;
  final bool isFollowing;

  UserProfileState({
    this.user,
    this.posts = const [],
    this.isLoading = false,
    this.error,
    this.isFollowing = false,
  });

  UserProfileState copyWith({
    User? user,
    List<Post>? posts,
    bool? isLoading,
    String? error,
    bool? isFollowing,
  }) {
    return UserProfileState(
      user: user ?? this.user,
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserRepository _userRepository;
  final PostRepository _postRepository;

  UserProfileCubit({
    required UserRepository userRepository,
    required PostRepository postRepository,
  }) : _userRepository = userRepository,
       _postRepository = postRepository,
       super(UserProfileState(isLoading: true));

  void loadUserProfile(String userId) {
    emit(state.copyWith(isLoading: true));
    try {
      // In a real app, these would be API calls to get user by ID
      final user = _userRepository.getUserById(userId);
      final posts = _postRepository.getUserPosts(userId);
      emit(state.copyWith(
        user: user, 
        posts: posts, 
        isLoading: false,
        isFollowing: user.isFollowing,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> toggleFollow() async {
    if (state.user == null) return;
    
    final isCurrentlyFollowing = state.isFollowing;
    // Optimistically update UI
    emit(state.copyWith(isFollowing: !isCurrentlyFollowing));
    
    try {
      // In a real app, this would be an API call to follow/unfollow
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Update the user object to reflect new follower count
      final updatedUser = User(
        id: state.user!.id,
        name: state.user!.name,
        username: state.user!.username,
        avatarUrl: state.user!.avatarUrl,
        bio: state.user!.bio,
        followers: state.user!.followers + (isCurrentlyFollowing ? -1 : 1),
        following: state.user!.following,
        isFollowing: !isCurrentlyFollowing,
        streak: state.user!.streak,
        karmaPoints: state.user!.karmaPoints,
        level: state.user!.level,
        communityScore: state.user!.communityScore,
        postCount: state.user!.postCount,
        messageCount: state.user!.messageCount,
      );
      
      emit(state.copyWith(user: updatedUser));
    } catch (e) {
      // Revert on error
      emit(state.copyWith(isFollowing: isCurrentlyFollowing));
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
      case 8:
        return "Luminary (Ambassador)";
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
} 