

import 'dart:async';


import 'package:micro_core/micro_core.dart';
import 'dart:developer' as dev;
import '../../micro_commons_user.dart';
import '../datasources/authentication_user.dart';
import '../domain/entities/kyc.dart';
import '../domain/entities/user.dart';


import 'authentication_repository.dart';

class AutheticationRepositoryImpl extends AuthenticationRepository {
  AutheticationRepositoryImpl(this._datasource);
  UserEntity? _user;
  final _controller = StreamController<AuthenticationStatus>();
  final AuthenticationDatasource _datasource;
  StreamSubscription<UserEntity>? _streamSubscription;
  StreamSubscription<WalletEntity>? _streamSubscriptionWallet;

  @override
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 2));
    yield const AuthenticationStatus(null, StatusAuthentication.unknow);
    yield* _controller.stream;
  }

  @override
  Future<Either<Failure, void>> confirmPhone(SmsCodeModel code) async {
    try {
      final user = await _datasource.confirmPhoneNumber(code);
      return Right(user);
    } on Failure catch (e) {
      dev.log(e.toString(),
          name: '$constantsLogFailure - confirmPhone ',
          time: DateTime.now());
      return Left(e);
    } on FirebaseAuthException catch (e) {
      dev.log(e.toString(),
          name: '$constantsLogErrorFirebaseAuth - confirmPhone ',
          time: DateTime.now(),
          error: e);
      _streamSubscription?.cancel();
      _streamSubscriptionWallet?.cancel();
      final message = _getFirebaseAuthErrorMessage(e.code);
      return Left(Failure(message: message));
    } catch (e) {
      dev.log(e.toString(),
          name: '$constantsLogException - confirmPhone ',
          time: DateTime.now());
      return  Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    try {
      final result = await _datasource.currentUser();

      _user = result;
      if (result == null) {

        _streamSubscription?.cancel();
        _streamSubscriptionWallet?.cancel();
        _controller.add(AuthenticationStatus(
            result, StatusAuthentication.unauthentication));
        return  Left(Failure());
      } else {
        _listenUser();
        _controller.add(
            AuthenticationStatus(result, StatusAuthentication.authentication));
      }

      return Right(result);
    } on Failure catch (e) {
      _streamSubscription?.cancel();
      _streamSubscriptionWallet?.cancel();
      _controller
          .add(const AuthenticationStatus(null, StatusAuthentication.error));
      return Left(e);
    } catch (e) {
      _streamSubscription?.cancel();
      _streamSubscriptionWallet?.cancel();
      _controller
          .add(const AuthenticationStatus(null, StatusAuthentication.error));
      return  Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  @override
  Future<Either<Failure, void>> refreshToken() async {
    try {
      return Right(await _datasource.refreshToken());
    } catch (e) {
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      _user = null;
      _streamSubscription?.cancel();
      _streamSubscriptionWallet?.cancel();
      final result = await _datasource.signOut();
      _controller
          .add(const AuthenticationStatus(null, StatusAuthentication.signOut));
      return Right(result);
    } on Failure catch (e) {
      _streamSubscription?.cancel();
      _streamSubscriptionWallet?.cancel();
      _controller
          .add(const AuthenticationStatus(null, StatusAuthentication.error));
      return Left(e);
    } catch (e) {
      _streamSubscription?.cancel();
      _streamSubscriptionWallet?.cancel();
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(
      SignUpModel signUpModel) async {
    try {
      final result = await _datasource.signUp(signUpModel);
      _user = result;
      _controller
          .add(AuthenticationStatus(result, StatusAuthentication.signup));

      _listenUser();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      _streamSubscription?.cancel();
      _streamSubscriptionWallet?.cancel();
      final message = _getFirebaseAuthErrorMessage(e.code);
      final idref = FirebaseDatabase.instance.ref('errors').push();
      idref.set({
        'event': 'signUp-error-firebase',
        'data': signUpModel.toMap(),
        'error': e.toString(),
        'message': message
      });


      return Left(Failure(message: e.toString()));
    } on Failure catch (e) {
      _streamSubscription?.cancel();
      _streamSubscriptionWallet?.cancel();
      return Left(e);
    } catch (e) {
      _streamSubscription?.cancel();
      _streamSubscriptionWallet?.cancel();
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  _listenUser() {
    _streamSubscription?.cancel();
    _streamSubscriptionWallet?.cancel();
    final userStream = _datasource.realTimeUser();
    _streamSubscription = userStream.listen((event) {
      _user = event.copyWith(balance: _user?.balance);
      _controller.add(
          AuthenticationStatus( _user, StatusAuthentication.authentication));
    });
    _streamSubscriptionWallet = _datasource.listenWallet().listen((event) {
     _user = _user?.copyWith(
            balance:event.brlnxt,
          );
      _controller.add(
          AuthenticationStatus(_user, StatusAuthentication.authentication));
    });
  }

  @override
  Future<Either<Failure, void>> updateUser(UserEntity userEntity) async {
    try {
      final result = await _datasource.updateUser(userEntity);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

 

  String _getFirebaseAuthErrorMessage(String errorCode) {
    dev.log(errorCode,
        name: '$constantsLogErrorFirebaseAuth - code ',
        time: DateTime.now());
    switch (errorCode) {
      case 'email-already-in-use':
        return 'O email já está sendo usado por outra conta.';
      case 'invalid-email':
        return 'O email fornecido é inválido.';
      case 'operation-not-allowed':
        return 'O método de autenticação não está habilitado.';
      case 'weak-password':
        return 'A senha é muito fraca.';
      case 'user-not-found':
        return 'Não há usuário com o email fornecido.';
      case 'user-disabled':
        return 'O usuário foi desativado.';
      case 'wrong-password':
        return 'A senha está incorreta.';
      case 'invalid-phone-number':
        return 'O número de telefone fornecido não é válido.';
      case 'too-many-requests':
        return 'Muitas tentativas de login. Tente novamente mais tarde.';
      case 'invalid-verification-code':
        return 'Codigo inválido!.';
      case 'quota-exceeded':
        return "Cota excedida para atualizar as informações da conta";
      default:
        return 'Ocorreu um erro desconhecido. Por favor tente novamente mais tarde.';
    }
  }

  @override
  Future<Either<Failure, UserVerifyPin>> validPincode(String code) async {
    try {
      return Right(await _datasource.validPincode(code));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  @override
  Future<Either<Failure, void>> changePincode(String code) async {
    try {
      return Right(await _datasource.changePincode(code));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(SignInModel signInModel) async {
    try {
      final result =await _datasource.signIn(signInModel);
      _user=result;
      return Right(_user!);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserByUid(String uid) async {
    try {
      return Right(await _datasource.getUserByUid(uid));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }
  
  @override
  Future<Either<Failure, List<UserEntity>>> searchUser(FilterUser filter)async {
    try{
      return Right(await _datasource.searchUser(filter));
    }on Failure catch(e){
      return Left(e);
    }catch(e){
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
   
  }

  @override
  Future<Either<Failure, UserWithKycEntity>> getUserWithKyc() async{
    try {
      return Right(await _datasource.getUserWithKyc());
    }on Failure catch(e){
      return Left(e);
    }catch(e){
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  @override
  Future<Either<Failure, void>> updateKyc(FormDataModel formData) async {
    try{
      return Right(await _datasource.updateKyc(formData));
    }on Failure catch(e){
      return Left(e);
    }catch(e){
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  @override
  Future<Either<Failure, void>> updateAddress(AddressModel addressModel, String uid) async{
    try{
      return Right(await _datasource.updateAddress(addressModel, uid));
    }on Failure catch(e){
      return Left(e);
    }catch(e){
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  @override
  Future<Either<Failure, void>> updatePhone(SmsCodeModel sms) async{
  try{
      return Right(await _datasource.updatePhone(sms));
    }on FirebaseAuthException catch (e) {
      dev.log(e.toString(),
          name: '$constantsLogErrorFirebaseAuth - verifyPhoneToUpdate ',
          time: DateTime.now(),
          error: e);
      final message = _getFirebaseAuthErrorMessage(e.code);
      return Left(Failure(message: message));
    }on Failure catch(e){
      return Left(e);
    }catch(e){
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
  }
  }

  @override
  Future<Either<Failure, void>> verifyPhone(VerifyPhoneModel updatePhoneModel,{bool checkAccountAlreadyExist = false}) async {
    try{
      return Right(await _datasource.verifyPhone(updatePhoneModel,checkAccountAlreadyExist: checkAccountAlreadyExist));
    } on FirebaseAuthException catch (e) {
      dev.log(e.toString(),
          name: '$constantsLogErrorFirebaseAuth - verifyPhone ',
          time: DateTime.now(),
          error: e);
      final message = _getFirebaseAuthErrorMessage(e.code);
      return Left(Failure(message: message));
    }on Failure catch(e){
      return Left(e);
      }catch(e){
       return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
      }
  }
  
 
}
