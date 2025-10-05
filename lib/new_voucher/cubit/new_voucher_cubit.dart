import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sunat_vouchers/models/models.dart';
import 'package:uuid/uuid.dart';

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
    if (amount == '') return;
    emit(state.copyWith(amount: double.parse(amount ?? '0')));
  }

  void registerVoucher() {
    // Validar formulario
    if (!state.formKey!.currentState!.validate()) return;

    emit(state.copyWith(status: NewVoucherStatus.loading));

    try {
      // Crear voucher
      final voucher = Voucher(
        id: const Uuid().v1(),
        userUid: state.userId,
        ruc: state.ruc,
        socialReason: 'Consultando...',
        voucherType: state.voucherType,
        serial: state.serial,
        number: state.number,
        date: state.date!,
        amount: state.amount,
        statusRuc: 'Pendiente',
        statusVoucher: 'Pendiente',
      );

      // Guardar comprobante en Firestore
      unawaited(
        FirebaseFirestore.instance
            .collection('vouchers')
            .doc(voucher.id)
            .set(voucher.toJson()),
      );

      emit(state.copyWith(status: NewVoucherStatus.success));
    } on Exception {
      emit(state.copyWith(status: NewVoucherStatus.failure));
    }
  }
}
