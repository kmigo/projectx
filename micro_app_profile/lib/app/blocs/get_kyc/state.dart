// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'bloc.dart';

enum KycStatus {idle,loading,success,error}

class KycState  extends Equatable{
  final KycStatus status;
  final String? failure;
  final UserWithKycEntity? user;

  const KycState({this.status = KycStatus.idle, this.user,this.failure});
  
  KycState copyWith({
    KycStatus? status,
    String? failure,
    UserWithKycEntity? user,
  }) {
    return KycState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      user: user ?? this.user,
    );
  }
  @override
  List<Object?> get props => [status,failure,user];
}
