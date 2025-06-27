import 'package:equatable/equatable.dart';

class LiquidityPool extends Equatable {
  final String id;
  final String totalShares;
  final List<PoolAsset> assets;
  final double fee;
  final String type;
  final Map<String, dynamic>? metadata;

  const LiquidityPool({
    required this.id,
    required this.totalShares,
    this.assets = const [],
    this.fee = 0.003, // 0.3% default fee
    this.type = 'constant_product',
    this.metadata,
  });

  factory LiquidityPool.fromJson(Map<String, dynamic> json) {
    return LiquidityPool(
      id: json['id'] as String,
      totalShares: json['total_shares'] as String,
      assets: (json['reserves'] as List<dynamic>?)
              ?.map((asset) => PoolAsset.fromJson(asset as Map<String, dynamic>))
              .toList() ??
          [],
      fee: (json['fee_bp'] as num?)?.toDouble() ?? 30, // fee in basis points
      type: json['type'] as String? ?? 'constant_product',
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_shares': totalShares,
      'reserves': assets.map((asset) => asset.toJson()).toList(),
      'fee_bp': fee,
      'type': type,
      'metadata': metadata,
    };
  }

  double get totalSharesAsDouble {
    try {
      return double.parse(totalShares);
    } catch (e) {
      return 0.0;
    }
  }

  double get feePercentage => fee / 10000; // Convert basis points to percentage

  String get displayId {
    if (id.length <= 12) return id;
    return '${id.substring(0, 6)}...${id.substring(id.length - 6)}';
  }

  bool get hasReal8 {
    return assets.any((asset) => asset.assetCode == 'REAL8');
  }

  PoolAsset? get real8Asset {
    try {
      return assets.firstWhere((asset) => asset.assetCode == 'REAL8');
    } catch (e) {
      return null;
    }
  }

  PoolAsset? get xlmAsset {
    try {
      return assets.firstWhere((asset) => asset.assetCode == 'XLM' || asset.isNative);
    } catch (e) {
      return null;
    }
  }

  String get displayName {
    if (assets.length >= 2) {
      return '${assets[0].assetCode}/${assets[1].assetCode}';
    }
    return 'Pool $displayId';
  }

  LiquidityPool copyWith({
    String? id,
    String? totalShares,
    List<PoolAsset>? assets,
    double? fee,
    String? type,
    Map<String, dynamic>? metadata,
  }) {
    return LiquidityPool(
      id: id ?? this.id,
      totalShares: totalShares ?? this.totalShares,
      assets: assets ?? this.assets,
      fee: fee ?? this.fee,
      type: type ?? this.type,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [id, totalShares, assets, fee, type, metadata];
}

class PoolAsset extends Equatable {
  final String assetCode;
  final String? assetIssuer;
  final String amount;
  final bool isNative;

  const PoolAsset({
    required this.assetCode,
    this.assetIssuer,
    required this.amount,
    this.isNative = false,
  });

  factory PoolAsset.fromJson(Map<String, dynamic> json) {
    final assetType = json['asset'] as String?;
    
    if (assetType == 'native') {
      return PoolAsset(
        assetCode: 'XLM',
        amount: json['amount'] as String,
        isNative: true,
      );
    }
    
    // Parse asset string like "REAL8:ISSUER"
    final assetParts = assetType?.split(':') ?? [];
    
    return PoolAsset(
      assetCode: assetParts.isNotEmpty ? assetParts[0] : '',
      assetIssuer: assetParts.length > 1 ? assetParts[1] : null,
      amount: json['amount'] as String,
      isNative: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asset': isNative ? 'native' : '$assetCode:$assetIssuer',
      'amount': amount,
    };
  }

  double get amountAsDouble {
    try {
      return double.parse(amount);
    } catch (e) {
      return 0.0;
    }
  }

  String get displayIssuer {
    if (isNative || assetIssuer == null) return '';
    if (assetIssuer!.length <= 12) return assetIssuer!;
    return '${assetIssuer!.substring(0, 6)}...${assetIssuer!.substring(assetIssuer!.length - 6)}';
  }

  PoolAsset copyWith({
    String? assetCode,
    String? assetIssuer,
    String? amount,
    bool? isNative,
  }) {
    return PoolAsset(
      assetCode: assetCode ?? this.assetCode,
      assetIssuer: assetIssuer ?? this.assetIssuer,
      amount: amount ?? this.amount,
      isNative: isNative ?? this.isNative,
    );
  }

  @override
  List<Object?> get props => [assetCode, assetIssuer, amount, isNative];
}