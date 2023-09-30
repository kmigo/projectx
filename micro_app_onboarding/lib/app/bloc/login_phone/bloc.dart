import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';
part 'state.dart';

class LoginPhoneBloc
    extends Cubit<LoginPhoneState> {
  final VerifyPhoneUsecase _verifyPhoneUsecase;
  final ConfirmPhoneUsecase _confirmPhoneUsecase;
  LoginPhoneBloc(
      this._confirmPhoneUsecase, this._verifyPhoneUsecase)
      : super(const LoginPhoneState(
            status: LoginPhoneStatus.idle));
  void changeSmsCode(String smsCode) {
    emit(state.copyWith(smsCode: smsCode));
  }        

  void changePhoneChoice(PhoneItemConfigModel phoneItemConfigModel){
  
    emit(state.copyWith(phoneItemConfigModel: phoneItemConfigModel));
    }

void verifyPhoneSend(String phoneNumber) async {


    emit(state.copyWith(status: LoginPhoneStatus.loading,phone: phoneNumber));

    final result = await _verifyPhoneUsecase(VerifyPhoneModel(
      phoneItemConfigModel: state.phoneItemConfigModel!,
        verifycodeId: (codeId) => emit(state.copyWith(
            verificationId: codeId)),
        phoneNumber: phoneNumber),checkAccountAlreadyExist: false);
    result.fold(
        (l) => emit(state.copyWith(
              status: LoginPhoneStatus.error,
              error: l.message,
            )),
        (r) => emit(state.copyWith(
            status: LoginPhoneStatus.confirmCode,
            phone: phoneNumber
            )));
  }

  Future<void> confirmPhone()async{
    emit(state.copyWith(status: LoginPhoneStatus.loading));
    final result = await _confirmPhoneUsecase(SmsCodeModel(verificattionId: state.verificationId!, smsCode: state.smsCode!));
    result.fold((l) => emit(state.copyWith(error: l.message,status:LoginPhoneStatus.error)), (r) => emit(state.copyWith(
      status: LoginPhoneStatus.confirmed,
    )));
  }
}
