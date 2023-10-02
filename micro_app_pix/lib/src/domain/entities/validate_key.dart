

// ignore_for_file: public_member_api_docs, sort_constructors_first
/*
{
    "status": "SUCCESS",
    "owner": {
        "type": "NATURAL_PERSON",
        "documentNumber": "14917234751",
        "name": "Lucas de Souza Ferreira Dinelli"
    },
    "key": "00020126690014br.gov.bcb.pix013675698916-ac39-4745-a3ec-34591cb1e7fa0207QR Code5204922353039865802BR5912We Dev Group6009Balneario610888331025622105171dd400840e3a465686304C4AF"
}
*/ 

import 'package:micro_core/micro_core.dart';
part '../../dtos/validate_key.dart';
class ValidateKeyEntity extends Equatable {
  final String status;
  final OwnerEntity owner;
  final String key;
  const ValidateKeyEntity({
    required this.status,
    required this.owner,
    required this.key,
  });
  
  @override
  List<Object?> get props => [status, owner, key];

 
}

class OwnerEntity extends Equatable {
  final String type;
  final String documentNumber;
  final String name;

  const OwnerEntity({
    required this.type,
    required this.documentNumber,
    required this.name,
  });

  @override
  List<Object> get props => [type, documentNumber, name];

 
} 
