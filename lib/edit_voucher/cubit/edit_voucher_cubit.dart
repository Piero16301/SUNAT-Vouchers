import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sunat_vouchers/models/models.dart';

part 'edit_voucher_state.dart';

class EditVoucherCubit extends Cubit<EditVoucherState> {
  EditVoucherCubit() : super(const EditVoucherState());

  Future<void> loadVoucherData(String userUid, String voucherId) async {
    emit(state.copyWith(status: EditVoucherStatus.loading));

    try {
      emit(
        state.copyWith(
          userUid: userUid,
          voucherId: voucherId,
          formKey: GlobalKey<FormState>(),
          date: DateTime.now(),
        ),
      );

      // Obtener datos del comprobante
      final voucher = Voucher.fromJson(
        await FirebaseFirestore.instance
            .collection('vouchers')
            .doc(voucherId)
            .get()
            .then((value) => value.data()!),
      );

      emit(
        state.copyWith(
          status: EditVoucherStatus.success,
          ruc: voucher.ruc,
          voucherType: voucher.voucherType,
          serial: voucher.serial,
          number: voucher.number,
          date: voucher.date,
          amount: voucher.amount,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: EditVoucherStatus.failure));
    }
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

  void resetUpdateStatus() {
    emit(state.copyWith(updateStatus: UpdateStatus.initial));
  }

  void updateVoucher() {
    if (!state.formKey!.currentState!.validate()) return;

    emit(state.copyWith(updateStatus: UpdateStatus.loading));

    try {
      // Actualizar datos del comprobante
      unawaited(
        FirebaseFirestore.instance
            .collection('vouchers')
            .doc(state.voucherId)
            .update({
              'ruc': state.ruc,
              'socialReason': 'Verificando...',
              'voucherType': state.voucherType,
              'serial': state.serial,
              'number': state.number,
              'date': state.date,
              'amount': state.amount,
              'statusRuc': 'Pendiente',
              'statusVoucher': 'Pendiente',
            }),
      );

      emit(state.copyWith(updateStatus: UpdateStatus.success));
    } on Exception {
      emit(state.copyWith(updateStatus: UpdateStatus.failure));
    }
  }
}
