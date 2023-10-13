// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

enum CardListStatus { idle, loading, success, error }

class CardListState extends Equatable {
  final CardListStatus status;
  final List<CardEntity> cards;
  final Failure? failure;
  const CardListState({
    this.status = CardListStatus.idle,
    this.cards = const [],
    this.failure,
  });
  
  @override
  List<Object?> get props => [status,cards,failure];
  
  CardListState copyWith({
    CardListStatus? status,
    List<CardEntity>? cards,
    Failure? failure,
  }) {
    return CardListState(
      status: status ?? this.status,
      cards: cards ?? this.cards,
      failure: failure ?? this.failure,
    );
  }
}
