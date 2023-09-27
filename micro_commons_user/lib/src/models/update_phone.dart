

import 'package:micro_core/micro_core.dart';

class UpdatePhoneModel extends Equatable {
  final Function(String) verifycodeId;
  final String? phoneNumber;

  const UpdatePhoneModel({
    required this.verifycodeId,
    required this.phoneNumber,

  });
  
  @override
  List<Object?> get props => [

        verifycodeId,
        phoneNumber,];
  
}
