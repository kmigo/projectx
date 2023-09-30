// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

enum UpdateKycStatus { idle, loading, getKyc, failure,updated }


class UpdateKycState extends Equatable {
  final UpdateKycStatus status;
  final String? message;
  final dynamic data;
  final List<File> files;
  final UserWithKycEntity? userWithKycEntity;
  const UpdateKycState({
    required this.status,
    this.message,
    this.userWithKycEntity,
    this.data,
    this.files = const []
  });


  @override
  List<Object?> get props => [status,message,userWithKycEntity,data,files];

  UpdateKycState copyWith({
    UpdateKycStatus? status,
    String? message,
    UserWithKycEntity? userWithKycEntity,
  }) {
    return UpdateKycState(
      status: status ?? this.status,
      message: message ?? this.message,
      userWithKycEntity: userWithKycEntity ?? this.userWithKycEntity,
    );
  }
}
