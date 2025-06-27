import 'package:equatable/equatable.dart';

class Trustline extends Equatable {
  final String assetCode;
  final String assetIssuer;
  final String limit;
  final String balance;
  final bool isAuthorized;
  final Map<String, dynamic>? metadata;

  const Trustline({
    required this.assetCode,
    required this.assetIssuer,
    required this.limit,
    this.balance = '0',
    this.isAuthorized = true,
    this.metadata,
  });

  factory Trustline.fromJson(Map<String, dynamic> json) {
    return Trustline(
      assetCode: json['asset_code'] as String,
      assetIssuer: json['asset_issuer'] as String,
      limit: json['limit'] as String,
      balance: json['balance'] as String? ?? '0',
      isAuthorized: json['is_authorized'] as bool? ?? true,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asset_code': assetCode,
      'asset_issuer': assetIssuer,
      'limit': limit,
      'balance': balance,
      'is_authorized': isAuthorized,
      'metadata': metadata,
    };
  }

  double get balanceAsDouble {
    try {
      return double.parse(balance);
    } catch (e) {
      return 0.0;
    }
  }

  double get limitAsDouble {
    try {
      return double.parse(limit);
    } catch (e) {
      return 0.0;
    }
  }

  String get displayIssuer {
    if (assetIssuer.length <= 12) return assetIssuer;
    return '${assetIssuer.substring(0, 6)}...${assetIssuer.substring(assetIssuer.length - 6)}';
  }

  bool get isReal8 => assetCode == 'REAL8';

  Trustline copyWith({
    String? assetCode,
    String? assetIssuer,
    String? limit,
    String? balance,
    bool? isAuthorized,
    Map<String, dynamic>? metadata,
  }) {
    return Trustline(
      assetCode: assetCode ?? this.assetCode,
      assetIssuer: assetIssuer ?? this.assetIssuer,
      limit: limit ?? this.limit,
      balance: balance ?? this.balance,
      isAuthorized: isAuthorized ?? this.isAuthorized,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        assetCode,
        assetIssuer,
        limit,
        balance,
        isAuthorized,
        metadata,
      ];
}