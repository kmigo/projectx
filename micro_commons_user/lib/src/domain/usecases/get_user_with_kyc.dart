

part of 'usecases.dart';

abstract class GetUserWithKycUsecase {
  Future<Either<Failure,UserWithKycEntity>> call();
}
class GetUserWithKycImpl extends GetUserWithKycUsecase {
  final AuthenticationRepository authenticationRepository;
  GetUserWithKycImpl(this.authenticationRepository);
  @override
  Future<Either<Failure, UserWithKycEntity>> call() async {
    return await authenticationRepository.getUserWithKyc();
  }
}