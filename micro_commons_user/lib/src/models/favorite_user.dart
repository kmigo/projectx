



import 'package:micro_core/micro_core.dart';

class FavoriteUserModel extends Equatable {
  final String surname;
  const FavoriteUserModel({
    required this.surname,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'surname': surname,
    };
  }

  factory FavoriteUserModel.fromMap(Map<String, dynamic> map) {
    return FavoriteUserModel(
      surname: map['surname'] as String,
    );
  }

  @override
  List<Object?> get props => [surname];
}
