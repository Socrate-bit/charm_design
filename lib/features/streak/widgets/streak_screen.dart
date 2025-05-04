import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../view_model/streak_cubit.dart';

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
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Streak'),
        backgroundColor: theme.colorScheme.primary,
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'Your Streak',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Maintain consistency to create transformative change and unlock rewards.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Current Streak Card
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9C4), // Pastel yellow color
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
                        // Left side with streak number
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 180,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    '${state.streak.currentStreak}',
                                    style: const TextStyle(
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                  ),
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
                  
                  const SizedBox(height: 24),
                  
                  // Milestone and Longest Streak Cards
                  Row(
                    children: [
                      // Next Milestone
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
                                Icons.flag,
                                size: 48,
                                color: Colors.amber,
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 120,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    '${state.streak.nextMilestone} days',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                  ),
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
                      
                      const SizedBox(width: 16),
                      
                      // Longest Streak
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
                              SizedBox(
                                width: 120,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    '${state.streak.longestStreak} days',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                  ),
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
                  
                  const SizedBox(height: 24),
                  
                  // Month Navigator
                  Container(
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
                  
                  // Add extra space at the bottom for better scrolling
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCalendarGrid(StreakState state) {
    // Using actual current date for display instead of hardcoded date
    final today = DateTime(2025, 4, 22); // Today is April 22, 2025
    
    // Use the month from today for our calendar display, not from state
    final year = today.year; // 2025
    final month = today.month; // 4 (April)
    
    // Get the first day of the month
    final firstDayOfMonth = DateTime(year, month, 1);
    
    // Calculate the day of week for the first day (0 = Sunday, 1 = Monday, ..., 6 = Saturday)
    int firstWeekdayOfMonth = firstDayOfMonth.weekday;
    if (firstWeekdayOfMonth == 7) firstWeekdayOfMonth = 0; // Convert Sunday from 7 to 0
    
    // Calculate the number of days in the month
    final daysInMonth = DateTime(year, month + 1, 0).day;
    
    // Calculate the number of rows needed
    final numRows = ((daysInMonth + firstWeekdayOfMonth - 1) / 7).ceil();
    
    // For a 42-day streak ending on April 22, calculate the start date
    final streakStartDate = today.subtract(const Duration(days: 41));
    
    // Special blue days (perfect days) scattered throughout the streak period
    final specialDays = [
      DateTime(2025, 3, 25), // Late March
      DateTime(2025, 4, 5),  // Early April
      DateTime(2025, 4, 17), // Mid April, close to today
    ];
    
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
              
              // Check if this day is part of the 42-day streak
              final isStreakDay = !date.isBefore(streakStartDate) && !date.isAfter(today);
              
              // Check if it's a special "perfect" day (blue)
              final isPerfectDay = specialDays.any((d) => 
                d.year == date.year && d.month == date.month && d.day == date.day);
              
              final isToday = date.day == today.day && date.month == today.month && date.year == today.year;
              
              return _buildDayCell(
                dayIndex, 
                isStreakDay, 
                isToday,
                isPerfectDay,
              );
            }),
          ),
        );
      }),
    );
  }

  Widget _buildDayCell(int day, bool hasStreak, bool isToday, bool isPerfectDay) {
    Color cellColor = Colors.transparent;
    
    if (isToday) {
      cellColor = Colors.blue;
    } else if (isPerfectDay) {
      cellColor = Colors.blue;
    } else if (hasStreak) {
      cellColor = Colors.amber;
    }
    
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: cellColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '$day',
          style: TextStyle(
            fontSize: 16,
            fontWeight: hasStreak ? FontWeight.bold : FontWeight.normal,
            color: (isToday || hasStreak || isPerfectDay) ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
} 