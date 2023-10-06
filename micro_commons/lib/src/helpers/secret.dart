

part of 'helpers.dart';


class CryptoHelper {
  static final key = encrypt.Key.fromUtf8(EnvironmentVariables.getVariable(VarEnvs.secret_key));
  static final iv = encrypt.IV.fromUtf8(EnvironmentVariables.getVariable(VarEnvs.secret_iv));

  static String encryptValue(String plainText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static String decryptValue(String cipherText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final decrypted = encrypter.decrypt64(cipherText, iv: iv);
    return decrypted;
  }
}







