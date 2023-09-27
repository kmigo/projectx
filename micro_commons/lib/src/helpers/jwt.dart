part of 'helpers.dart';
bool isTokenExpired(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }

  final payload = parts[1];
  final normalized = base64Url.normalize(payload);
  final resp = utf8.decode(base64Url.decode(normalized));

  final payloadMap = json.decode(resp);
  final exp = payloadMap["exp"] ?? payloadMap["expiresIn"];
  final expiry = DateTime.fromMillisecondsSinceEpoch(0).add(Duration(seconds: exp));
  
  return expiry.isBefore(DateTime.now());
}






