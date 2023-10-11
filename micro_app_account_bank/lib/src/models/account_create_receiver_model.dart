
import 'account_create_model.dart';
import 'package:micro_core/micro_core.dart';

class AccountBankReceiverModel extends Equatable  implements AccountModel{
  final String tagName;
  final String typeBeneficiary;
  final String beneficiaryName;
  final String typeKeyAccountPix;
  final String keyAccountPix;
  const AccountBankReceiverModel({
    required this.tagName,
    required this.typeBeneficiary,
    required this.beneficiaryName,
    required this.typeKeyAccountPix,
    required this.keyAccountPix,
  });

  
  @override
  List<Object?> get props => [tagName,typeBeneficiary, beneficiaryName, typeKeyAccountPix, keyAccountPix];
  
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tagName': tagName,
      'typeBeneficiary': typeBeneficiary,
      'beneficiaryName': beneficiaryName,
      'typeKeyAccountPix': typeKeyAccountPix,
      'keyAccountPix': keyAccountPix,
    };
  }

  factory AccountBankReceiverModel.fromMap(Map<String, dynamic> map) {
    return AccountBankReceiverModel(
      tagName: map['tagName'] as String,
      typeBeneficiary: map['typeBeneficiary'] as String,
      beneficiaryName: map['beneficiaryName'] as String,
      typeKeyAccountPix: map['typeKeyAccountPix'] as String,
      keyAccountPix: map['keyAccountPix'] as String,
    );
  }

}
