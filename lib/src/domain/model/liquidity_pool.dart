// TODO: Implement feature for REAL8 wallet
import 'package:equatable/equatable.dart';

class LiquidityPool extends Equatable {
  final String id;
  final String totalShares;
  // Add other liquidity pool-related properties as needed

  const LiquidityPool({
    required this.id,
    required this.totalShares,
  });

  @override
  List<Object?> get props => [id, totalShares];
}
