import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunat_vouchers/new_voucher/new_voucher.dart';

class NewVoucherPage extends StatelessWidget {
  const NewVoucherPage({
    required this.userId,
    super.key,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewVoucherCubit()..loadInitialData(userId),
      child: const NewVoucherView(),
    );
  }
}
