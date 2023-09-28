import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';
part 'state.dart';

class ConfirmPhoneToCreateAccountBloc
    extends Cubit<ConfirmPhoneToCreateAccountState> {
  final VerifyPhoneUsecase _verifyPhoneUsecase;
  final ConfirmPhoneUsecase _confirmPhoneUsecase;
  ConfirmPhoneToCreateAccountBloc(
      this._confirmPhoneUsecase, this._verifyPhoneUsecase)
      : super(const ConfirmPhoneToCreateAccountState(
            status: ConfirmPhoneToCreateAccountStatus.idle));
  void changeSmsCode(String smsCode) {
    emit(state.copyWith(smsCode: smsCode));
  }        

  void changePhoneChoice(PhoneItemConfigModel phoneItemConfigModel){
  
    emit(state.copyWith(phoneItemConfigModel: phoneItemConfigModel));
    }

void verifyPhoneSend(String phoneNumber) async {


    emit(state.copyWith(status: ConfirmPhoneToCreateAccountStatus.loading));

    final result = await _verifyPhoneUsecase(VerifyPhoneModel(
      phoneItemConfigModel: state.phoneItemConfigModel!,
        verifycodeId: (codeId) => emit(state.copyWith(
            verificationId: codeId)),
        phoneNumber: phoneNumber));
    result.fold(
        (l) => emit(state.copyWith(
              status: ConfirmPhoneToCreateAccountStatus.error,
              error: l.message,
            )),
        (r) => emit(state.copyWith(
            status: ConfirmPhoneToCreateAccountStatus.confirmCode)));
  }

  Future<void> confirmPhone()async{
    emit(state.copyWith(status: ConfirmPhoneToCreateAccountStatus.loading));
    final result = await _confirmPhoneUsecase(SmsCodeModel(verificattionId: state.verificationId!, smsCode: state.smsCode!));
    result.fold((l) => emit(state.copyWith(error: l.message,status:ConfirmPhoneToCreateAccountStatus.error)), (r) => emit(state.copyWith(
      status: ConfirmPhoneToCreateAccountStatus.confirmed,
    )));
  }
}
