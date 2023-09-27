
class ClientResponse {
  final int status;
  final dynamic data;
  final bool isSuccessfull;
  final dynamic response;

  const ClientResponse(
      {required this.status,
      required this.data,
      required this.isSuccessfull,
      this.response});
}

abstract class ClientHttp {
  Future<ClientResponse> get(String url,
      {Map<String, dynamic>? queryString, Map<String, dynamic>? headers});

  Future<ClientResponse> request(String method, String url,
      {Map<String, dynamic>? queryString,
      Map<String, dynamic>? headers,
      dynamic json});

  Future<ClientResponse> post(String url,
      {Map<String, dynamic>? queryString,
      Map<String, dynamic>? headers,
      dynamic json});

  Future<ClientResponse> put(String url,
      {Map<String, dynamic>? queryString,
      Map<String, dynamic>? headers,
      dynamic json});

  Future<ClientResponse> delete(String url,
      {Map<String, dynamic>? queryString,
      Map<String, dynamic>? headers,
      dynamic json});
}