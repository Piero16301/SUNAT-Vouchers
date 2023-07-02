// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Voucher _$VoucherFromJson(Map<String, dynamic> json) {
  return Voucher(
    id: json['id'] as String? ?? '',
    userUid: json['userUid'] as String? ?? '',
    ruc: json['ruc'] as String? ?? '',
    socialReason: json['socialReason'] as String? ?? '',
    voucherType: json['voucherType'] as String? ?? '',
    serial: json['serial'] as String? ?? '',
    number: json['number'] as String? ?? '',
    date: (json['date'] as Timestamp? ?? Timestamp.now()).toDate(),
    amount: (json['amount'] as num).toDouble(),
    statusRuc: json['statusRuc'] as bool,
    statusVoucher: json['statusVoucher'] as bool,
  );
}

Map<String, dynamic> _$VoucherToJson(Voucher instance) => <String, dynamic>{
      'id': instance.id,
      'userUid': instance.userUid,
      'ruc': instance.ruc,
      'socialReason': instance.socialReason,
      'voucherType': instance.voucherType,
      'serial': instance.serial,
      'number': instance.number,
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
      'statusRuc': instance.statusRuc,
      'statusVoucher': instance.statusVoucher,
    };
