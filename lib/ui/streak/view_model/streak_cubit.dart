import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/streak.dart';

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
      
      // Mock streak data for demonstration
      final Map<DateTime, bool> mockStreakDays = {};
      final now = DateTime.now();
      
      // Add some sample streak days for April 2020 as shown in the screenshot
      final april2020 = DateTime(2020, 4);
      for (var i = 2; i <= 15; i++) {
        if (i != 7 && i != 14) { // Skip a couple days to match the screenshot
          mockStreakDays[DateTime(2020, 4, i)] = true;
        }
      }
      
      // Special highlight for the current day in the screenshot (day 12)
      mockStreakDays[DateTime(2020, 4, 12)] = true;
      
      final streak = Streak(
        currentStreak: 0, // Current streak shows 0 in the screenshot
        longestStreak: 3097, // From screenshot
        nextMilestone: 3100, // From screenshot
        streakDays: mockStreakDays,
      );
      
      emit(state.copyWith(
        streak: streak,
        isLoading: false,
        selectedMonth: april2020,
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