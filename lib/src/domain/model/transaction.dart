import 'package:equatable/equatable.dart';
import '../../util/constants.dart';

class Transaction extends Equatable {
  final String id;
  final String hash;
  final TransactionType type;
  final String? amount;
  final String? assetCode;
  final String? assetIssuer;
  final String? fromAddress;
  final String? toAddress;
  final String? memo;
  final String? memoType;
  final String createdAt;
  final String status;
  final double? fee;
  final Map<String, dynamic>? metadata;

  const Transaction({
    required this.id,
    required this.hash,
    required this.type,
    this.amount,
    this.assetCode,
    this.assetIssuer,
    this.fromAddress,
    this.toAddress,
    this.memo,
    this.memoType,
    required this.createdAt,
    required this.status,
    this.fee,
    this.metadata,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      hash: json['hash'] as String,
      type: _parseTransactionType(json['type'] as String?),
      amount: json['amount'] as String?,
      assetCode: json['asset_code'] as String?,
      assetIssuer: json['asset_issuer'] as String?,
      fromAddress: json['from'] as String?,
      toAddress: json['to'] as String?,
      memo: json['memo'] as String?,
      memoType: json['memo_type'] as String?,
      createdAt: json['created_at'] as String,
      status: json['status'] as String? ?? 'success',
      fee: (json['fee'] as num?)?.toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hash': hash,
      'type': type.name,
      'amount': amount,
      'asset_code': assetCode,
      'asset_issuer': assetIssuer,
      'from': fromAddress,
      'to': toAddress,
      'memo': memo,
      'memo_type': memoType,
      'created_at': createdAt,
      'status': status,
      'fee': fee,
      'metadata': metadata,
    };
  }

  static TransactionType _parseTransactionType(String? typeStr) {
    switch (typeStr?.toLowerCase()) {
      case 'payment':
      case 'sent':
        return TransactionType.sent;
      case 'received':
        return TransactionType.received;
      case 'change_trust':
      case 'trustline_added':
        return TransactionType.trustlineAdded;
      case 'trustline_removed':
        return TransactionType.trustlineRemoved;
      case 'liquidity_pool_deposit':
      case 'liquidity_added':
        return TransactionType.liquidityAdded;
      case 'liquidity_pool_withdraw':
      case 'liquidity_removed':
        return TransactionType.liquidityRemoved;
      default:
        return TransactionType.sent;
    }
  }

  bool get isIncoming => type == TransactionType.received;
  bool get isOutgoing => type == TransactionType.sent;
  bool get isSuccessful => status.toLowerCase() == 'success';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isFailed => status.toLowerCase() == 'failed';

  String get displayAmount {
    if (amount == null) return '';
    try {
      final double amt = double.parse(amount!);
      return formatAmount(amt);
    } catch (e) {
      return amount!;
    }
  }

  String get displayAddress {
    final address = isIncoming ? fromAddress : toAddress;
    if (address == null || address.length <= 12) return address ?? '';
    return '${address.substring(0, 6)}...${address.substring(address.length - 6)}';
  }

  String get displayAsset {
    if (assetCode == null) return 'XLM';
    if (assetCode == AppConstants.nativeAssetCode) return 'XLM';
    return assetCode!;
  }

  DateTime get dateTime {
    try {
      return DateTime.parse(createdAt);
    } catch (e) {
      return DateTime.now();
    }
  }

  static String formatAmount(double amount) {
    if (amount == 0) return '0.00';
    if (amount.abs() < 0.01) return amount.toStringAsFixed(7);
    if (amount.abs() < 1) return amount.toStringAsFixed(4);
    if (amount.abs() < 1000) return amount.toStringAsFixed(2);
    if (amount.abs() < 1000000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    }
    return '${(amount / 1000000).toStringAsFixed(1)}M';
  }

  Transaction copyWith({
    String? id,
    String? hash,
    TransactionType? type,
    String? amount,
    String? assetCode,
    String? assetIssuer,
    String? fromAddress,
    String? toAddress,
    String? memo,
    String? memoType,
    String? createdAt,
    String? status,
    double? fee,
    Map<String, dynamic>? metadata,
  }) {
    return Transaction(
      id: id ?? this.id,
      hash: hash ?? this.hash,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      assetCode: assetCode ?? this.assetCode,
      assetIssuer: assetIssuer ?? this.assetIssuer,
      fromAddress: fromAddress ?? this.fromAddress,
      toAddress: toAddress ?? this.toAddress,
      memo: memo ?? this.memo,
      memoType: memoType ?? this.memoType,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      fee: fee ?? this.fee,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        id,
        hash,
        type,
        amount,
        assetCode,
        assetIssuer,
        fromAddress,
        toAddress,
        memo,
        memoType,
        createdAt,
        status,
        fee,
        metadata,
      ];
}