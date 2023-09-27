import 'package:micro_core/micro_core.dart';

import '../../models/form_data.dart';
import '../../repository/authentication_repository.dart';
import '../entities/kyc.dart';

abstract class UpdateKycUsecase {
  Future<Either<Failure,void>> call(FormDataModel formData,LevelRoleEntity role);
}

class UpdateKycUsecaseImpl extends UpdateKycUsecase {
  final AuthenticationRepository _authenticationRepository;

  UpdateKycUsecaseImpl(this._authenticationRepository);
  @override
  Future<Either<Failure, void>> call(FormDataModel formData,LevelRoleEntity kyc) async{
      final ors = kyc.role?.data?.required?.or ?? [];
      bool orRequired = false;
      final fieldsRequired = kyc.role?.data?.required?.fields ?? [];
      for(var field in fieldsRequired){
        if(field.type == 'document'){
          for(MultiTypeFile doc in formData.files ?? []){
            if(!doc.filename.contains(field.field!)){
              throw Failure(message: '$field precisa ser preenchido');
            }
          }
          continue;
        }
        if( !formData.data.containsKey(field.field) ){
          throw Failure(message: '$field precisa ser preenchido');
        }
        
      }
      for(var or in ors){
        if(formData.data.containsKey(or.field)){
          orRequired = false;
          break;
        }else{
          orRequired = true;
        }
      }
    if(orRequired){
      return Left(Failure(message: '${ors.join(' ou ')} precisa ser preenchido'));
    }
    return await _authenticationRepository.updateKyc(formData);
  }

}