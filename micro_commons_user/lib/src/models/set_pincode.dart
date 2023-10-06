// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'models.dart';

class SetPinCodeModel extends Equatable {
  final String phone;
  final String pincode;

  const SetPinCodeModel({
    required this.phone,
    required this.pincode,
  });
  
  @override
  List<Object?> get props => [phone, pincode];
  toMap(){
    return {
      'phone': phone,
      'pincode': pincode
    };
  }

  SetPinCodeModel copyWith({
    String? phone,
    String? pincode,
  }) {
    return SetPinCodeModel(
      phone: phone ?? this.phone,
      pincode: pincode ?? this.pincode,
    );
  }
}
