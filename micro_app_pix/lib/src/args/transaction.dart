
import 'package:micro_core/micro_core.dart';

enum MyTransactionsQueryKeys {action,type,status}
enum MyTransactionsQueryOperator {range,bigger,smaller,equal}
enum MyTransactionsQueryType{datetime}
enum MyTransactionsQueryOrder {desc}

class MyTransactionsQueryArgs extends Equatable {
  final MyTransactionsQueryKeys key;
  final MyTransactionsQueryOperator operator;
  final String value;
  final MyTransactionsQueryType type;
  final MyTransactionsQueryOrder order;
  const MyTransactionsQueryArgs({
    required this.key,
    required this.operator,
    required this.value,
    required this.type,
    required this.order,
  });
  @override
  List<Object?> get props =>[key,operator,value,type,order];


  toMap(){
    return {
      'filter_query':{
      'key':key.name,
      'operator':_range(operator),
      'value':value,
      'type':type.name,
      'order':order.name
    }
    };
  }
  _range(MyTransactionsQueryOperator operator){
    switch(operator){
      case MyTransactionsQueryOperator.range:
        return 'range';
      case MyTransactionsQueryOperator.bigger:
        return '>';
      case MyTransactionsQueryOperator.smaller:
        return '<';
      case MyTransactionsQueryOperator.equal:
        return '==';
    }
  }
}
