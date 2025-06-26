import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();

  Future<void> saveKeyPair(String publicKey, String secretKey) async {
    await _storage.write(key: publicKey, value: secretKey);
  }

  Future<String?> getSecretKey(String publicKey) async {
    return await _storage.read(key: publicKey);
  }
}