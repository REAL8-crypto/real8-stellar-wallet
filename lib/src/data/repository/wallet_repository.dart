import '../remote/stellar_service.dart';
import '../local/secure_storage.dart';
import '../../domain/model/wallet.dart';

class WalletRepository {
  final StellarService stellarService;
  final SecureStorage secureStorage;

  WalletRepository({
    required this.stellarService,
    required this.secureStorage,
  });

  Future<Wallet?> getWallet() async {
    try {
      final accountId = await secureStorage.getAccountId();
      final secretKey = await secureStorage.getSecretKey();
      final mnemonic = await secureStorage.getMnemonic();

      if (accountId == null || secretKey == null) {
        return null;
      }

      // Mock wallet data for now
      return Wallet(
        accountId: accountId,
        secretKey: secretKey,
        mnemonic: mnemonic,
        xlmBalance: '25.5000000',
        real8Balance: '1000.0000000',
        otherAssets: [],
        trustlines: ['REAL8'],
        sequenceNumber: 1234567890,
      );
    } catch (e) {
      return null;
    }
  }

  Future<Wallet> createWallet(String mnemonic) async {
    // Mock wallet creation
    final accountId = 'GCEXAMPLE${DateTime.now().millisecondsSinceEpoch}';
    final secretKey = 'SEXAMPLE${DateTime.now().millisecondsSinceEpoch}';

    await secureStorage.storeAccountId(accountId);
    await secureStorage.storeSecretKey(secretKey);
    await secureStorage.storeMnemonic(mnemonic);

    return Wallet(
      accountId: accountId,
      secretKey: secretKey,
      mnemonic: mnemonic,
      xlmBalance: '0',
      real8Balance: '0',
      otherAssets: [],
      trustlines: [],
      sequenceNumber: 0,
    );
  }

  Future<Wallet> importWallet(String mnemonic) async {
    // Mock wallet import
    final accountId = 'GIMPORTED${DateTime.now().millisecondsSinceEpoch}';
    final secretKey = 'SIMPORTED${DateTime.now().millisecondsSinceEpoch}';

    await secureStorage.storeAccountId(accountId);
    await secureStorage.storeSecretKey(secretKey);
    await secureStorage.storeMnemonic(mnemonic);

    return Wallet(
      accountId: accountId,
      secretKey: secretKey,
      mnemonic: mnemonic,
      xlmBalance: '10.5000000',
      real8Balance: '500.0000000',
      otherAssets: [],
      trustlines: ['REAL8'],
      sequenceNumber: 987654321,
    );
  }

  Future<Wallet> refreshWallet() async {
    final wallet = await getWallet();
    if (wallet == null) throw Exception('No wallet found');

    // Mock refreshed data
    return wallet.copyWith(
      xlmBalance: '${25.5 + (DateTime.now().millisecond / 1000)}',
      real8Balance: '${1000 + (DateTime.now().millisecond / 100)}',
    );
  }

  Future<void> deleteWallet() async {
    await secureStorage.deleteAll();
  }
}