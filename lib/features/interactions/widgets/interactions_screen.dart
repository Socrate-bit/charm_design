import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/interactions_cubit.dart';
import '../../../domain/models/interaction_session.dart';
import 'interaction_history_item.dart';
import 'quick_stats_widget.dart';

class InteractionsScreen extends StatelessWidget {
  const InteractionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => InteractionsCubit(),
      child: BlocBuilder<InteractionsCubit, InteractionsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            Text(
                              'Interactions',
                              style: theme.textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Master the hidden power within your voice and deepen your connection with others.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.7,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Start New Interaction Button
                            _ClickableContainer(
                              function: () {},
                              title: 'Communicate More Intentionally',
                              description:
                                  'Set intentions, record your interactions and discover the hidden patterns that shape your relationships.',
                              image: 'assets/Illustration16.png',
                              color: theme.colorScheme.primary,
                            ),

                            const SizedBox(height: 8),

                            // Quick Stats Section
                            if (state is InteractionsLoaded &&
                                state.sessions.isNotEmpty)
                              const QuickStatsWidget(),

                            const SizedBox(height: 24),

                            // History Section
                            Text(
                              'Your Interaction History',
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),

                            // Search Bar
                            Container(
                              margin: EdgeInsets.only(bottom: 16),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.6),
                                    size: 20,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Search in history...',
                                        hintStyle: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: theme.colorScheme.onSurface
                                                  .withOpacity(0.7),
                                            ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        // TODO: Implement search functionality
                                        // This would call a method in the cubit to filter sessions
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            _buildInteractionsHistory(state),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInteractionsHistory(InteractionsState state) {
    if (state is InteractionsLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is InteractionsLoaded) {
      final sessions = state.sessions;

      if (sessions.isEmpty) {
        return const Center(
          child: Text('No interaction sessions yet. Start your first one!'),
        );
      }

      return Builder(
        builder:
            (context) => Column(
              children:
                  sessions
                      .map(
                        (session) => InteractionHistoryItem(
                          session: session,
                          onTap: () {},
                        ),
                      )
                      .toList(),
            ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _ClickableContainer extends StatelessWidget {
  const _ClickableContainer({
    super.key,
    required this.function,
    required this.title,
    required this.description,
    required this.image,
    required this.color,
  });
  final Function function;
  final String title;
  final String description;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).primaryTextTheme;
    final cs = Theme.of(context).colorScheme;
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    BoxShadow basicShadow = BoxShadow(
      color: Colors.black.withOpacity(0.2), // Slightly darker shadow
      blurRadius: 10,
      spreadRadius: 2,
      blurStyle: BlurStyle.normal,
      offset: Offset(5, 5), // More pronounced downward shadow
    );

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        function();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [basicShadow],
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [color, Colors.purple.shade800],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: tt.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(description, style: tt.bodySmall, maxLines: 4),
                  SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.black,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      function();
                    },
                    child: Text(
                      'Start Now',
                      style: tt.labelMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(image, width: mediaQuery.size.width * 0.22),
          ],
        ),
      ),
    );
  }
}
