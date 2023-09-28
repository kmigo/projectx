part of 'usecases.dart';

abstract class UpdateKycUsecase {
  Future<Either<Failure,void>> call(FormDataModel formData,LevelRoleEntity role);
}

class UpdateKycUsecaseImpl extends UpdateKycUsecase {
  final AuthenticationRepository _authenticationRepository;

  UpdateKycUsecaseImpl(this._authenticationRepository);
  @override
  Future<Either<Failure, void>> call(FormDataModel formData,LevelRoleEntity role) async{
      final ors = role.role?.data?.required?.or ?? [];
      bool orRequired = false;
      final fieldsRequired = role.role?.data?.required?.fields ?? [];
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