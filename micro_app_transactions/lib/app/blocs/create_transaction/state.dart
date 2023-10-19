// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

enum CreateTransactionStatus { idle, loading, success, error }

class CreateTransactionState extends Equatable {
  final CreateTransactionStatus status;
  final Failure? failure;
  const CreateTransactionState({
    required this.status,
     this.failure,
  });
  
  @override
  List<Object?> get props => [status, failure];

  CreateTransactionState copyWith({
    CreateTransactionStatus? status,
    Failure? failure,
  }) {
    return CreateTransactionState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
