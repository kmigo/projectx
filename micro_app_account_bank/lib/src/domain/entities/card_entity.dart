

import 'package:micro_core/micro_core.dart';
part '../../dto/card.dart';
class CardEntity extends Equatable {
  final String originAccountId;
  final String receiverAccountId;
  final String name;
  final String userId;
  const CardEntity({
    required this.originAccountId,
    required this.receiverAccountId,
    required this.name,
    required this.userId,
  });
  
  @override
  List<Object?> get props => [originAccountId, receiverAccountId, name, userId];




}
