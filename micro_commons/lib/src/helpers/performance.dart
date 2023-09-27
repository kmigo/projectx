part of 'helpers.dart';


class CustomHttpMetric {
  final HttpMetric _httpMetric;
  CustomHttpMetric(this._httpMetric);
  putAttribute(String name,String value ){
    _httpMetric.putAttribute(name, value);
  }
  Future<void> start()async{
   await  _httpMetric.start();
  }

  responseContentType(String? value){
    _httpMetric.responseContentType = value;
  }
  httpResponseCode(int? value){
    _httpMetric.httpResponseCode = value;
  }
  responsePayloadSize(int? value){
    _httpMetric.responsePayloadSize = value;
  }

Future<void> stop()async{
   await  _httpMetric.stop();
  }
}

class CustomPerformance {
static final _performance = FirebasePerformance.instance;
  static newHttpMetric(String url,String method,Map<String,dynamic>? queryParameters){
    final metric = _performance.newHttpMetric(addParametersToUrlHelper(url.toString(), queryParameters ?? {}), _methods(method));
    return CustomHttpMetric(metric);
  }



  static HttpMethod _methods(String method){
    switch(method){
      case 'POST':
      return HttpMethod.Post;
      case 'GET':
      return HttpMethod.Get;
      case 'DELETE':
      return HttpMethod.Delete;
      case 'PUT':
      return HttpMethod.Put;
      default:
      throw UnimplementedError();
      
    }
  }
}