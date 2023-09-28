
part of 'models.dart';

class SmsCodeModel extends Equatable {
  final String verificattionId;
  final String smsCode;
  final String? phoneNumber;
  const SmsCodeModel({
    required this.verificattionId,
    required this.smsCode,
    this.phoneNumber
  });
  
  @override
  List<Object?> get props => [
        verificattionId,
        phoneNumber,
        smsCode,];

}