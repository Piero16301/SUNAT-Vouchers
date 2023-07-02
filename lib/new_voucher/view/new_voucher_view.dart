import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunat_vouchers/new_voucher/new_voucher.dart';

class NewVoucherView extends StatelessWidget {
  const NewVoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = context.select<NewVoucherCubit, GlobalKey<FormState>>(
      (cubit) => cubit.state.formKey!,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nuevo Comprobante',
          style: TextStyle(fontFamily: 'Ubuntu-Regular'),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RucNewVoucher(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RucNewVoucher extends StatelessWidget {
  const RucNewVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Registro Único de Contribuyente - RUC',
          style: TextStyle(
            fontFamily: 'Ubuntu-Regular',
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number,
          onChanged: context.read<NewVoucherCubit>().changeRuc,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese el RUC';
            } else if (value.length != 11) {
              return 'El RUC debe tener 11 dígitos';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}
