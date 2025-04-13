import 'package:flutter_bloc/flutter_bloc.dart';

class AffirmationsCubit extends Cubit<int> {
  AffirmationsCubit() : super(0);

  void selectAffirmation(int index) {
    emit(index);
  }
} 