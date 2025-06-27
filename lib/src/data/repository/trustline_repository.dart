import '../remote/stellar_service.dart';
import '../../domain/model/trustline.dart';

class TrustlineRepository {
  final StellarService stellarService;

  TrustlineRepository({required this.stellarService});

  Future<List<Trustline>> getTrustlines() async {
    // Mock trustlines for now
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      const Trustline(
        assetCode: 'REAL8',
        assetIssuer: 'GBVYYQ7XXRZW6ZCNNCL2X2THNPQ6IM4O47HAA25JTAG7Z3CXJCQ3W4CD',
        limit: '100000000',
        balance: '1000.0000000',
        isAuthorized: true,
      ),
      const Trustline(
        assetCode: 'USDC',
        assetIssuer: 'GA5ZSEJYB37JRC5AVCIA5MOP4RHTM335X2KGX3IHOJAPP5RE34K4KZVN',
        limit: '50000000',
        balance: '250.5000000',
        isAuthorized: true,
      ),
    ];
  }

  Future<void> addTrustline(String assetCode, String issuer) async {
    // Mock adding trustline
    await Future.delayed(const Duration(seconds: 1));
    
    if (assetCode.isEmpty || issuer.isEmpty) {
      throw Exception('Asset Code and Issuer cannot be empty');
    }
    
    // In real implementation, would interact with Stellar network
    print('Added trustline for $assetCode with issuer $issuer');
  }

  Future<void> removeTrustline(String assetCode, String issuer) async {
    // Mock removing trustline
    await Future.delayed(const Duration(seconds: 1));
    
    // In real implementation, would interact with Stellar network
    print('Removed trustline for $assetCode with issuer $issuer');
  }
}