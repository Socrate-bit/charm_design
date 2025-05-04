import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationState {
  final int selectedIndex;

  NavigationState(this.selectedIndex);
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(0));

  void updateIndex(int index) {
    emit(NavigationState(index));
  }
}