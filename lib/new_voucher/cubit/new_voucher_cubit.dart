import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'new_voucher_state.dart';

class NewVoucherCubit extends Cubit<NewVoucherState> {
  NewVoucherCubit() : super(const NewVoucherState());

  void loadInitialData(String userId) {
    emit(
      state.copyWith(
        userId: userId,
        formKey: GlobalKey<FormState>(),
        date: DateTime.now(),
      ),
    );
  }

  void changeRuc(String? ruc) {
    emit(state.copyWith(ruc: ruc));
  }

  void changeVoucherType(String? voucherType) {
    emit(state.copyWith(voucherType: voucherType));
  }

  void changeSerial(String? serial) {
    emit(state.copyWith(serial: serial));
  }

  void changeNumber(String? number) {
    emit(state.copyWith(number: number));
  }

  void changeDate(DateTime? date) {
    emit(state.copyWith(date: date));
  }

  void changeAmount(String? amount) {
    emit(state.copyWith(amount: double.parse(amount ?? '0')));
  }
}
