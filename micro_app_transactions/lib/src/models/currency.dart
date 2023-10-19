import 'package:micro_core/micro_core.dart';

class CurrencyModel extends Equatable {
  final String currencyIn;
  final String currencyOut;
  const CurrencyModel({required this.currencyIn, required this.currencyOut});
  @override
  List<Object?> get props => [currencyIn, currencyOut];
   
   CurrencyModel.fromMap(Map<String, dynamic> map):
      currencyIn= map['currencyIn'] ,
      currencyOut= map['currencyOut'] ;

    Map<String,dynamic>toMap(){
      return {
        'currencyIn':currencyIn,
        'currencyOut':currencyOut,
      };
    }
}