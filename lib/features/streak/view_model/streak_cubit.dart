import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/streak.dart';
import '../../../data/repositories/user_repository.dart';

class StreakState {
  final Streak streak;
  final DateTime selectedMonth;
  final bool isLoading;
  final String? error;

  StreakState({
    required this.streak,
    required this.selectedMonth,
    this.isLoading = false,
    this.error,
  });

  StreakState copyWith({
    Streak? streak,
    DateTime? selectedMonth,
    bool? isLoading,
    String? error,
  }) {
    return StreakState(
      streak: streak ?? this.streak,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class StreakCubit extends Cubit<StreakState> {
  StreakCubit()
      : super(StreakState(
          streak: Streak.empty(),
          selectedMonth: DateTime.now(),
        ));

  Future<void> loadStreakData() async {
    emit(state.copyWith(isLoading: true));
    try {
      // Simulated data - in a real app, you would fetch this from a repository
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Get user's streak from UserRepository for consistency
      final userStreak = UserRepository().getCurrentUser().streak;
      
      // Use April 2025 as the current month
      final today = DateTime(2025, 4, 22);
      
      // Mock streak data for demonstration
      final Map<DateTime, bool> mockStreakDays = {};
      
      // Create streak days for the last 42 days (ending on April 22, 2025)
      final streakStartDate = today.subtract(const Duration(days: 41));
      for (var i = 0; i <= 41; i++) {
        final date = streakStartDate.add(Duration(days: i));
        mockStreakDays[date] = true;
      }
      
      // Special blue days (perfect days) throughout the streak period
      mockStreakDays[DateTime(2025, 3, 25)] = true;
      mockStreakDays[DateTime(2025, 4, 5)] = true;
      mockStreakDays[DateTime(2025, 4, 17)] = true;
      
      final streak = Streak(
        currentStreak: userStreak, // Use streak from UserRepository
        longestStreak: 3097, // From screenshot
        nextMilestone: 3100, // From screenshot
        streakDays: mockStreakDays,
      );
      
      emit(state.copyWith(
        streak: streak,
        isLoading: false,
        selectedMonth: DateTime(2025, 4), // April 2025
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void changeMonth(DateTime month) {
    emit(state.copyWith(selectedMonth: month));
  }

  void nextMonth() {
    final nextMonth = DateTime(
      state.selectedMonth.year,
      state.selectedMonth.month + 1,
    );
    emit(state.copyWith(selectedMonth: nextMonth));
  }

  void previousMonth() {
    final previousMonth = DateTime(
      state.selectedMonth.year,
      state.selectedMonth.month - 1,
    );
    emit(state.copyWith(selectedMonth: previousMonth));
  }
} 