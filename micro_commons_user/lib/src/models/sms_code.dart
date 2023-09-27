
import 'package:micro_core/micro_core.dart';

class SmsCodeModel extends Equatable {
  final String verificattionId;
  final String smsCode;
  final String phoneNumber;
  const SmsCodeModel({
    required this.verificattionId,
    required this.smsCode,
    required this.phoneNumber
  });
  
  @override
  List<Object?> get props => [
        verificattionId,
        phoneNumber,
        smsCode,];

}