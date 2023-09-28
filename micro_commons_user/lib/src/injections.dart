library micro_commons_user;

import 'package:micro_commons_user/src/datasources/favorite_datasource.dart';
import 'package:micro_commons_user/src/datasources/favorite_datasource_impl.dart';

import 'package:micro_commons_user/src/repository/authentication_repository.dart';
import 'package:micro_commons_user/src/repository/favorite_user_repository.dart';
import 'package:micro_commons_user/src/repository/favorite_user_repository_impl.dart';


import '../micro_commons_user.dart';
import '../src/datasources/authentication_user.dart';
import 'package:micro_core/micro_core.dart';

import 'datasources/authentication_user_impl.dart';


import 'repository/authentication_repository_impl.dart';
initializeInjectionsUser(){
  CoreBinding.registerLazySingleton<AuthenticationDatasource>((i) => AuthenticationDatasourceImpl(i()));
  CoreBinding.registerLazySingleton<AuthenticationRepository>((i) => AutheticationRepositoryImpl(i()));
  CoreBinding.registerLazySingleton<FavoriteUserDatasource>((i) => FavoriteUserdatasourceImpl(i()));
  CoreBinding.registerLazySingleton<FavoriteUserRepository>((i) => FavoriteUserRepositoryImpl(i()));
  CoreBinding.registerLazySingleton<AddUserAsFavoriteUsecase>((i) => AddUserAsFavoriteUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<ChangePincodeUsecase>((i) => ChangePincodeUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<ConfirmPhoneUsecase>((i) => ConfirmPhoneUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<CurrentUserUsecase>((i) => CurrentUserUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<FetchFavoriteUsersUsecase>((i) => FetchFavorietsUsersUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<GetUserByUidUsecase>((i) => GetUserByUidUsecaseImpl(i()) );
  CoreBinding.registerLazySingleton<GetUserWithKycImpl>((i) => GetUserWithKycImpl(i()));
  CoreBinding.registerLazySingleton<RefreshTokenUsecase>((i) => RefreshTokenUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<RemoveFavoriteUserUsecase>((i) => RemoveFavoriteUserUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<SignInUsecase>((i) => SignInUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<SignOutUsecase>((i) => SignOutUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<SignUpUsecase>((i) => SignUpUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<UpdateAddressUsecase>((i) => UpdateAddressUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<UpdateFavoriteUserUsecase>((i) => UpdateFavoriteUserUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<UpdateKycUsecase>((i) => UpdateKycUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<UpdateUserUsecase>((i) => UpdateUserUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<ValidPincodeUsecase>((i) => ValidPincodeUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<VerifyPhoneUsecase>((i) => VerifyPhoneUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<VerifySmsCodeUpdatePhoneNumberUsecase>((i) => VerifySmsCodeUpdatePhoneNumberUsecaseImpl(i()));
  CoreBinding.registerLazySingleton<AuthenticationBloc>((i) => AuthenticationBloc(
    controller: i<AuthenticationRepository>().status,
    signOutUsecase: i(),
    currentUserUsecase: i(),
  ));
}