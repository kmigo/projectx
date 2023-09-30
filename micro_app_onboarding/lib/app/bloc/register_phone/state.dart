part of 'bloc.dart';

enum ConfirmPhoneToCreateAccountStatus {idle, loading, error,confirmCode,confirmed}


class ConfirmPhoneToCreateAccountState extends Equatable {
  final ConfirmPhoneToCreateAccountStatus status;
  final PhoneItemConfigModel? phoneItemConfigModel;
  final String? verificationId;
  final String? phone;
  final String? smsCode;
  final String? error;
  const ConfirmPhoneToCreateAccountState({
    required this.status,
    this.verificationId,
    this.smsCode,
    this.phone,
    this.phoneItemConfigModel,
    this.error,
  });
  @override
  List<Object?> get props => [verificationId,status,error,phoneItemConfigModel,smsCode];


  ConfirmPhoneToCreateAccountState copyWith({
    ConfirmPhoneToCreateAccountStatus? status,
    String? verificationId,
    String? smsCode,
    String? phone,
    PhoneItemConfigModel? phoneItemConfigModel,
    String? error,
  }) {
    return ConfirmPhoneToCreateAccountState(
      smsCode: smsCode ?? this.smsCode,
      status: status ?? this.status,
      phone: phone ?? this.phone,
      phoneItemConfigModel: phoneItemConfigModel ?? this.phoneItemConfigModel,
      verificationId: verificationId ?? this.verificationId,
      error: error ,
    );
  }

  String getPhoneFormated(){
    if(phoneItemConfigModel == null) return '';
    final code = phoneItemConfigModel!.code;
    final onlyDigits = phone!.replaceAll(RegExp(r'\D'), '');
    return '$code$onlyDigits';
  }
}
