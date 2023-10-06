import 'package:micro_core/micro_core.dart';

import '../../../micro_commons_user.dart';

part 'state.dart';

class ValidPinCodeBloc extends Cubit<ValidPinCodeState> {
  final ValidPincodeUsecase _validPincodeUsecase;
  ValidPinCodeBloc(this._validPincodeUsecase):super(const ValidPinCodeState(status: ValidPinCodeStatus.idle));

  validCode(String code)async{
    emit(state.copyWith(status: ValidPinCodeStatus.loading));
    final result = await _validPincodeUsecase(code);
    result.fold((l) => emit(state.copyWith(status: ValidPinCodeStatus.failure, failure: l)),
     (r) => emit(state.copyWith(status: ValidPinCodeStatus.success)));
  }

}