import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/model/wallet.dart';
import '../../../domain/model/transaction.dart';
import '../../../data/repository/wallet_repository.dart';
import '../../../util/constants.dart';

// --- Events ---
abstract class WalletEvent extends Equatable {
  const WalletEvent();
  
  @override
  List<Object> get props => [];
}

class LoadWallet extends WalletEvent {}

class RefreshWallet extends WalletEvent {}

class LoadMoreTransactions extends WalletEvent {}

class CreateWallet extends WalletEvent {
  final String mnemonic;
  
  const CreateWallet(this.mnemonic);
  
  @override
  List<Object> get props => [mnemonic];
}

class ImportWallet extends WalletEvent {
  final String mnemonic;
  
  const ImportWallet(this.mnemonic);
  
  @override
  List<Object> get props => [mnemonic];
}

// --- States ---
abstract class WalletState extends Equatable {
  const WalletState();
  
  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {
  final bool isInitialLoad;
  
  const WalletLoading({this.isInitialLoad = true});
  
  @override
  List<Object?> get props => [isInitialLoad];
}

class WalletNotFound extends WalletState {}

class WalletLoaded extends WalletState {
  final Wallet? wallet;
  final List<Transaction> transactions;
  final bool hasMoreTransactions;
  final bool isLoadingMore;
  
  const WalletLoaded({
    this.wallet,
    this.transactions = const [],
    this.hasMoreTransactions = false,
    this.isLoadingMore = false,
  });
  
  @override
  List<Object?> get props => [wallet, transactions, hasMoreTransactions, isLoadingMore];
  
  WalletLoaded copyWith({
    Wallet? wallet,
    List<Transaction>? transactions,
    bool? hasMoreTransactions,
    bool? isLoadingMore,
  }) {
    return WalletLoaded(
      wallet: wallet ?? this.wallet,
      transactions: transactions ?? this.transactions,
      hasMoreTransactions: hasMoreTransactions ?? this.hasMoreTransactions,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class WalletError extends WalletState {
  final String message;
  
  const WalletError(this.message);
  
  @override
  List<Object> get props => [message];
}

class WalletActionSuccess extends WalletState {
  final String message;
  
  const WalletActionSuccess(this.message);
  
  @override
  List<Object> get props => [message];
}

// --- BLoC ---
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;
  
  WalletBloc({required this.walletRepository}) : super(WalletInitial()) {
    on<LoadWallet>(_onLoadWallet);
    on<RefreshWallet>(_onRefreshWallet);
    on<LoadMoreTransactions>(_onLoadMoreTransactions);
    on<CreateWallet>(_onCreateWallet);
    on<ImportWallet>(_onImportWallet);
  }
  
  Future<void> _onLoadWallet(
    LoadWallet event,
    Emitter<WalletState> emit,
  ) async {
    emit(const WalletLoading(isInitialLoad: true));
    
    try {
      final wallet = await walletRepository.getWallet();
      
      if (wallet == null) {
        emit(WalletNotFound());
        return;
      }
      
      // Load recent transactions (mock data for now)
      final transactions = await _getMockTransactions();
      
      emit(WalletLoaded(
        wallet: wallet,
        transactions: transactions,
        hasMoreTransactions: transactions.length >= 5,
      ));
    } catch (e) {
      emit(WalletError('Failed to load wallet: ${e.toString()}'));
    }
  }
  
  Future<void> _onRefreshWallet(
    RefreshWallet event,
    Emitter<WalletState> emit,
  ) async {
    if (state is! WalletLoaded) return;
    
    try {
      final currentState = state as WalletLoaded;
      
      // Refresh wallet data
      final wallet = await walletRepository.refreshWallet();
      final transactions = await _getMockTransactions();
      
      emit(currentState.copyWith(
        wallet: wallet,
        transactions: transactions,
      ));
    } catch (e) {
      emit(WalletError('Failed to refresh wallet: ${e.toString()}'));
    }
  }
  
  Future<void> _onLoadMoreTransactions(
    LoadMoreTransactions event,
    Emitter<WalletState> emit,
  ) async {
    if (state is! WalletLoaded) return;
    
    final currentState = state as WalletLoaded;
    if (currentState.isLoadingMore || !currentState.hasMoreTransactions) return;
    
    emit(currentState.copyWith(isLoadingMore: true));
    
    try {
      // Simulate loading more transactions
      await Future.delayed(const Duration(seconds: 1));
      final moreTransactions = await _getMockTransactions(offset: currentState.transactions.length);
      
      emit(currentState.copyWith(
        transactions: [...currentState.transactions, ...moreTransactions],
        hasMoreTransactions: moreTransactions.isNotEmpty,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }
  
  Future<void> _onCreateWallet(
    CreateWallet event,
    Emitter<WalletState> emit,
  ) async {
    emit(const WalletLoading());
    
    try {
      final wallet = await walletRepository.createWallet(event.mnemonic);
      emit(WalletActionSuccess('Wallet created successfully!'));
      add(LoadWallet());
    } catch (e) {
      emit(WalletError('Failed to create wallet: ${e.toString()}'));
    }
  }
  
  Future<void> _onImportWallet(
    ImportWallet event,
    Emitter<WalletState> emit,
  ) async {
    emit(const WalletLoading());
    
    try {
      final wallet = await walletRepository.importWallet(event.mnemonic);
      emit(WalletActionSuccess('Wallet imported successfully!'));
      add(LoadWallet());
    } catch (e) {
      emit(WalletError('Failed to import wallet: ${e.toString()}'));
    }
  }
  
  // Mock transaction data for testing
  Future<List<Transaction>> _getMockTransactions({int offset = 0}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (offset >= 10) return []; // No more transactions after 10
    
    return [
      Transaction(
        id: 'tx_${offset + 1}',
        hash: 'hash_${offset + 1}',
        type: TransactionType.received,
        amount: '100.0',
        assetCode: 'XLM',
        fromAddress: 'GEXAMPLE${offset + 1}STELLARADDRESS',
        createdAt: DateTime.now().subtract(Duration(days: offset + 1)).toIso8601String(),
        status: 'success',
      ),
      Transaction(
        id: 'tx_${offset + 2}',
        hash: 'hash_${offset + 2}',
        type: TransactionType.sent,
        amount: '50.0',
        assetCode: 'REAL8',
        toAddress: 'GEXAMPLE${offset + 2}STELLARADDRESS',
        createdAt: DateTime.now().subtract(Duration(days: offset + 2)).toIso8601String(),
        status: 'success',
      ),
    ];
  }
}