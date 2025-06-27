import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const String _accountIdKey = 'account_id';
  static const String _secretKeyKey = 'secret_key';
  static const String _mnemonicKey = 'mnemonic';
  static const String _isSetupKey = 'is_setup';

  Future<void> storeAccountId(String accountId) async {
    await _storage.write(key: _accountIdKey, value: accountId);
  }

  Future<String?> getAccountId() async {
    return await _storage.read(key: _accountIdKey);
  }

  Future<void> storeSecretKey(String secretKey) async {
    await _storage.write(key: _secretKeyKey, value: secretKey);
  }

  Future<String?> getSecretKey() async {
    return await _storage.read(key: _secretKeyKey);
  }

  Future<void> storeMnemonic(String mnemonic) async {
    await _storage.write(key: _mnemonicKey, value: mnemonic);
  }

  Future<String?> getMnemonic() async {
    return await _storage.read(key: _mnemonicKey);
  }

  Future<void> setWalletSetup(bool isSetup) async {
    await _storage.write(key: _isSetupKey, value: isSetup.toString());
  }

  Future<bool> isWalletSetup() async {
    final value = await _storage.read(key: _isSetupKey);
    return value == 'true';
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  Future<Map<String, String>> getAllData() async {
    return await _storage.readAll();
  }
}