part of 'interactions_cubit.dart';

abstract class InteractionsState extends Equatable {
  const InteractionsState();
  
  @override
  List<Object?> get props => [];
}

class InteractionsInitial extends InteractionsState {}

class InteractionsLoading extends InteractionsState {}

class InteractionsLoaded extends InteractionsState {
  final List<InteractionSession> sessions;
  
  const InteractionsLoaded({required this.sessions});
  
  @override
  List<Object?> get props => [sessions];
}

class StartingNewInteraction extends InteractionsState {}

class InteractionDetailsSelected extends InteractionsState {
  final InteractionSession session;
  
  const InteractionDetailsSelected({required this.session});
  
  @override
  List<Object?> get props => [session];
} 