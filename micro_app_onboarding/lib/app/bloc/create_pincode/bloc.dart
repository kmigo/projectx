

import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';

part 'state.dart';


class CreatePinCodeBloc extends Cubit<CreatePinCodeState> {
  final SignUpUsecase _signUpUsecase;
  CreatePinCodeBloc(this._signUpUsecase) : super(const CreatePinCodeState());

  changePinCode(String code) => emit(state.copyWith(pinCode: code));
  changeConfirmPinCode(String code) => emit(state.copyWith(confirmPinCode: code));

  createAccount(String phone)async{
    emit(state.copyWith(status: CreatePinCodeStatus.loading));
    final result = await _signUpUsecase(SignUpModel(phone: phone,pincode: state.pinCode), state.confirmPinCode);
    result.fold(
      (error) => emit(state.copyWith(status: CreatePinCodeStatus.error,error: error.message)),
      (success) => emit(state.copyWith(status: CreatePinCodeStatus.success)),
    );
  }

}