part of 'new_voucher_cubit.dart';

enum NewVoucherStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == NewVoucherStatus.initial;
  bool get isLoading => this == NewVoucherStatus.loading;
  bool get isSuccess => this == NewVoucherStatus.success;
  bool get isFailure => this == NewVoucherStatus.failure;
}

class NewVoucherState extends Equatable {
  const NewVoucherState({
    this.status = NewVoucherStatus.initial,
    this.userId = '',
    this.formKey,
    this.ruc = '',
    this.voucherType = 'Factura',
    this.serial = '',
    this.number = '',
    this.date,
    this.amount = 0,
  });

  final NewVoucherStatus status;
  final String userId;
  final GlobalKey<FormState>? formKey;

  final String ruc;
  final String voucherType;
  final String serial;
  final String number;
  final DateTime? date;
  final double amount;

  NewVoucherState copyWith({
    NewVoucherStatus? status,
    String? userId,
    GlobalKey<FormState>? formKey,
    String? ruc,
    String? voucherType,
    String? serial,
    String? number,
    DateTime? date,
    double? amount,
  }) {
    return NewVoucherState(
      status: status ?? this.status,
      userId: userId ?? this.userId,
      formKey: formKey ?? this.formKey,
      ruc: ruc ?? this.ruc,
      voucherType: voucherType ?? this.voucherType,
      serial: serial ?? this.serial,
      number: number ?? this.number,
      date: date ?? this.date,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [
        status,
        userId,
        formKey,
        ruc,
        voucherType,
        serial,
        number,
        date,
        amount,
      ];
}
