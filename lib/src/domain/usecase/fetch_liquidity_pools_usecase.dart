import '../model/liquidity_pool.dart';
import '../../data/repository/liquidity_pool_repository.dart';

class FetchLiquidityPoolsUseCase {
  final LiquidityPoolRepository repository;
  FetchLiquidityPoolsUseCase(this.repository);

  Future<List<LiquidityPool>> execute(String assetCode, String issuer) async {
    return await repository.getLiquidityPools(assetCode, issuer);
  }
}