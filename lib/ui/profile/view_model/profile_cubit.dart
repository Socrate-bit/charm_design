import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../domain/models/user.dart';

class ProfileState {
  final User user;
  final bool isLoading;
  final String? error;

  ProfileState({
    required this.user,
    this.isLoading = false,
    this.error,
  });

  ProfileState copyWith({
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;

  ProfileCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ProfileState(user: userRepository.getCurrentUser()));

  void loadProfile() {
    emit(state.copyWith(isLoading: true));
    try {
      final user = _userRepository.getCurrentUser();
      emit(state.copyWith(user: user, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> updateProfilePicture(String newAvatarUrl) async {
    // In a real app, this would call the repository to update the picture
    // For now, we'll just update the state
    final updatedUser = User(
      id: state.user.id,
      name: state.user.name,
      username: state.user.username,
      avatarUrl: newAvatarUrl,
      bio: state.user.bio,
      followers: state.user.followers,
      following: state.user.following,
      isFollowing: state.user.isFollowing,
    );
    
    emit(state.copyWith(user: updatedUser));
  }

  Future<void> logout() async {
    // In a real app, this would call an auth service to logout
    // For now, we'll just emit a loading state
    emit(state.copyWith(isLoading: true));
    // Simulating API call
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(isLoading: false));
  }

  Future<void> deleteAccount() async {
    // In a real app, this would call an auth service to delete the account
    // For now, we'll just emit a loading state
    emit(state.copyWith(isLoading: true));
    // Simulating API call
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(isLoading: false));
  }
} 