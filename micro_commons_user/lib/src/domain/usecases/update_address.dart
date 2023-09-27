
import 'package:micro_core/micro_core.dart';

import '../../models/address_model.dart';
import '../../repository/authentication_repository.dart';

abstract class UpdateAddressUsecase {
  Future<Either<Failure,void>> call(AddressModel address,String uid);
}

class UpdateAddressUsecaseImpl extends UpdateAddressUsecase {
  final AuthenticationRepository userRepository;
  UpdateAddressUsecaseImpl(this.userRepository);
  @override
  Future<Either<Failure, void>> call(AddressModel address, String uid) async {
    return await userRepository.updateAddress(address,uid);
  }
}