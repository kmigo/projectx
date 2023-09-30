// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

enum AddressStatus { idle, loading, success, error }

class AddressState extends Equatable {
    final AddressStatus status;
    final AddressModel address;
    final Failure? error;

  const AddressState({
    required this.status,
    this.address = const AddressModel(),
    this.error,
  });
  
    

  AddressState copyWith({
    AddressStatus? status,
    AddressModel? address,
    Failure? error,
  }) {
    return AddressState(
      status: status ?? this.status,
      address: address ?? this.address,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, address, error];
}
