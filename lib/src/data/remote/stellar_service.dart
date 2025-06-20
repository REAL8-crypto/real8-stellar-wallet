import 'package:stellar_wallet_flutter_sdk/stellar_wallet_flutter_sdk.dart';

class StellarService {
  final Wallet wallet;

  StellarService() : wallet = Wallet.testNet(); // Use testnet for beta

  Future<StellarAccount> createAccount() async {
    final keyPair = wallet.stellar().generateKeyPair();
    await wallet.horizon().accounts.fundTestNetAccount(keyPair.publicKey);
    return StellarAccount(keyPair: keyPair);
  }

  Future<void> addTrustline(String publicKey, String secretKey, String assetCode, String issuer) async {
    final account = wallet.stellar().account(AccountKeyPair(publicKey: publicKey, secretKey: secretKey));
    final asset = AssetTypeCreditAlphaNum(assetCode, issuer);
    await wallet.horizon().transactions.submit(
      account.changeTrust(asset, limit: "1000000"),
    );
  }

  Future<List<LiquidityPool>> getLiquidityPools(String assetCode, String issuer) async {
    final asset = AssetTypeCreditAlphaNum(assetCode, issuer);
    final pools = await wallet.horizon().liquidityPools.forAsset(asset).execute();
    return pools.records.map((record) => LiquidityPool(
      id: record.id,
      totalShares: record.totalShares,
      // Map other fields
    )).toList();
  }
}