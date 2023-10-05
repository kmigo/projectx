


import 'package:micro_core/micro_core.dart';

part 'state.dart';

class AddressBloc extends Cubit<AddressState> {
  final UpdateAddressUsecase _addressUsecase;
  AddressBloc(this._addressUsecase) : super(const AddressState(status: AddressStatus.idle));

  updateAddress(AddressModel addressModel) {
    Future.delayed(Duration.zero).then((a) => emit(state.copyWith(address: addressModel)));
  }
  save(String uid)async{
    emit(state.copyWith(status: AddressStatus.loading));  
    final result = await _addressUsecase(state.address,uid);
    result.fold((l) => emit(state.copyWith(error: l)),
     (r) => emit(state.copyWith(status: AddressStatus.success)));
  }
}