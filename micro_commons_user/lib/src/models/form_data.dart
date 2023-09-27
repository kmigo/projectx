// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:micro_core/micro_core.dart';

class FormDataModel extends Equatable {
    final Map<String,dynamic> data;

    final List<MultiTypeFile>? files;
    final int level;
    const FormDataModel({
         this.data = const {},

        required this.level,
        this.files
    });

    formData(){
      var formData = CustomFormData.fromMap(data ,bytes: files);
      return formData;
    }

    @override
  List<Object?> get props => [data,files,level];

  FormDataModel copyWith({
     Map<String,dynamic>? data,
    List<MultiTypeFile>? files,
    int? level,
  }) {
    return FormDataModel(
      data: data ?? this.data,
      level: level ?? this.level,
    );
  }
}
