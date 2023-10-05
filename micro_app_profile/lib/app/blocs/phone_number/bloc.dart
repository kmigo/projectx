

import 'package:micro_core/micro_core.dart';

part 'state.dart';

class PhoneNumberBloc extends Cubit<PhoneNumberUpdateState> {
  final VerifySmsCodeUpdatePhoneNumberUsecase _smsCodeUpdatePhoneNumberUsecase;
  final VerifyPhoneUsecase _verifyToUpdatePhoneUsecase;
  PhoneNumberBloc(this._smsCodeUpdatePhoneNumberUsecase,this._verifyToUpdatePhoneUsecase) : super(const PhoneNumberUpdateState(status: PhoneNumberUpdateStatus.idle));

  changedState(PhoneNumberUpdateState state){
    emit(state.copyWith(status: PhoneNumberUpdateStatus.idle));
  }

  validatePhoneNumber()async{
    if(state.phoneNumber == null) return;
    emit(state.copyWith(status: PhoneNumberUpdateStatus.loading));
    final result = await _verifyToUpdatePhoneUsecase(VerifyPhoneModel(verifycodeId: (verification){
      emit(state.copyWith(status: PhoneNumberUpdateStatus.nextStep, step: state.step + 1,verificationId: verification));
    }, phoneNumber: state.phoneNumber));
    result.fold((l) => emit(state.copyWith(
      status: PhoneNumberUpdateStatus.failure, failure: l)), (r) => null);
  }

  updatePhone()async{
    if(state.smsCode == null) return;
    emit(state.copyWith(status: PhoneNumberUpdateStatus.loading));
    final result = await _smsCodeUpdatePhoneNumberUsecase(SmsCodeModel(verificattionId: state.verificationId!, smsCode: state.smsCode!,phoneNumber: state.phoneNumber!));
    result.fold((l) => emit(state.copyWith(status: PhoneNumberUpdateStatus.failure, failure: l)),
     (r) => emit(state.copyWith(status: PhoneNumberUpdateStatus.success)));
  }
  }