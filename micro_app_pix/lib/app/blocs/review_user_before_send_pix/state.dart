// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

enum ReviewUserBeforeSendPixStatus { idle, loading, success, failure, userFound }

class ReviewUserBeforeSendPixState extends Equatable {
  final ReviewUserBeforeSendPixStatus status;
  final String? error;
  final ValidateKeyEntity? validateKeyEntity;
  final String key;
  const ReviewUserBeforeSendPixState({
     this.status = ReviewUserBeforeSendPixStatus.idle,
    this.error,
    this.validateKeyEntity,
  this.key=''
  });

  const ReviewUserBeforeSendPixState.empty()
      : status = ReviewUserBeforeSendPixStatus.idle,
        error = null,
        key='',
        validateKeyEntity = null;
  @override
  List<Object?> get props => [status, error, validateKeyEntity,key];

  loading()=>copyWith(status: ReviewUserBeforeSendPixStatus.loading);
  success(ValidateKeyEntity validateKeyEntity)=>copyWith(status: ReviewUserBeforeSendPixStatus.success,validateKeyEntity: validateKeyEntity);

  failure(String? error)=>copyWith(status: ReviewUserBeforeSendPixStatus.failure,error: error);
  ReviewUserBeforeSendPixState copyWith({
    ReviewUserBeforeSendPixStatus? status,
    String? error,
    String? key,
    ValidateKeyEntity? validateKeyEntity,
  }) {
    return ReviewUserBeforeSendPixState(
      status: status ?? this.status,
      error: error ?? this.error,
      key: key ?? this.key,
      validateKeyEntity: validateKeyEntity ?? this.validateKeyEntity
    );
  }
}
