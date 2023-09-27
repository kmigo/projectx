// ignore_for_file: deprecated_member_use_from_same_package, unused_field, depend_on_referenced_packages

import 'dart:developer';

import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

import 'package:flutter/foundation.dart';
import 'package:micro_core/micro_core.dart';

import 'dart:developer' as dev;

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
import 'authentication_user.dart';


class AuthenticationDatasourceImpl extends AuthenticationDatasource {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance;

  UserCredential? _credential;
  ConfirmationResult? _confirmationResult;
  final ClientHttp _clientHttp;
  AuthenticationDatasourceImpl(this._clientHttp) {
    if (!kIsWeb) {
      _db.setPersistenceEnabled(true);
      _db.setPersistenceCacheSizeBytes(10000000);
    }
  }

  @override
  Future<UserEntity?> currentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final userJson = await _db.ref(constantsUser).child(user.uid).get();
    return UserDTO.fromMap((userJson.value as Map<String, dynamic>)..['id'] = user.uid);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> updateUser(UserEntity userEntity) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw  Failure(message: 'Não existe usuario logado');
    }
    final doc = await _db.ref(constantsUser).child(user.uid).get();
    if (!doc.exists) {
      throw ErrorUserWithoutAccount(
          message: 'Usuário ainda não tem conta criada.');
    }
    await _db.ref(constantsUser).child(userEntity.id).set(userEntity.toMap());
  }

  @override
  Stream<UserEntity> realTimeUser() {
    final user = _auth.currentUser;
    final id = user?.uid;
    return _db
        .ref()
        .child(constantsUser)
        .child(id!)
        .onValue
        .map<UserEntity>((event) =>
            UserDTO.fromMap(event.snapshot.value as Map<String, dynamic>..['id']=event.snapshot.key))
        .asBroadcastStream();
  }

  @override
  Future<UserEntity> signUp(UserCreateModel userCreateModel) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw  Failure(message: 'Não existe usuario logado');
    }
    final headers = <String, dynamic>{   
          'x-api-key':EnvironmentVariables.getVariable(VarEnvs.xapikey)
    } ;
    final result = await _clientHttp.get(
        '${HttpRoutes.transaction.userAlreadyExists}/${userCreateModel.cpf}',headers:headers );
    if (result.data['result']) {
      throw  Failure(message: 'Usuário já existe');
    }
    await _db.ref(constantsUser).child(user.uid).set(userCreateModel.toMap()
      ..['consumer'] = EnvironmentVariables.getVariable(VarEnvs.consumer));
    return UserDTO.fromMap(userCreateModel.toMap()..['id'] = user.uid);
  }

  @override
  Future<void> validatePhoneNumber(String phoneNumber) async {
    final platform = FirebaseAuthPlatform.instanceFor(
        app: _auth.app, pluginConstants: _auth.pluginConstants);
    _confirmationResult = await _auth.signInWithPhoneNumber(
        phoneNumber,
        RecaptchaVerifier(
            onError: (error) {
              throw error;
            },
            onSuccess: () {
            
            },
            onExpired: () {
              throw  Failure(message: 'Expiração de captcha');
            },
            auth: platform));


  }

  @override
  Future<UserEntity> confirmPhoneNumber(String code) async {
    _credential = await _confirmationResult?.confirm(
      code,
    );
    dev.log('uid: ${_credential?.user?.uid}');
    if (_credential?.user?.uid == null) {
      throw  Failure(message: 'Codigo inválido!.');
    }
    final uid = _credential!.user!.uid;
    final doc = await _db.ref(constantsUser).child(uid).get();
    if (!doc.exists) {
      throw ErrorUserWithoutAccount(
          message: 'Usuário ainda não tem conta criada.');
    }
    final user = UserDTO.fromMap(doc.value as Map<String, dynamic>);
    return user;
  }

  @override
  Future<void> refreshToken() async {
    throw UnimplementedError();
  }

  @override
  Future<UserVerifyPin> validPincode(String pincode) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw  Failure(message: 'Não existe usuario logado');
    }
    final doc = await _db.ref(constantsUser).child(user.uid).get();
    if (!doc.exists) {
      throw ErrorUserWithoutAccount(
          message: 'Usuário ainda não tem conta criada.');
    }
    return UserVerifyPin(
        user: UserDTO.fromMap(doc.value as Map<String, dynamic>),
        password: (doc.value as Map<String, dynamic>)['pincode']);
  }

  @override
  Future<void> changePincode(String code) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw  Failure(message: 'Não existe usuario logado');
    }
    final doc = await _db.ref(constantsUser).child(user.uid).get();
    if (!doc.exists) {
      throw ErrorUserWithoutAccount(
          message: 'Usuário ainda não tem conta criada.');
    }
    await _db.ref(constantsUser).child(user.uid).update({'pincode': code});
  }

  @override
  Future<UserEntity> signIn(SignInModel signInModel) async {
    final queryOne = _db
        .ref(constantsUser)
        .orderByChild('document')
        .equalTo(signInModel.cpf);
    final doc = await queryOne.get();
    if (!doc.exists) {
      throw  Failure(message: 'Usuário não encontrado');
    }
    final user = UserDTO.fromMap(doc.value as Map<String, dynamic>..['id'] = doc.key);
    if (signInModel.password !=
        decrypt(signInModel.password,
            EnvironmentVariables.getVariable(VarEnvs.secret))) {
      throw  Failure(message: 'Senha incorreta');
    }

    return user;
  }

  @override
  Future<UserEntity> getUserByUid(String uid) async {
    final doc = await _db.ref(constantsUser).child(uid).get();
    if (!doc.exists) {
      throw UserNotFound(message: 'Usuário não encontrado.');
    }
    return UserDTO.fromMap(doc.value as Map<String, dynamic>..['id'] = doc.key);
  }

  @override
  Future<List<UserEntity>> searchUser(FilterUser filterUser) async {
    // TODO: passar essa query para o back end, pois vamos colocar roles no realtime database
    final queryOne = _db
        .ref(constantsUser)
        .orderByChild('phone')
        .equalTo(filterUser.phoneNumber);
    final results = <DataSnapshot>[];
    await queryOne.get().then((document) {
      for (var snap in document.children) {
        results.add(snap);
      }
    });

    final users=  results
        .map<UserEntity>(
            (e) => UserDTO.fromMap(e.value as Map<String, dynamic>..['id'] = e.key))
        .toSet()
        .toList();
        log(users.toString());
    return users;
  }
  
  @override
  Stream<WalletEntity> listenWallet() {
    final user = _auth.currentUser;
    final id = user?.uid;
    return _db
        .ref()
        .child(constantsWallet)
        .child(id!)
        .child(constantsAssets)
        .onValue
        .map<WalletEntity>((event) => 
            WalletDTO.fromMap(event.snapshot.value as Map<String, dynamic>))
        .asBroadcastStream();
  }

  @override
  Future<UserWithKycEntity> getUserWithKyc() async {
        final result = await _clientHttp.get(HttpRoutes.user.me );

          return UserWithKycDTO.fromMap(result.data);
        }

  @override
  Future<void> updateKyc(FormDataModel formData) async{
     await _clientHttp.post("${HttpRoutes.user.kyc}/${formData.level}",json: formData.formData());
    return ;
  }

  @override
  Future<void> updateAddress(AddressModel address,String uid) async{
await _clientHttp.put("${HttpRoutes.user.root}/",json: address.toMap());
  }

  @override
  Future<void> verifyPhoneToUpdate(UpdatePhoneModel updatePhoneModel) async{
     FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:"${updatePhoneModel.phoneNumber}",
        timeout: const Duration(minutes: 2),
        verificationCompleted: (credential) async {
          try{
              await (FirebaseAuth.instance.currentUser)?.updatePhoneNumber(credential);
          }on FirebaseAuthException{
            rethrow;
          }
          catch(e){
            throw Failure(message: 'Erro ao atualizar o telefone');
          }
        
          // either this occurs or the user needs to manually enter the SMS code
        },
        verificationFailed: (authFailure){
          dev.log(authFailure.message ?? 'Erro ao validar o telefone',name: 'AuthenticationDatasourceImpl');
          throw authFailure;
        },
        codeSent: (verificationId, [forceResendingToken]) async {
          
            updatePhoneModel.verifycodeId(verificationId);
        },
        codeAutoRetrievalTimeout: (timeOut){});
    
  }
  
  @override
  Future<void> updatePhone(SmsCodeModel sms) async{
    try{
      final credential =
            PhoneAuthProvider.credential(verificationId: sms.verificattionId, smsCode: sms.smsCode);
          await (FirebaseAuth.instance.currentUser)?.updatePhoneNumber(credential);
      final currentUser = FirebaseAuth.instance.currentUser;
      await _db.ref().child(constantsUser).child(currentUser!.uid).update({'phone':"+55${sms.phoneNumber}"});
    }on FirebaseAuthException{
      rethrow;
    } catch(e){
      throw Failure(message: 'Erro ao atualizar o telefone');
    }
  }
  }

