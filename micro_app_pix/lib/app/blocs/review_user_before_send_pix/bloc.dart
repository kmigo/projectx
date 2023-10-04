import 'package:micro_core/micro_core.dart';

import '../../../src/domain/entities/validate_key.dart';
import '../../../src/domain/usecases/validate_key.dart';

part 'state.dart';

class ReviewUserBeforeSendPixBloc extends Cubit<ReviewUserBeforeSendPixState> {
    final ValidateKeyUsecase _validateKeyUsecase;
  ReviewUserBeforeSendPixBloc(this._validateKeyUsecase) : super( const ReviewUserBeforeSendPixState());

   fetchKey(String typeKey,String key) async {
    emit(state.loading());
    final result = await _validateKeyUsecase(key, typeKey.toUpperCase());
    result.fold(
      (error) => emit(state.failure(error.message)),
      (validateKeyEntity) => emit(state.success(validateKeyEntity)),
    );
  }
}