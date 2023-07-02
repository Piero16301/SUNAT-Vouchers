import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sunat_vouchers/edit_voucher/edit_voucher.dart';

class EditVoucherView extends StatelessWidget {
  const EditVoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = context.select<EditVoucherCubit, GlobalKey<FormState>>(
      (cubit) => cubit.state.formKey!,
    );

    return BlocConsumer<EditVoucherCubit, EditVoucherState>(
      listener: (context, state) {
        if (state.updateStatus.isSuccess) {
          context.pop();
        } else if (state.updateStatus.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Ha ocurrido un error al actualizar el comprobante.',
                textAlign: TextAlign.center,
              ),
              duration: Duration(seconds: 3),
            ),
          );
          context.read<EditVoucherCubit>().resetUpdateStatus();
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Editar comprobante',
            style: TextStyle(fontFamily: 'Ubuntu-Regular'),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<EditVoucherCubit, EditVoucherState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                );
              } else if (state.status.isSuccess) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RucEditVoucher(),
                        SizedBox(height: 20),
                        VoucherTypeEditVoucher(),
                        SizedBox(height: 20),
                        SerialEditVoucher(),
                        SizedBox(height: 20),
                        NumberEditVoucher(),
                        SizedBox(height: 20),
                        DateEditVoucher(),
                        SizedBox(height: 20),
                        AmountEditVoucher(),
                        SizedBox(height: 50),
                        UpdateButtonEditVoucher(),
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: Text(
                  'No se pudo cargar el comprobante',
                  style: TextStyle(
                    fontFamily: 'Ubuntu-Regular',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class RucEditVoucher extends StatelessWidget {
  const RucEditVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final ruc = context.select<EditVoucherCubit, String>(
      (cubit) => cubit.state.ruc,
    );

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
          initialValue: ruc,
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
          onChanged: context.read<EditVoucherCubit>().changeRuc,
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

class VoucherTypeEditVoucher extends StatelessWidget {
  const VoucherTypeEditVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final voucherType = context.select<EditVoucherCubit, String>(
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
              onChanged: context.read<EditVoucherCubit>().changeVoucherType,
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

class SerialEditVoucher extends StatelessWidget {
  const SerialEditVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final serial = context.select<EditVoucherCubit, String>(
      (cubit) => cubit.state.serial,
    );

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
          initialValue: serial,
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
          onChanged: context.read<EditVoucherCubit>().changeSerial,
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

class NumberEditVoucher extends StatelessWidget {
  const NumberEditVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final number = context.select<EditVoucherCubit, String>(
      (cubit) => cubit.state.number,
    );

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
          initialValue: number,
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
          onChanged: context.read<EditVoucherCubit>().changeNumber,
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

class DateEditVoucher extends StatelessWidget {
  const DateEditVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final dateOfIssue = context.select<EditVoucherCubit, DateTime>(
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
                // ignore: use_build_context_synchronously
                context.read<EditVoucherCubit>().changeDate(date);
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

class AmountEditVoucher extends StatelessWidget {
  const AmountEditVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final amount = context.select<EditVoucherCubit, double>(
      (cubit) => cubit.state.amount,
    );

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
          initialValue: amount.toStringAsFixed(2),
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
          onChanged: context.read<EditVoucherCubit>().changeAmount,
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

class UpdateButtonEditVoucher extends StatelessWidget {
  const UpdateButtonEditVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select<EditVoucherCubit, EditVoucherStatus>(
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
            : context.read<EditVoucherCubit>().updateVoucher,
        child: status.isLoading
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : const Text(
                'Actualizar',
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
