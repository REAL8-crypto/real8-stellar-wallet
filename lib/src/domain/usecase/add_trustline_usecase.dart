import '../model/trustline.dart';
import '../../data/repository/trustline_repository.dart';

class AddTrustlineUseCase {
  final TrustlineRepository repository;
  AddTrustlineUseCase(this.repository);

  Future<void> execute(String publicKey, String secretKey, String assetCode, String issuer) async {
    await repository.addTrustline(publicKey, secretKey, assetCode, issuer);
  }
}