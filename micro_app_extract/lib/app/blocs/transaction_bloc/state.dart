// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

enum TransactionStatus {idle,loading,success,error}

class TransactionState extends Equatable {
  final TransactionStatus status;
  final String? error;
  final TransactionEntity? entity;

  const TransactionState({
    this.status = TransactionStatus.idle,
    this.error,
    this.entity,
  });

  const TransactionState.empty() : entity = null, error = null, status = TransactionStatus.idle;
  
  @override
  List<Object?> get props => [status,error,entity];

  loading() => copyWith(status: TransactionStatus.loading);
  success(TransactionEntity entity) => copyWith(status: TransactionStatus.success,entity: entity);
  failure(String? error) => copyWith(status: TransactionStatus.error,error: error);


  TransactionState copyWith({
    TransactionStatus? status,
    String? error,
    TransactionEntity? entity,
  }) {
    return TransactionState(
      status: status ?? this.status,
      error: error ?? this.error,
      entity: entity ?? this.entity,
    );
  }
}
