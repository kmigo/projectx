part of 'bloc.dart';

enum NewCardStatus { loading, success, error, initial }

class NewCardState extends Equatable{
  final NewCardStatus status;
  final String? message;
  final String? cardId;
  const NewCardState({
    this.status = NewCardStatus.initial,
    this.message,
    this.cardId,
  });

  NewCardState copyWith({
    NewCardStatus? status,
    String? message,
    String? cardId,
  }) {
    return NewCardState(
      status: status ?? this.status,
      message: message ?? this.message,
      cardId: cardId ?? this.cardId,
    );
  }

  @override
  List<Object?> get props => [status, message, cardId];
}