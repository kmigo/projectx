

import 'package:micro_core/micro_core.dart';
part '../../dto/currency.dart';
class CurrencyEntity extends Equatable {
  final String currency;
  final num value;
  const CurrencyEntity({
    required this.currency,
    required this.value,
  });
  
  @override
  List<Object?> get props => [currency,value];
  
}
