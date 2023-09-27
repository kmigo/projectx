// ignore_for_file: public_member_api_docs, sort_constructors_first


part of 'models.dart';
/*
{
  "+55": {
    "mask": "(##) ####-####",
    "hint": "(00) 0000-0000",
    "country": "Brasil",
    "is_active": true,
    "abbreviation": "BRA",
    "img": "https://firebasestorage.googleapis.com/v0/b/project-x-a4278.appspot.com/o/brasil.jpg?alt=media&token=de380590-8d00-4f9f-8d42-be9c9441dab1"
  },
  "+1": {
    "mask": "(###) ###-####",
    "hint": "(000) 000-00000",
    "is_activate": false,
    "country": "",
    "abbreviation": "CAN",
    "img": "https://firebasestorage.googleapis.com/v0/b/project-x-a4278.appspot.com/o/canada.jpg?alt=media&token=e6a8af48-b4c2-4daa-957b-476e54ecb89e"
  }
}
*/

class PhoneItemsConfigModel extends Equatable {
  final List<PhoneItemConfigModel> phones;
  const PhoneItemsConfigModel({
    required this.phones,
  });
  
  @override
  List<Object?> get props => [phones];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phones': phones.map((x) => x.toMap()).toList(),
    };
  }

  factory PhoneItemsConfigModel.fromMap(Map<String, dynamic> data) {
    return PhoneItemsConfigModel(
      phones: data.keys.map<PhoneItemConfigModel>((e) {
  var tempData = Map<String, dynamic>.from(data[e]);
  tempData['code'] = e;
  return PhoneItemConfigModel.fromMap(tempData);
}).toList(),
    );
  }

}

class PhoneItemConfigModel extends Equatable {
  final String? img;
  final String code;
  final String? mask;
  final String? hint;
  final String? country;
  final bool? isActive;
  final String? abbreviation;
  const PhoneItemConfigModel({
    this.img,
    required this.code,
    this.mask,
    this.hint,
    this.country,
    this.isActive,
    this.abbreviation,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'img': img,
      'code': code,
      'mask': mask,
      'hint': hint,
      'country': country,
      'isActive': isActive,
      'abbreviation': abbreviation,
    };
  }

  factory PhoneItemConfigModel.fromMap(Map<String, dynamic> map) {
    return PhoneItemConfigModel(
      img: map['img'] != null ? map['img'] as String : null,
      code: map['code'] as String,
      mask: map['mask'] != null ? map['mask'] as String : null,
      hint: map['hint'] != null ? map['hint'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      abbreviation: map['abbreviation'] != null ? map['abbreviation'] as String : null,
    );
  }

  @override
  bool get stringify => true;
  
  @override
  List<Object?> get props =>[img,code,mask,hint,country,isActive,abbreviation];
}
