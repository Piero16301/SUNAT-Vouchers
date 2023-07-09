import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher.g.dart';

/// {@template voucher}
/// Modelo de dados para un comprobante
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Voucher extends Equatable {
  /// {@macro voucher}
  const Voucher({
    required this.id,
    required this.userUid,
    required this.ruc,
    required this.socialReason,
    required this.voucherType,
    required this.serial,
    required this.number,
    required this.date,
    required this.amount,
    required this.statusRuc,
    required this.statusVoucher,
  });

  /// Crea una instancia de [Voucher] a partir de un [Map]
  factory Voucher.fromJson(Map<String, dynamic> json) =>
      _$VoucherFromJson(json);

  /// Crea un [Map] a partir de una instancia de [Voucher]
  Map<String, dynamic> toJson() => _$VoucherToJson(this);

  /// ID del comprobante
  final String id;

  /// ID del usuario
  final String userUid;

  /// RUC del emisor
  final String ruc;

  /// Razón social del emisor
  final String socialReason;

  /// Tipo de comprobante
  final String voucherType;

  /// Serie del comprobante
  final String serial;

  /// Número del comprobante
  final String number;

  /// Fecha de emisión del comprobante
  final DateTime date;

  /// Monto del comprobante
  final double amount;

  /// Estado del RUC del emisor
  final String statusRuc;

  /// Estado del comprobante
  final String statusVoucher;

  @override
  List<Object?> get props => [
        id,
        userUid,
        ruc,
        socialReason,
        voucherType,
        serial,
        number,
        date,
        amount,
        statusRuc,
        statusVoucher,
      ];
}
