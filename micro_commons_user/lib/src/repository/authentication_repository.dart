

import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';






enum StatusAuthentication {
  unknow,
  authentication,
  signup,
  signin,
  unauthentication,
  signOut,
  error
}

class AuthenticationStatus  extends Equatable {
  final UserEntity? user;
  final StatusAuthentication status;
  const AuthenticationStatus(this.user, this.status);
  
  @override
  List<Object?> get props => [user,status];
  AuthenticationStatus copyWith({
     UserEntity? user,
   StatusAuthentication? status
  }){
    return AuthenticationStatus(user ?? this.user, status ?? this.status);
  }
  
}


abstract class AuthenticationRepository {

  Future<Either<Failure,void>> setPincode(SetPinCodeModel setPincode);
  Future<Either<Failure,void>> signOut();
  Future<Either<Failure,void>> confirmPhone(SmsCodeModel code,[bool update =false]);
  Future<Either<Failure,UserVerifyPin>> validPincode(String code);
  Future<Either<Failure,UserEntity>> currentUser();
   Future<Either<Failure,void>> changePincode(String code);
   Future<Either<Failure,UserEntity>> getUserByUid(String uid);
   Future<Either<Failure,List<UserEntity>>> searchUser(FilterUser filter);
  Future<Either<Failure,void>> updateUser(UserEntity userEntity);
  Future<Either<Failure,void>> refreshToken();
  Future<Either<Failure,UserEntity>> signIn(SignInModel signInModel);
  Stream<AuthenticationStatus> get status;
  Future<Either<Failure,UserWithKycEntity>> getUserWithKyc();
  Future<Either<Failure,void>> updateKyc(FormDataModel formData);
  Future<Either<Failure,void>> updateAddress(AddressModel addressModel,String uid);
   Future<Either<Failure,void>> verifyPhone(VerifyPhoneModel updatePhoneModel,{bool veryToCreateAccount = false, bool verifyToLogin= false});
Future<Either<Failure,void>> updatePhone(SmsCodeModel sms);
}