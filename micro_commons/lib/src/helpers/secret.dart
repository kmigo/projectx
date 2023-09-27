

part of 'helpers.dart';

String encrypted(String password, String secret) {
  final plainText = password;
  final key = encrypt.Key.fromUtf8(secret);
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  return encrypted.base64;
}

decrypt(String password, String secret) {
  final key = encrypt.Key.fromUtf8(secret);
  final iv = encrypt.IV.fromLength(16);

  final encrypter = encrypt.Encrypter(encrypt.AES(key));
  final encryptedPassword = encrypt.Encrypted.fromBase64(
      password); // A senha criptografada que você obteve de Python.

  final decrypted = encrypter.decrypt(encryptedPassword, iv: iv);
  return decrypted;
}






