import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

String encryptText(String plainText, String keyCode) {
  final key = utf8.encode(keyCode);
  final text = utf8.encode(plainText);
  final hmacSha256 = Hmac(sha256, key);
  final digest = hmacSha256.convert(text);
  final encryptedText = '${hex.encode(digest.bytes)}$plainText';
  return encryptedText;
}
