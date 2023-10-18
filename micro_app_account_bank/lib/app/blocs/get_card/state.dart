// ignore_for_file: public_member_api_docs, sort_constructors_first
part of'bloc.dart';

enum GetCardStatus {idle,loading,success,error}

class GetCardState extends Equatable {
  final GetCardStatus status;
  final CardEntity? card;
  final Failure? failure;
  const GetCardState({
    required this.status,
    this.card,
    this.failure,
  });
  
  @override
  List<Object?> get props => [status,card,failure];

  GetCardState copyWith({
    GetCardStatus? status,
    CardEntity? card,
    Failure? failure,
  }) {
    return GetCardState(
      status: status ?? this.status,
      card: card ?? this.card,
      failure: failure ?? this.failure,
    );
  }
}
