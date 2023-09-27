
import 'package:micro_core/micro_core.dart';

import '../domain/entities/kyc.dart';
import '../domain/entities/user.dart';
import '../models/address_model.dart';
import '../models/filter_user.dart';
import '../models/form_data.dart';
import '../models/sign_in.dart';
import '../models/sms_code.dart';
import '../models/update_phone.dart';
import '../models/user_create.dart';
import '../models/user_verify_pin.dart';

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

  Future<Either<Failure,UserEntity>> signUp(UserCreateModel userCreateModel);
  Future<Either<Failure,void>> signOut();
  Future<Either<Failure,UserEntity>> confirmPhone(String code);
  Future<Either<Failure,void>> validatePhoneNumber(String numberPhone);
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
   Future<Either<Failure,void>> verifyPhoneToUpdate(UpdatePhoneModel updatePhoneModel);
Future<Either<Failure,void>> updatePhone(SmsCodeModel sms);
}