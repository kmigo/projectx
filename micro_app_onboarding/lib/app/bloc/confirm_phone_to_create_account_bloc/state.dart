part of 'bloc.dart';

enum ConfirmPhoneToCreateAccountStatus {idle, loading, error,confirmCode,confirmed}


class ConfirmPhoneToCreateAccountState extends Equatable {
  final ConfirmPhoneToCreateAccountStatus status;
  final PhoneItemConfigModel? phoneItemConfigModel;
  final String? verificationId;
  final String? smsCode;
  final String? error;
  const ConfirmPhoneToCreateAccountState({
    required this.status,
    this.verificationId,
    this.smsCode,
    this.phoneItemConfigModel,
    this.error,
  });
  @override
  List<Object?> get props => [verificationId,status,error,phoneItemConfigModel,smsCode];


  ConfirmPhoneToCreateAccountState copyWith({
    ConfirmPhoneToCreateAccountStatus? status,
    String? verificationId,
    String? smsCode,
    PhoneItemConfigModel? phoneItemConfigModel,
    String? error,
  }) {
    return ConfirmPhoneToCreateAccountState(
      smsCode: smsCode ?? this.smsCode,
      status: status ?? this.status,
      phoneItemConfigModel: phoneItemConfigModel ?? this.phoneItemConfigModel,
      verificationId: verificationId ?? this.verificationId,
      error: error ,
    );
  }
}
