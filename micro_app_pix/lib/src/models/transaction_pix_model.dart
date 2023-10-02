

// ignore_for_file: constant_identifier_names

import 'package:micro_core/micro_core.dart';

enum TransactionPixType { QRCODE , KEY}

class TransactionPixModel extends Equatable {
  final double amount;
  final String value;
  final TransactionPixType type;
  const TransactionPixModel({
    required this.amount,
    required this.value,
    required this.type,
  });
  
  @override
  List<Object?> get props =>[amount,value,type];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'value': value,
      'type': type.name,
    };
  }

}
