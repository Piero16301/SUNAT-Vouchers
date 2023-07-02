part of 'edit_voucher_cubit.dart';

enum EditVoucherStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == EditVoucherStatus.initial;
  bool get isLoading => this == EditVoucherStatus.loading;
  bool get isSuccess => this == EditVoucherStatus.success;
  bool get isFailure => this == EditVoucherStatus.failure;
}

enum UpdateStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == UpdateStatus.initial;
  bool get isLoading => this == UpdateStatus.loading;
  bool get isSuccess => this == UpdateStatus.success;
  bool get isFailure => this == UpdateStatus.failure;
}

class EditVoucherState extends Equatable {
  const EditVoucherState({
    this.status = EditVoucherStatus.initial,
    this.updateStatus = UpdateStatus.initial,
    this.userUid = '',
    this.voucherId = '',
    this.formKey,
    this.ruc = '',
    this.voucherType = 'Factura',
    this.serial = '',
    this.number = '',
    this.date,
    this.amount = 0,
  });

  final EditVoucherStatus status;
  final UpdateStatus updateStatus;
  final String userUid;
  final String voucherId;
  final GlobalKey<FormState>? formKey;

  final String ruc;
  final String voucherType;
  final String serial;
  final String number;
  final DateTime? date;
  final double amount;

  EditVoucherState copyWith({
    EditVoucherStatus? status,
    UpdateStatus? updateStatus,
    String? userUid,
    String? voucherId,
    GlobalKey<FormState>? formKey,
    String? ruc,
    String? voucherType,
    String? serial,
    String? number,
    DateTime? date,
    double? amount,
  }) {
    return EditVoucherState(
      status: status ?? this.status,
      updateStatus: updateStatus ?? this.updateStatus,
      userUid: userUid ?? this.userUid,
      voucherId: voucherId ?? this.voucherId,
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
        updateStatus,
        userUid,
        voucherId,
        formKey,
        ruc,
        voucherType,
        serial,
        number,
        date,
        amount,
      ];
}
