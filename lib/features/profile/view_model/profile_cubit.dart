import 'package:flutter_bloc/flutter_bloc.dart';
import '../../friends/data/user_repository.dart';
import '../../feed/data/post_repository.dart';
import '../../friends/domain/user.dart';
import '../../feed/domain/post.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class ProfileState {
  final User user;
  final List<Post> posts;
  final bool isLoading;
  final String? error;

  ProfileState({
    required this.user,
    this.posts = const [],
    this.isLoading = false,
    this.error,
  });

  ProfileState copyWith({
    User? user,
    List<Post>? posts,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      user: user ?? this.user,
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;
  final PostRepository _postRepository;

  ProfileCubit({
    required UserRepository userRepository,
    required PostRepository postRepository,
  }) : _userRepository = userRepository,
       _postRepository = postRepository,
       super(ProfileState(
         user: userRepository.getCurrentUser(),
         posts: [], // Initialize with empty list, will load in initState
       ));

  void loadProfile() {
    emit(state.copyWith(isLoading: true));
    try {
      final user = _userRepository.getCurrentUser();
      // Use getUserPosts for consistency with the UserProfileScreen
      final posts = _postRepository.getUserPosts(user.id);
      
      developer.log('ProfileCubit: Loaded ${posts.length} posts for current user (${user.id})');
      
      emit(state.copyWith(user: user, posts: posts, isLoading: false));
    } catch (e) {
      developer.log('ProfileCubit: Error loading profile: $e');
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> updateProfilePicture(String newAvatarUrl) async {
    // In a real app, this would call the repository to update the picture
    final updatedUser = User(
      id: state.user.id,
      name: state.user.name,
      username: state.user.username,
      avatarUrl: newAvatarUrl,
      bio: state.user.bio,
      followers: state.user.followers,
      following: state.user.following,
      streak: state.user.streak,
      karmaPoints: state.user.karmaPoints,
      level: state.user.level,
      communityScore: state.user.communityScore,
      postCount: state.user.postCount,
      messageCount: state.user.messageCount,
    );
    
    emit(state.copyWith(user: updatedUser));
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

  Future<void> logout() async {
    // In a real app, this would call an auth service to logout
    emit(state.copyWith(isLoading: true));
    // Simulating API call
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(isLoading: false));
  }

  Future<void> deleteAccount() async {
    // In a real app, this would call an auth service to delete the account
    emit(state.copyWith(isLoading: true));
    // Simulating API call
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(isLoading: false));
  }
} 