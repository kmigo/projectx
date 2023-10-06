


import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';

part 'state.dart';



class PasswordBloc extends Cubit<PasswordState> {
  final ValidPincodeUsecase _validPincodeUsecase;
  final ChangePincodeUsecase _changePincodeUsecase;
  PasswordBloc(this._validPincodeUsecase,this._changePincodeUsecase):super(const PasswordState(status: PasswordStatus.idle));

  changedState(PasswordState state){
    emit(state.copyWith(status: PasswordStatus.idle));
  }

  validateCurrentPassword()async{
    if(state.password == null) return;
    emit(state.copyWith(status: PasswordStatus.loading));
    final result = await _validPincodeUsecase( state.password!);
    result.fold((l) => emit(state.copyWith(status: PasswordStatus.failure, failure: l)),
     (r) => emit(state.copyWith(status: PasswordStatus.nextStep, step: state.step + 1)));
  }


  saveNewPassword()async{
    if(state.newPassword == null) return;
    emit(state.copyWith(status: PasswordStatus.loading));
    final result = await _changePincodeUsecase(state.newPassword!);
    result.fold((l) => emit(state.copyWith(status: PasswordStatus.failure, failure: l)),
     (r) => emit(state.copyWith(status: PasswordStatus.success)));
  }




}