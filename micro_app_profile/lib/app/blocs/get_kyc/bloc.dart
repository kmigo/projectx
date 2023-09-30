
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';

part 'state.dart';



class BlocUserKyc extends Cubit<KycState> {
  final GetUserWithKycUsecase _getUserByUidUsecase;
  BlocUserKyc(this._getUserByUidUsecase) : super(const KycState());
  getUser() async {
    emit(state.copyWith(status: KycStatus.loading));
    final result = await _getUserByUidUsecase();
    result.fold(
        (l) =>
            emit(state.copyWith(status: KycStatus.error, failure: l.message)),
        (r) => emit(state.copyWith(status: KycStatus.success, user: r)));
  }
  KYCSTATUSRESPONSE statusResponse(int level){
    if(state.user ==null){
      return KYCSTATUSRESPONSE.idle;
    }
    final levels   = state.user?.kyc?.levels.where((e) => e.level == level).toList() ?? [];
    if(levels.isEmpty){
      return KYCSTATUSRESPONSE.idle;
    }
    switch(levels.first.status){
      case 'PENDING':
        return KYCSTATUSRESPONSE.pending;
      case 'IN_REVIEW':
        return KYCSTATUSRESPONSE.inReview;
      case 'processing':
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
