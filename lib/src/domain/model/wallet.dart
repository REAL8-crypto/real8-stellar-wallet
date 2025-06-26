// TODO: Implement feature for REAL8 wallet
import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final String publicKey;
  final String balance;
  // Add other wallet-related properties as needed

  const Wallet({
    required this.publicKey,
    required this.balance,
  });

  @override
  List<Object?> get props => [publicKey, balance];
}
