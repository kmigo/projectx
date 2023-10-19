part of 'bloc.dart';


enum GetCurrencyStatus { idle, loading, success, error }

class GetCurrencyState extends Equatable {
  final GetCurrencyStatus status;
  final CurrencyEntity? currency;
  final Failure? failure;
  const GetCurrencyState({
    required this.status,
    this.currency,
    this.failure,
  });

  @override
  List<Object?> get props => [status, currency, failure];

  GetCurrencyState copyWith({
    GetCurrencyStatus? status,
    CurrencyEntity? currency,
    Failure? failure,
  }) {
    return GetCurrencyState(
      status: status ?? this.status,
      currency: currency ?? this.currency,
      failure: failure ?? this.failure,
    );
  }
}