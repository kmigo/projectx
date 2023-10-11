// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:micro_core/micro_core.dart';
part '../../dto/account_bank_receiver.dart';
class AccountBankReceiverEntity extends Equatable {
  final String tagName;
  final String typeBeneficiary;
  final String beneficiaryName;
  final String typeKeyAccountPix;
  final String keyAccountPix;
  final String id;

  const AccountBankReceiverEntity({
    required this.tagName,
    required this.id,
    required this.typeBeneficiary,
    required this.beneficiaryName,
    required this.typeKeyAccountPix,
    required this.keyAccountPix,
  });

  @override
  List<Object?> get props => [tagName, id,typeBeneficiary, beneficiaryName, typeKeyAccountPix, keyAccountPix];

}
