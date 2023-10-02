// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'bloc.dart';

enum ExtractStatus { loading, success, failure, idle }

class ExtractState extends Equatable {
  final ExtractStatus status;
  final String? error;
  final List<TransactionEntity> transactions;
  final MyTransactionsQueryArgs? query;
  const ExtractState({
    required this.status,
    this.query,
    this.error,
    required this.transactions,
  });

  @override
  List<Object?> get props => [status, error, transactions];

  const ExtractState.empty()
      : this(status: ExtractStatus.idle, transactions: const []);

  ExtractState loading() => copyWith(status: ExtractStatus.loading);
  ExtractState success(List<TransactionEntity> transactions) =>
      copyWith(status: ExtractStatus.success, transactions: transactions);
  ExtractState failure(String? error) =>
      copyWith(status: ExtractStatus.failure, error: error);
  List<DateTime> months() {
    final monthsDates = transactions
        .map((e) { final date =DateTime.fromMillisecondsSinceEpoch(e.createdAt.toInt());
        return DateTime(date.year,date.month);
        })
        .toSet()
        .toList();
    return monthsDates;
  }

  equalDateByTransaction(DateTime date, TransactionEntity transaction) {
    final transactionDate = DateTime.fromMillisecondsSinceEpoch(
        transaction.createdAt.toInt());
    return transactionDate.month == date.month &&
        transactionDate.year == date.year;
  }

  ExtractState copyWith({
    ExtractStatus? status,
    String? error,
    List<TransactionEntity>? transactions,
  }) {
    return ExtractState(
      status: status ?? this.status,
      error: error,
      transactions: transactions ?? this.transactions,
    );
  }
}
