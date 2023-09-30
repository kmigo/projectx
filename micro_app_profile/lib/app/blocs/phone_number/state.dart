// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

enum PhoneNumberUpdateStatus { idle, loading, success, failure, nextStep }
class PhoneNumberUpdateState extends Equatable {
  final PhoneNumberUpdateStatus status;
  final Failure? failure;
  final String? phoneNumber;
  final String? smsCode;
  final String? verificationId;
  final int step;
  const PhoneNumberUpdateState({
    required this.status,
    this.failure,
    this.phoneNumber,
    this.verificationId,
    this.smsCode,
     this.step = 0,
  });
  

  PhoneNumberUpdateState copyWith({
    PhoneNumberUpdateStatus? status,
    Failure? failure,
    String? phoneNumber,
    String? smsCode,
    String? verificationId, 
    int? step,
  }) {
    return PhoneNumberUpdateState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      smsCode: smsCode ?? this.smsCode,
      step: step ?? this.step,
      verificationId: verificationId ?? this.verificationId,
    );
  }
  
  @override
  List<Object?> get props => [
        status,
        failure,
        phoneNumber,
        verificationId,
        smsCode,
        step,];
}
