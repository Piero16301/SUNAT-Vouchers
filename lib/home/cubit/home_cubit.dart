import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> logout() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: HomeStatus.success));
    } on Exception {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
