

import 'package:flutter/foundation.dart';

class Failure implements Exception  {
  final String? message;
  final Object? e;
   Failure({this.message, this.e}){
     const color = '\x1B[6;30;31m';
     if(e!= null){
      debugPrint('$color Failure: $e \x1B[0m');
     }
     if(message != null){
      debugPrint('$color Failure: $message \x1B[0m');
     }
    
  }
  @override
  String toString() {
    return message ?? 'Failure';
  }
}

class ErrorUserWithoutAccount extends Failure {
  ErrorUserWithoutAccount({super.message});
}

class UserNotFound extends Failure {
  UserNotFound({super.message});
}
class FailureRequest extends Failure {
  final int statusCodeValue;
  final dynamic dataValue;
  final String pathValue;
  FailureRequest({required String fallBackMessage, int statusCode =500,dynamic data, String path =''}) : statusCodeValue = statusCode, pathValue = path,dataValue = data ,super(message: _errorMessage(statusCode, data, fallBackMessage,path));

  static String _errorMessage(int statusCode, dynamic data,String fallBackMessage,String path){
    if(data['message'] == 'level 1 already processed or not found.'){
      return 'Suas informações já foram validadas. Caso tenha alguma dúvida, entre em contato com o suporte técnico.';
    }
    if(data['message'] == 'Unauthorized'){
      return 'Você não tem permissão para realizar essa ação.';
    }
    if(data['code'] == '007'){
      return 'Você ainda tem informações para ser validada no seu perfil. Por favor, acesse o aplicativo e valide suas informações.';
    }
    return  fallBackMessage;
  }
}

class ErrorFavoriteUserAlreadyExists extends Failure {
  ErrorFavoriteUserAlreadyExists({super.message});
}

class FailureConnection extends Failure {
  FailureConnection({super.message});
}

final genericError = Failure(
    message:
        'Desculpe, ocorreu um erro inesperado. Por favor, tente novamente. Se o problema persistir, entre em contato com o suporte técnico.');


