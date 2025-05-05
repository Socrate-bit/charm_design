import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/interactions_cubit.dart';
import '../domain/interaction_session.dart';

class QuickStatsWidget extends StatelessWidget {
  const QuickStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocBuilder<InteractionsCubit, InteractionsState>(
      builder: (context, state) {
        if (state is! InteractionsLoaded) {
          return const SizedBox.shrink();
        }
        
        final sessions = state.sessions;
        
        // Calculate stats
        final totalSessions = sessions.length;
        final insightsGenerated = sessions.where(
          (s) => s.status == InteractionSessionStatus.analyzed
        ).length;
        final averageAlignment = sessions.isEmpty ? 0.0 : 
          sessions.fold<double>(0.0, (sum, session) => sum + (session.alignmentScore ?? 0.0)) / sessions.length;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Interaction Stats',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceBright,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(
                    context,
                    totalSessions.toString(),
                    'Total Sessions',
                    Icons.history,
                  ),
                  _buildStatItem(
                    context,
                    insightsGenerated.toString(),
                    'Insights Generated',
                    Icons.lightbulb,
                  ),
                  _buildStatItem(
                    context,
                    '74%',
                    'Average Alignment',
                    Icons.trending_up,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
} 