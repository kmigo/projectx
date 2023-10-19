part of 'bloc.dart';

enum NewCardStatus { loading, success, error, getItem,update,initial }

class NewCardState extends Equatable{
  final NewCardStatus status;
  final String? message;
  final String? cardId;
  final CardEntity? card;
  const NewCardState({
    this.status = NewCardStatus.initial,
    this.message,
    this.cardId,
    this.card
  });

  NewCardState copyWith({
    NewCardStatus? status,
    String? message,
    String? cardId,
    CardEntity? card
  }) {
    return NewCardState(
      status: status ?? this.status,
      message: message ?? this.message,
      cardId: cardId ?? this.cardId,
      card: card ?? this.card
    );
  }

  @override
  List<Object?> get props => [status, message, cardId,card];
}