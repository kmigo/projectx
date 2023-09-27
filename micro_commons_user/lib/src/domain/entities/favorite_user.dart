

import 'package:micro_core/micro_core.dart';

part '../../dto/favorite_user.dart';
class FavoriteUserEntity extends Equatable{
  final String uid;
  final String id;
  final String surname;
  const FavoriteUserEntity({
    required this.uid,
    required this.id,
    required this.surname,
  });
  @override
  List<Object?> get props => [uid, surname,id];
 }



