// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:micro_core/micro_core.dart';

class AccountCreateModel extends Equatable {
  final String type;
  final dynamic data;
  final String name;
  final String userId;
  const AccountCreateModel({
    required this.type,
    required this.data,
    required this.name,
    required this.userId,
  });
  
  @override
  List<Object?> get props => [type, data, name, userId];
  
  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'data': data,
      'name': name,
      'userId': userId,
    };
  }

  factory AccountCreateModel.fromMap(Map<String, dynamic> map) {
    return AccountCreateModel(
      type: map['type'] as String,
      data: map['data'] as dynamic,
      name: map['name'] as String,
      userId: map['userId'] as String,
    );
  }


}
