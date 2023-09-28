// ignore_for_file: public_member_api_docs, sort_constructors_first


part of 'models.dart';

class VerifyPhoneModel extends Equatable {
 final ValueChanged<String> verifycodeId;
  final String? phoneNumber;
  final PhoneItemConfigModel? phoneItemConfigModel;

  const  VerifyPhoneModel({
   required this.verifycodeId,
     this.phoneNumber,
     this.phoneItemConfigModel
  });
  
  @override
  List<Object?> get props => [
        phoneItemConfigModel,
       verifycodeId,
        phoneNumber,];
  

  VerifyPhoneModel copyWith({
    ValueChanged<String>? verifycodeId,
    String? phoneNumber,
    PhoneItemConfigModel? phoneItemConfigModel,
  }) {
    return VerifyPhoneModel(
      verifycodeId: verifycodeId ?? this.verifycodeId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneItemConfigModel: phoneItemConfigModel ?? this.phoneItemConfigModel,
    );
  }
}
