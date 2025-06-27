import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final String accountId;
  final String secretKey;
  final String? mnemonic;
  final String xlmBalance;
  final String real8Balance;
  final List<Asset> otherAssets;
  final List<String> trustlines;
  final int sequenceNumber;
  final Map<String, dynamic>? metadata;

  const Wallet({
    required this.accountId,
    required this.secretKey,
    this.mnemonic,
    required this.xlmBalance,
    this.real8Balance = '0',
    this.otherAssets = const [],
    this.trustlines = const [],
    this.sequenceNumber = 0,
    this.metadata,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      accountId: json['account_id'] as String,
      secretKey: json['secret_key'] as String,
      mnemonic: json['mnemonic'] as String?,
      xlmBalance: json['xlm_balance'] as String? ?? '0',
      real8Balance: json['real8_balance'] as String? ?? '0',
      otherAssets: (json['other_assets'] as List<dynamic>?)
              ?.map((asset) => Asset.fromJson(asset as Map<String, dynamic>))
              .toList() ??
          [],
      trustlines: (json['trustlines'] as List<dynamic>?)?.cast<String>() ?? [],
      sequenceNumber: json['sequence_number'] as int? ?? 0,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_id': accountId,
      'secret_key': secretKey,
      'mnemonic': mnemonic,
      'xlm_balance': xlmBalance,
      'real8_balance': real8Balance,
      'other_assets': otherAssets.map((asset) => asset.toJson()).toList(),
      'trustlines': trustlines,
      'sequence_number': sequenceNumber,
      'metadata': metadata,
    };
  }

  double get xlmBalanceAsDouble {
    try {
      return double.parse(xlmBalance);
    } catch (e) {
      return 0.0;
    }
  }

  double get real8BalanceAsDouble {
    try {
      return double.parse(real8Balance);
    } catch (e) {
      return 0.0;
    }
  }

  String get shortAccountId {
    if (accountId.length <= 12) return accountId;
    return '${accountId.substring(0, 6)}...${accountId.substring(accountId.length - 6)}';
  }

  bool get hasReal8Trustline {
    return trustlines.any((trustline) => trustline.contains('REAL8'));
  }

  Wallet copyWith({
    String? accountId,
    String? secretKey,
    String? mnemonic,
    String? xlmBalance,
    String? real8Balance,
    List<Asset>? otherAssets,
    List<String>? trustlines,
    int? sequenceNumber,
    Map<String, dynamic>? metadata,
  }) {
    return Wallet(
      accountId: accountId ?? this.accountId,
      secretKey: secretKey ?? this.secretKey,
      mnemonic: mnemonic ?? this.mnemonic,
      xlmBalance: xlmBalance ?? this.xlmBalance,
      real8Balance: real8Balance ?? this.real8Balance,
      otherAssets: otherAssets ?? this.otherAssets,
      trustlines: trustlines ?? this.trustlines,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        accountId,
        secretKey,
        mnemonic,
        xlmBalance,
        real8Balance,
        otherAssets,
        trustlines,
        sequenceNumber,
        metadata,
      ];
}

class Asset extends Equatable {
  final String code;
  final String? name;
  final String? issuer;
  final String balance;
  final bool isNative;
  final Map<String, dynamic>? metadata;

  const Asset({
    required this.code,
    this.name,
    this.issuer,
    required this.balance,
    this.isNative = false,
    this.metadata,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      code: json['asset_code'] as String? ?? json['code'] as String,
      name: json['asset_name'] as String? ?? json['name'] as String?,
      issuer: json['asset_issuer'] as String? ?? json['issuer'] as String?,
      balance: json['balance'] as String,
      isNative: (json['asset_type'] as String?) == 'native' || 
                (json['is_native'] as bool?) == true,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'issuer': issuer,
      'balance': balance,
      'is_native': isNative,
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

  String get displayIssuer {
    if (issuer == null || issuer!.length <= 12) return issuer ?? '';
    return '${issuer!.substring(0, 6)}...${issuer!.substring(issuer!.length - 6)}';
  }

  Asset copyWith({
    String? code,
    String? name,
    String? issuer,
    String? balance,
    bool? isNative,
    Map<String, dynamic>? metadata,
  }) {
    return Asset(
      code: code ?? this.code,
      name: name ?? this.name,
      issuer: issuer ?? this.issuer,
      balance: balance ?? this.balance,
      isNative: isNative ?? this.isNative,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [code, name, issuer, balance, isNative, metadata];
}