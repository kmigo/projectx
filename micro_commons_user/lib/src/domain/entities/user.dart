



import 'package:micro_core/micro_core.dart';
part '../../dto/user.dart';
class WalletEntity extends Equatable {
  final num brlnxt;
  final num eth;
  const WalletEntity({
    required this.brlnxt,
    required this.eth,
  });
  @override
  List<Object?> get props => [brlnxt, eth];
}

class UserEntity extends Equatable {
  final String id;
  final String document;
  final String firstName;
  final String image;
  final String phoneNumber;
  final String birthDay;
  final num balance;
  final String? username;
  final String? email;
  final AddressEntity? address;
  const UserEntity({
    required this.id,
    required this.document,
    required this.firstName,
    required this.image,
    required this.balance,
    required this.phoneNumber,
    required this.birthDay,
    this.address,
    this.username,
    this.email
  });

  static UserEntity empty() =>  const UserEntity(id: '', document: '', firstName: '', image: '', phoneNumber: '', birthDay: '',balance: 0);
  
  @override
  List<Object?> get props => [id,firstName,document, image,birthDay,phoneNumber,balance,address,username,email
  ];


  UserEntity copyWith({
    String? id,
    String? document,
    String? firstName,
    String? image,
    String? birthDay,
    String? phoneNumber,
    num? balance,
    AddressEntity? address,
    String? username,
    String? email
  }) {
    return UserEntity(
      id: id ?? this.id,
      balance: balance ?? this.balance,
      document: document ?? this.document,
      firstName: firstName ?? this.firstName,
      image: image ?? this.image,
      birthDay: birthDay ?? this.birthDay,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      username: username ?? this.username,
      email: email ?? this.email
    );
  }
}

class AddressEntity extends Equatable {
  final String cep;
  final String street;
  final String number;
  final String complement;
  final String district;
  final String city;
  final String state;
  const AddressEntity({
    required this.cep,
    required this.street,
    required this.number,
    required this.complement,
    required this.district,
    required this.city,
    required this.state,
  });

  @override
  List<Object?> get props => [cep,street,number,complement,district,city,state];


}
