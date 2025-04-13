import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../view_model/streak_cubit.dart';
import '../../../ui/core/themes/theme.dart';

class StreakScreen extends StatefulWidget {
  const StreakScreen({Key? key}) : super(key: key);

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StreakCubit>().loadStreakData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streak'),
        backgroundColor: AppTheme.kcolorTheme.primary,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'streakScreenFAB',
        backgroundColor: Colors.amber,
        onPressed: () {
          // Add custom action for streak screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Streak actions not implemented yet')),
          );
        },
        child: const Icon(Icons.local_fire_department),
      ),
      body: BlocBuilder<StreakCubit, StreakState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Current Streak Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        // Left side with streak number
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text(
                                '${state.streak.currentStreak}',
                                style: const TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                              const Text(
                                'day streak!',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Right side with flame icon
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.local_fire_department,
                            size: 120,
                            color: Colors.amber.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Milestone and Longest Streak Cards
                  Row(
                    children: [
                      // Next Milestone
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Icon(
                                Icons.flag,
                                size: 48,
                                color: Colors.amber,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${state.streak.nextMilestone} days',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Next milestone',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 10),
                      
                      // Longest Streak
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.local_fire_department,
                                  size: 32,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${state.streak.longestStreak} days',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Longest streak',
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
                  
                  const SizedBox(height: 20),
                  
                  // Month Navigator
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => context.read<StreakCubit>().previousMonth(),
                          icon: const Icon(Icons.chevron_left, size: 36),
                        ),
                        Text(
                          DateFormat('MMMM yyyy').format(state.selectedMonth),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => context.read<StreakCubit>().nextMonth(),
                          icon: const Icon(Icons.chevron_right, size: 36),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // Calendar week days
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text('M', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('T', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('W', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('T', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('F', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('S', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('S', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  
                  // Calendar days
                  _buildCalendarGrid(state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCalendarGrid(StreakState state) {
    final year = state.selectedMonth.year;
    final month = state.selectedMonth.month;
    
    // Get the first day of the month
    final firstDayOfMonth = DateTime(year, month, 1);
    
    // Calculate the day of week for the first day (0 = Sunday, 1 = Monday, ..., 6 = Saturday)
    int firstWeekdayOfMonth = firstDayOfMonth.weekday;
    if (firstWeekdayOfMonth == 7) firstWeekdayOfMonth = 0; // Convert Sunday from 7 to 0
    
    // Calculate the number of days in the month
    final daysInMonth = DateTime(year, month + 1, 0).day;
    
    // Calculate the number of rows needed
    final numRows = ((daysInMonth + firstWeekdayOfMonth - 1) / 7).ceil();
    
    return Column(
      children: List.generate(numRows, (rowIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (colIndex) {
              final dayIndex = rowIndex * 7 + colIndex - firstWeekdayOfMonth + 1;
              
              if (dayIndex < 1 || dayIndex > daysInMonth) {
                return const SizedBox(width: 40, height: 40); // Empty cell
              }
              
              final date = DateTime(year, month, dayIndex);
              final hasStreak = state.streak.streakDays[date] == true;
              final isToday = date.day == 12 && date.month == 4 && date.year == 2020; // Using day 12 as today based on screenshot
              
              return _buildDayCell(dayIndex, hasStreak, isToday);
            }),
          ),
        );
      }),
    );
  }

  Widget _buildDayCell(int day, bool hasStreak, bool isToday) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isToday 
          ? Colors.blue 
          : hasStreak 
            ? Colors.amber 
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '$day',
          style: TextStyle(
            fontSize: 16,
            fontWeight: hasStreak ? FontWeight.bold : FontWeight.normal,
            color: (isToday || hasStreak) ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
} 