import 'dart:io';

import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';

part 'state.dart';

class BlocUpdateKyc extends Cubit<UpdateKycState> {
  final UpdateKycUsecase _updateKycUsecaseImpl;
  final GetUserWithKycUsecase _getUserWithKycUsecaseImpl;
  BlocUpdateKyc(this._getUserWithKycUsecaseImpl,this._updateKycUsecaseImpl):super(const UpdateKycState(status: UpdateKycStatus.idle));


  getKyc()async{
    emit(state.copyWith(status: UpdateKycStatus.loading));  
    final result = await _getUserWithKycUsecaseImpl();
    result.fold((l) {
      emit(state.copyWith(status: UpdateKycStatus.failure,message: l.message));
    }, (r) {
      emit(state.copyWith(status: UpdateKycStatus.getKyc,userWithKycEntity: r));
    });
  }

  update({required int level,required FormDataModel formData }) async {
    emit(state.copyWith(status: UpdateKycStatus.loading));

    final result = await _updateKycUsecaseImpl(formData, state.userWithKycEntity!.kyc!.levels.where((element) => element.level == level).first);
    result.fold((l) {
      emit(state.copyWith(status: UpdateKycStatus.failure,message: l.message));
    }, (r) {
      emit(state.copyWith(status: UpdateKycStatus.updated));
    });

  }
    KYCSTATUSRESPONSE statusResponse(int level){
    if(state.userWithKycEntity ==null){
      return KYCSTATUSRESPONSE.idle;
    }
    final levels   = state.userWithKycEntity?.kyc?.levels.where((e) => e.level == level).toList() ?? [];
    if(levels.isEmpty){
      return KYCSTATUSRESPONSE.idle;
    }
    switch(levels.first.status){
      case 'PENDING':
        return KYCSTATUSRESPONSE.pending;
      case 'IN_REVIEW':
        return KYCSTATUSRESPONSE.inReview;
      case 'COMPLETED':
        return KYCSTATUSRESPONSE.completed;
      case 'ERROR':
        return KYCSTATUSRESPONSE.error;
      default:
        return KYCSTATUSRESPONSE.idle;
    }
  }
}