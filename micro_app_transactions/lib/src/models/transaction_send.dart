
class TransactionSend {
  final String cardId;
  final num amount;
  final String description;
  final num quotation;
  const TransactionSend({
    required this.cardId,
    required this.amount,
    required this.description,
    required this.quotation,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'card_id': cardId,
      'amount': amount,
      'description': description,
      'dest_quotation': quotation,
    };
  }

  factory TransactionSend.fromMap(Map<String, dynamic> map) {
    return TransactionSend(
      cardId: map['card_id'] as String,
      amount: map['amount'] as num,
      description: map['description'] as String,
      quotation: map['dest_quotation'] as num,
    );
  }

  }
