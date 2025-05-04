import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/affirmation_theme.dart';
import '../../../domain/models/affirmation_music.dart';

class AffirmationsState {
  final int selectedAffirmationIndex;
  final AffirmationTheme selectedTheme;
  final AffirmationMusic selectedMusic;
  
  AffirmationsState({
    this.selectedAffirmationIndex = 0,
    this.selectedTheme = AffirmationTheme.nature,
    this.selectedMusic = AffirmationMusic.none,
  });
  
  AffirmationsState copyWith({
    int? selectedAffirmationIndex,
    AffirmationTheme? selectedTheme,
    AffirmationMusic? selectedMusic,
  }) {
    return AffirmationsState(
      selectedAffirmationIndex: selectedAffirmationIndex ?? this.selectedAffirmationIndex,
      selectedTheme: selectedTheme ?? this.selectedTheme,
      selectedMusic: selectedMusic ?? this.selectedMusic,
    );
  }
}

class AffirmationsCubit extends Cubit<AffirmationsState> {
  AffirmationsCubit() : super(AffirmationsState());

  void selectAffirmation(int index) {
    emit(state.copyWith(selectedAffirmationIndex: index));
  }
  
  void selectTheme(AffirmationTheme theme) {
    emit(state.copyWith(selectedTheme: theme));
  }
  
  void selectMusic(AffirmationMusic music) {
    emit(state.copyWith(selectedMusic: music));
  }
} 