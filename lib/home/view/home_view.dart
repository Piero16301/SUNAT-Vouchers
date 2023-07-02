import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sunat_vouchers/models/models.dart';

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
              size: 25,
            ),
            onPressed: () => context.pushNamed('profile'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('vouchers')
              .where(
                'userUid',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid,
              )
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    'No hay comprobantes'.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Ubuntu-Regular',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final baseVoucher = snapshot.data!.docs[index].data()!
                      as Map<String, dynamic>;
                  final voucher = Voucher.fromJson(baseVoucher);

                  return VoucherCardItemHome(
                    voucherId: voucher.id,
                    ruc: voucher.ruc,
                    socialReason: voucher.socialReason,
                    voucherType: voucher.voucherType,
                    serial: voucher.serial,
                    number: voucher.number,
                    date: voucher.date,
                    amount: voucher.amount,
                    statusRuc: voucher.statusRuc,
                    statusVoucher: voucher.statusVoucher,
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        onPressed: () => context.pushNamed(
          'newVoucher',
          pathParameters: {
            'userId': FirebaseAuth.instance.currentUser!.uid,
          },
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
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
    required this.voucherId,
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

  final String voucherId;
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
      child: InkWell(
        onTap: () => context.pushNamed(
          'editVoucher',
          pathParameters: {
            'userId': FirebaseAuth.instance.currentUser!.uid,
            'voucherId': voucherId,
          },
        ),
        child: SizedBox(
          height: 206,
          width: double.infinity,
          child: Card(
            color: Colors.grey[100],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: Colors.grey,
              ),
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
      ),
    );
  }
}
