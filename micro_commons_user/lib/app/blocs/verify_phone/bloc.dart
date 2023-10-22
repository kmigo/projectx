
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';
part 'state.dart';

class VerifyPhoneBloc
    extends Cubit<LoginPhoneState> {
  final VerifyPhoneUsecase _verifyPhoneUsecase;
  final ConfirmPhoneUsecase _confirmPhoneUsecase;
  VerifyPhoneBloc(
      this._confirmPhoneUsecase, this._verifyPhoneUsecase)
      : super(const LoginPhoneState(
            status: LoginPhoneStatus.idle));
  void changeSmsCode(String smsCode) {
    emit(state.copyWith(smsCode: smsCode));
  }        

  void changePhoneChoice(PhoneItemConfigModel phoneItemConfigModel){
  
    emit(state.copyWith(phoneItemConfigModel: phoneItemConfigModel));
    }

void verifyPhoneSend(String phoneNumber,{bool veryToCreateAccount = false, bool verifyToLogin= false}) async {


   
   final onlyNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
      final codeCountry = state.phoneItemConfigModel!.code;
       emit(state.copyWith(status: LoginPhoneStatus.loading,phone:'$codeCountry$onlyNumber'));
    final result = await _verifyPhoneUsecase(VerifyPhoneModel(
      phoneItemConfigModel: state.phoneItemConfigModel!,
        verifycodeId: (codeId) => emit(state.copyWith(
            verificationId: codeId)),
        phoneNumber: phoneNumber),veryToCreateAccount: veryToCreateAccount,verifyToLogin: verifyToLogin);
    result.fold(
        (l) => emit(state.copyWith(
              status: LoginPhoneStatus.error,
              error: l.message,
            )),
        (r) => emit(state.copyWith(
            status: LoginPhoneStatus.confirmCode,
            )));
  }

  Future<void> confirmPhone(bool update)async{
    emit(state.copyWith(status: LoginPhoneStatus.loading));
    final result = await _confirmPhoneUsecase(SmsCodeModel(verificattionId: state.verificationId!, smsCode: state.smsCode!,phoneNumber: state.phone),update);
    result.fold((l) => emit(state.copyWith(error: l.message,status:LoginPhoneStatus.error)), (r) => emit(state.copyWith(
      status: LoginPhoneStatus.confirmed,
    )));
  }
}
