


import 'package:micro_core/micro_core.dart';

import '../../repository/authentication_repository.dart';
import '../entities/kyc.dart';

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