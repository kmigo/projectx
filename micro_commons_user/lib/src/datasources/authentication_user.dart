

import '../domain/entities/kyc.dart';
import '../domain/entities/user.dart';

import '../models/models.dart';


abstract class AuthenticationDatasource {

  Future<void> confirmPhoneNumber(SmsCodeModel sms,[bool update =false]);
  Future<UserVerifyPin> validPincode(String pincode);

  Future<void> signOut();
  Future<UserEntity?> currentUser();
  Future<UserEntity> getUserByUid(String uid);
  Future<List<UserEntity>> searchUser(FilterUser filterUser);
  Future<UserEntity> signIn(SignInModel signInModel);
  Future<void> setPincode(SetPinCodeModel setPincode);
  Future<void> changePincode(String code);
  Future<void> updateUser(UserEntity userEntity);
  Future<void> updateAddress(AddressModel address,String uid);
  Stream<UserEntity> realTimeUser();
  Future<void> refreshToken();
  Stream<WalletEntity> listenWallet();
  Future<UserWithKycEntity> getUserWithKyc();
  Future<void> updateKyc(FormDataModel formData);
  Future<void> verifyPhone(VerifyPhoneModel updatePhoneModel,{bool veryToCreateAccount = false, bool verifyToLogin= false});
  Future<void> updatePhone(SmsCodeModel sms);

}