import 'dart:convert';
import 'dart:developer';
import 'package:encrypt/encrypt.dart';

/// المفتاح لازم يكون 16 أو 24 أو 32 بايت (AES-128, AES-192, AES-256)
/// يعني هون 32 بايت = AES-256
const _secretKey = "1234123412341234";

/// لازم يكون IV بطول 16 بايت
const _ivString = "1234567890abcdef";

String encryptAES(Map<String, dynamic> data) {
  final plainText = jsonEncode(data);

  final key = Key.fromUtf8(_secretKey);
  final iv = IV.fromUtf8(_ivString);

  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

  final encrypted = encrypter.encrypt(plainText, iv: iv);

  log("Plain: $plainText");
  log("Encrypted (base64): ${encrypted.base64}");

  return encrypted.base64;
}

Map<String, dynamic> decryptAES(String encryptedBase64) {
  final key = Key.fromUtf8(_secretKey);
  final iv = IV.fromUtf8(_ivString);

  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

  final decrypted = encrypter.decrypt64(encryptedBase64, iv: iv);

  log("Decrypted: $decrypted");

  return jsonDecode(decrypted) as Map<String, dynamic>;
}
