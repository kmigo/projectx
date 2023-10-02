



import 'package:micro_core/micro_core.dart';

class ReportModel extends Equatable {
  final String type;
  final String description;
  const ReportModel({
    required this.type,
    required this.description,
  });
  
  @override

  List<Object?> get props => [type,description];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'description': description,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      type: map['type'] as String,
      description: map['description'] as String,
    );
  }


}
