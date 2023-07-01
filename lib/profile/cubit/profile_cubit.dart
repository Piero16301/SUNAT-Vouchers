import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  Future<void> logIn() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: ProfileStatus.success));
    } catch (_) {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }
}
