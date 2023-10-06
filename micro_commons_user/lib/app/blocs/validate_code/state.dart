// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

enum ValidPinCodeStatus { idle, loading, success, failure }

class ValidPinCodeState extends Equatable {
  final ValidPinCodeStatus status;
  final Failure? failure;
  const ValidPinCodeState({
    required this.status,
    this.failure,
  });
  @override
  List<Object?> get props => [status, failure];


  ValidPinCodeState copyWith({
    ValidPinCodeStatus? status,
    Failure? failure,
  }) {
    return ValidPinCodeState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
