import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comprobantes',
          style: TextStyle(fontFamily: 'Ubuntu-Regular'),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => context.pushNamed('profile'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
              6,
              (index) => VoucherCardItemHome(
                ruc: '12345678901',
                socialReason: 'Empresa S.A.C.',
                voucherType: 'Factura',
                serial: 'F001',
                number: '00000001',
                date: DateTime.now(),
                amount: 100.97,
                statusRuc: true,
                statusVoucher: false,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        label: const Text(
          'Nuevo',
          style: TextStyle(
            fontFamily: 'Ubuntu-Regular',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

class VoucherCardItemHome extends StatelessWidget {
  const VoucherCardItemHome({
    required this.ruc,
    required this.socialReason,
    required this.voucherType,
    required this.serial,
    required this.number,
    required this.date,
    required this.amount,
    required this.statusRuc,
    required this.statusVoucher,
    super.key,
  });

  final String ruc;
  final String socialReason;
  final String voucherType;
  final String serial;
  final String number;
  final DateTime date;
  final double amount;
  final bool statusRuc;
  final bool statusVoucher;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 206,
        width: double.infinity,
        child: Card(
          color: Colors.grey[100],
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'RUC: ',
                            style: TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ruc,
                            style: const TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'Tipo: ',
                            style: TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            voucherType,
                            style: const TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      'Razón Social: ',
                      style: TextStyle(
                        fontFamily: 'Ubuntu-Regular',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      socialReason,
                      style: const TextStyle(
                        fontFamily: 'Ubuntu-Regular',
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'Serie: ',
                            style: TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            serial,
                            style: const TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'Número: ',
                            style: TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            number,
                            style: const TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'Fecha: ',
                            style: TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy').format(date),
                            style: const TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'Monto: ',
                            style: TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            amount.toStringAsFixed(2),
                            style: const TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Estado'.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Ubuntu-Regular',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            statusRuc
                                ? Icons.check_circle
                                : Icons.cancel_outlined,
                            color: statusRuc ? Colors.green : Colors.red,
                            size: 20,
                          ),
                          const Text(
                            ' RUC',
                            style: TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            statusVoucher
                                ? Icons.check_circle
                                : Icons.cancel_outlined,
                            color: statusVoucher ? Colors.green : Colors.red,
                            size: 20,
                          ),
                          const Text(
                            ' Comprobante',
                            style: TextStyle(
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
