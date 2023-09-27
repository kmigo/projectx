



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

abstract class AuthenticationDatasource {

  Future<void> validatePhoneNumber(String phoneNumber);
  Future<UserEntity> confirmPhoneNumber(String code);
  Future<UserVerifyPin> validPincode(String pincode);
  Future<UserEntity> signUp(UserCreateModel userCreateModel);
  Future<void> signOut();
  Future<UserEntity?> currentUser();
  Future<UserEntity> getUserByUid(String uid);
  Future<List<UserEntity>> searchUser(FilterUser filterUser);
  Future<UserEntity> signIn(SignInModel signInModel);
  Future<void> changePincode(String code);
  Future<void> updateUser(UserEntity userEntity);
  Future<void> updateAddress(AddressModel address,String uid);
  Stream<UserEntity> realTimeUser();
  Future<void> refreshToken();
  Stream<WalletEntity> listenWallet();
  Future<UserWithKycEntity> getUserWithKyc();
  Future<void> updateKyc(FormDataModel formData);
  Future<void> verifyPhoneToUpdate(UpdatePhoneModel updatePhoneModel);
  Future<void> updatePhone(SmsCodeModel sms);

}