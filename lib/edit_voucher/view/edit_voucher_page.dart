import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunat_vouchers/edit_voucher/edit_voucher.dart';

class EditVoucherPage extends StatelessWidget {
  const EditVoucherPage({
    required this.userUid,
    required this.voucherId,
    super.key,
  });

  final String userUid;
  final String voucherId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditVoucherCubit()..loadVoucherData(userUid, voucherId),
      child: const EditVoucherView(),
    );
  }
}
