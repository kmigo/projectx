import 'package:micro_core/micro_core.dart';

import '../../repository/authentication_repository.dart';

abstract class ValidatePhoneNumberUsecase {
  Future<Either<Failure,void>> call(String phoneNumber);
}

class ValidatePhoneNumberUsecaseImpl extends ValidatePhoneNumberUsecase {
  final AuthenticationRepository _repository;

  ValidatePhoneNumberUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call(String phoneNumber) async{
    
     /*
    Esta expressão regular validará as seguintes formas de números de telefone:

+5511987654321
+55 11987654321
+55 (11)987654321
+55 (11) 987654321
+55 11 9876-5432
11987654321
11 987654321
(11)987654321
(11) 987654321
11 9876-5432
     */
    RegExp regex = RegExp(
      r'^(\+55)?\s?\(?\d{2}\)?[\s-]?\d{4,5}[-\s]?\d{4}$',
    );


    if(regex.hasMatch(phoneNumber)){
      return  Left(Failure(message:'Numero invalido!'));
    }
    return await _repository.validatePhoneNumber(phoneNumber);
  }

}