import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sunat_vouchers/new_voucher/new_voucher.dart';

class NewVoucherView extends StatelessWidget {
  const NewVoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = context.select<NewVoucherCubit, GlobalKey<FormState>>(
      (cubit) => cubit.state.formKey!,
    );

    return BlocConsumer<NewVoucherCubit, NewVoucherState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.pop();
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Nuevo comprobante',
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
                  SizedBox(height: 20),
                  VoucherTypeNewVoucher(),
                  SizedBox(height: 20),
                  SerialNewVoucher(),
                  SizedBox(height: 20),
                  NumberNewVoucher(),
                  SizedBox(height: 20),
                  DateNewVoucher(),
                  SizedBox(height: 20),
                  AmountNewVoucher(),
                  SizedBox(height: 50),
                  RegisterButtonNewVoucher(),
                ],
              ),
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
          cursorColor: Theme.of(context).secondaryHeaderColor,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).secondaryHeaderColor,
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

class VoucherTypeNewVoucher extends StatelessWidget {
  const VoucherTypeNewVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final voucherType = context.select<NewVoucherCubit, String>(
      (cubit) => cubit.state.voucherType,
    );

    final voucherTypes = <String>[
      'Factura',
      'Boleta',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tipo de comprobante',
          style: TextStyle(
            fontFamily: 'Ubuntu-Regular',
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        InputDecorator(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              value: voucherType,
              style: const TextStyle(
                fontFamily: 'Ubuntu-Regular',
                fontSize: 14,
                color: Colors.black,
              ),
              onChanged: context.read<NewVoucherCubit>().changeVoucherType,
              items: voucherTypes
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class SerialNewVoucher extends StatelessWidget {
  const SerialNewVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Serie',
          style: TextStyle(
            fontFamily: 'Ubuntu-Regular',
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          cursorColor: Theme.of(context).secondaryHeaderColor,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).secondaryHeaderColor,
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
          textCapitalization: TextCapitalization.characters,
          onChanged: context.read<NewVoucherCubit>().changeSerial,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese la serie';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}

class NumberNewVoucher extends StatelessWidget {
  const NumberNewVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Número',
          style: TextStyle(
            fontFamily: 'Ubuntu-Regular',
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          cursorColor: Theme.of(context).secondaryHeaderColor,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).secondaryHeaderColor,
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
          onChanged: context.read<NewVoucherCubit>().changeNumber,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese el número';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}

class DateNewVoucher extends StatelessWidget {
  const DateNewVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final dateOfIssue = context.select<NewVoucherCubit, DateTime>(
      (cubit) => cubit.state.date!,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fecha de emisión',
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
                color: Theme.of(context).secondaryHeaderColor,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            suffixIcon: IconButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: dateOfIssue,
                  firstDate: DateTime(2023),
                  lastDate: DateTime.now(),
                  locale: const Locale('es', 'ES'),
                  builder: (context, child) => Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light().copyWith(
                        primary: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    child: child!,
                  ),
                );
                // ignore: use_build_context_synchronously // The context is still valid here as the widget is not disposed.
                context.read<NewVoucherCubit>().changeDate(date);
              },
              icon: const Icon(Icons.calendar_today_outlined),
            ),
          ),
          controller: TextEditingController(
            text: DateFormat('dd/MM/yyyy').format(dateOfIssue),
          ),
          readOnly: true,
        ),
      ],
    );
  }
}

class AmountNewVoucher extends StatelessWidget {
  const AmountNewVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Monto',
          style: TextStyle(
            fontFamily: 'Ubuntu-Regular',
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          cursorColor: Theme.of(context).secondaryHeaderColor,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).secondaryHeaderColor,
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
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d+\.?\d{0,2}'),
            ),
          ],
          keyboardType: TextInputType.number,
          onChanged: context.read<NewVoucherCubit>().changeAmount,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese el monto';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}

class RegisterButtonNewVoucher extends StatelessWidget {
  const RegisterButtonNewVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select<NewVoucherCubit, NewVoucherStatus>(
      (cubit) => cubit.state.status,
    );

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: status.isLoading
            ? null
            : context.read<NewVoucherCubit>().registerVoucher,
        child: status.isLoading
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : const Text(
                'Registrar',
                style: TextStyle(
                  fontFamily: 'Ubuntu-Regular',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
