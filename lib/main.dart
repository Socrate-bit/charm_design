import 'features/home/static_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'features/navigation/view_model/navigation_cubit.dart';
import 'features/core/themes/theme.dart';
import 'features/affirmations/widgets/affirmations_screen.dart';
import 'features/community/widgets/community_screen.dart';
import 'features/profile/widgets/profile_screen.dart';
import 'features/streak/widgets/streak_screen.dart';
import 'features/streak/view_model/streak_cubit.dart';
import 'features/karma/view_model/karma_cubit.dart';
import 'features/karma/widgets/karma_screen.dart';
import 'features/interactions/widgets/interactions_screen.dart';
import 'features/growth/widgets/growth_screen.dart';
import 'features/community/widgets/community_profile_tab.dart';
import 'data/repositories/user_repository.dart';

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
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    leadingWidth: 160,
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 16),
                        Image.asset(
                          'assets/Charm-4.png',
                          height: 48,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    actions: [
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
                            const Icon(Icons.local_fire_department, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text(
                              '${UserRepository().getCurrentUser().streak}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
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
                            const FaIcon(FontAwesomeIcons.yinYang, color: Colors.purple, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              '${UserRepository().getCurrentUser().karmaPoints}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Profile picture
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ProfileScreen()),
                            );
                          },
                          child: CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(UserRepository().getCurrentUser().avatarUrl),
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: IndexedStack(
                    index: state.selectedIndex,
                    children: [
                      const StaticHomePage(), // Placeholder for Home
                      const InteractionsScreen(), // Interactions screen
                      AffirmationsScreen(),
                      const GrowthScreen(), // Growth Toolkit screen
                      const CommunityScreen(), // Community screen
                    ],
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                    type: BottomNavigationBarType.fixed,
                    selectedFontSize: 12,
                    currentIndex: state.selectedIndex,
                    selectedItemColor: Colors.black,
                    unselectedItemColor: Theme.of(context).colorScheme.onSurface,
                    enableFeedback: true,
                    onTap: (index) {
                      context.read<NavigationCubit>().updateIndex(index);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined, size: 30),
                        activeIcon: Icon(Icons.home, size: 30),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite_outline, size: 30),
                        activeIcon: Icon(Icons.favorite, size: 30),
                        label: 'Interactions',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.format_quote_outlined, size: 30),
                        activeIcon: ClipRect(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Center(
                              child: Transform.translate(
                                offset: const Offset(-3.0, -3.0),
                                child: Icon(Icons.format_quote, size: 36),
                              ),
                            ),
                          ),
                        ),
                        label: 'Affirmations',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.spa_outlined, size: 30),
                        activeIcon: Icon(Icons.spa, size: 30),
                        label: 'Growth',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.people_outline, size: 30),
                        activeIcon: Icon(Icons.people, size: 30),
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
