// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

enum ExtractFilterStatus { loading, success, failure, idle,userFound }


class ExtractFilterState extends Equatable {
  final ExtractFilterStatus status;
  final String? error;
  final List<TransactionEntity> transactions;
  final MyTransactionsQueryArgs? query;
  final UserWithKycEntity? userFound;
  const ExtractFilterState({
     this.status = ExtractFilterStatus.idle,
    this.error,
    required this.transactions,
    this.query,
    this.userFound,
  });
  @override
  List<Object?> get props => [userFound,status, error, transactions];

  ExtractFilterState copyWith({
    ExtractFilterStatus? status,
    String? error,
    List<TransactionEntity>? transactions,
    MyTransactionsQueryArgs? query,
    UserWithKycEntity? userFound,
  }) {
    return ExtractFilterState(
      status: status ?? this.status,
      error: error ?? this.error,
      transactions: transactions ?? this.transactions,
      query: query ?? this.query,
      userFound: userFound ?? this.userFound,
    );
  }
}
