import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/navigation/view_model/navigation_cubit.dart';
import 'ui/core/themes/theme.dart';
import 'ui/affirmations/widgets/affirmations_screen.dart';
import 'ui/community/widgets/community_screen.dart';
import 'ui/profile/widgets/profile_screen.dart';
import 'ui/streak/widgets/streak_screen.dart';
import 'ui/streak/view_model/streak_cubit.dart';
import 'ui/karma/view_model/karma_cubit.dart';
import 'ui/karma/widgets/karma_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => StreakCubit()),
        BlocProvider(create: (context) => KarmaCubit()),
      ],
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return MaterialApp(
            theme: AppTheme.lightThemeData,
            builder: (context, child) {
              return HeroControllerScope.none(
                child: child!,
              );
            },
            home: LayoutBuilder(
              builder: (context, constraints) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                    leadingWidth: 120,
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Streak indicator
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: BlocProvider.of<StreakCubit>(context),
                                child: const StreakScreen(),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 12),
                              const Icon(Icons.local_fire_department, color: Colors.orange),
                              const SizedBox(width: 4),
                              Text('5'), // Example streak count
                            ],
                          ),
                        ),
                        
                        // Karma points indicator
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: BlocProvider.of<KarmaCubit>(context),
                                child: const KarmaScreen(),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 12),
                              const Icon(Icons.emoji_events, color: Colors.purple),
                              const SizedBox(width: 4),
                              Text('435'), // Example karma count
                            ],
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      [
                        'Dashboard',
                        'Affirmations',
                        'Growth Toolkit',
                        'Community'
                      ][state.selectedIndex],
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.account_circle, color: Theme.of(context).colorScheme.onSurface,),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  body: IndexedStack(
                    index: state.selectedIndex,
                    children: [
                      const Center(child: Text('Dashboard')), // Placeholder for Dashboard
                      AffirmationsScreen(),
                      const Center(child: Text('Growth Toolkit')), // Placeholder for Growth Toolkit
                      const CommunityScreen(), // Community screen
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.6), 
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    heroTag: 'mainFAB',
                    shape: const CircleBorder(),
                    onPressed: () {
                      // Handle affirmation of the day action
                    },
                    child: const Icon(Icons.star),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                    type: BottomNavigationBarType.fixed,
                    selectedFontSize: 12,
                    currentIndex: state.selectedIndex,
                    selectedItemColor: Theme.of(context).colorScheme.primary,
                    unselectedItemColor: Theme.of(context).colorScheme.onSurface,
                    enableFeedback: true,
                    onTap: (index) {
                      context.read<NavigationCubit>().updateIndex(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.dashboard),
                        label: 'Dashboard',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.format_quote),
                        label: 'Affirmations',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.build),
                        label: 'Growth',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.group),
                        label: 'Community',
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
