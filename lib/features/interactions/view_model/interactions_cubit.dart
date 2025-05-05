import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../domain/interaction_session.dart';

part 'interactions_state.dart';

class InteractionsCubit extends Cubit<InteractionsState> {
  InteractionsCubit() : super(InteractionsInitial()) {
    loadInteractionSessions();
  }

  void loadInteractionSessions() {
    emit(InteractionsLoading());
    
    // Simulate loading sessions (would be replaced with repository call)
    Future.delayed(Duration(milliseconds: 500), () {
      final sessions = _getMockSessions();
      emit(InteractionsLoaded(sessions: sessions));
    });
  }

  void startNewInteraction() {
    // Will navigate to create new interaction flow
    emit(StartingNewInteraction());
  }

  void openInteractionDetails(String sessionId) {
    // Will navigate to interaction details
    final sessions = state is InteractionsLoaded
        ? (state as InteractionsLoaded).sessions
        : <InteractionSession>[];
        
    final selectedSession = sessions.firstWhere((s) => s.id == sessionId);
    emit(InteractionDetailsSelected(session: selectedSession));
  }

  // Mock data - would be replaced with repository call
  List<InteractionSession> _getMockSessions() {
    return [
      InteractionSession(
        id: '1',
        dateTime: DateTime.now().subtract(Duration(days: 1)),
        title: '🌌 Morning Reflection',
        intention: 'Start the day with clarity and purpose',
        duration: Duration(minutes: 15),
        status: InteractionSessionStatus.analyzed,
        insightSummary: 'Found patterns of gratitude that boost your energy',
      ),
      InteractionSession(
        id: '2',
        dateTime: DateTime.now().subtract(Duration(days: 3)),
        title: '💬 Discussion with John',
        intention: 'Speak to John about the project, try to avoid conflict',
        duration: Duration(minutes: 22),
        status: InteractionSessionStatus.analyzed,
        insightSummary: 'Identified stress triggers from work meetings',
      ),
      InteractionSession(
        id: '3',
        dateTime: DateTime.now().subtract(Duration(days: 7)),
        title: '👔 Job interview',
        intention: 'Do the best I can to make a good impression',
        duration: Duration(hours: 1,minutes: 30),
        status: InteractionSessionStatus.completed,
        insightSummary: null,
      ),
    ];
  }
} 