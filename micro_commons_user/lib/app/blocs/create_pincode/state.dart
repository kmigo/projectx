
part of 'bloc.dart';

enum CreatePinCodeStatus { initial, loading, success, error }


class CreatePinCodeState extends Equatable {
  
  final String pinCode;
  final String confirmPinCode;
  final CreatePinCodeStatus status;
  final String? error;
  const CreatePinCodeState({
    this.pinCode = '',
    this.confirmPinCode = '',
    this.error,
    this.status = CreatePinCodeStatus.initial,
  });


  @override
  List<Object?> get props => [pinCode, confirmPinCode, status];


  CreatePinCodeState copyWith({
    String? pinCode,
    String? confirmPinCode,
    String? error,
    CreatePinCodeStatus? status,
  }) {
    return CreatePinCodeState(
      pinCode: pinCode ?? this.pinCode,
      error: error ?? this.error,
      confirmPinCode: confirmPinCode ?? this.confirmPinCode,
      status: status ?? this.status,
    );
  }
}
