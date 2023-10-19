part of'bloc.dart';

enum GetCardStatus {idle,loading,success,updated,error}

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
