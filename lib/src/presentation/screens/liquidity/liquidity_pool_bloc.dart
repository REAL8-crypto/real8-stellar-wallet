import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/model/liquidity_pool.dart';
import '../../../data/repository/liquidity_pool_repository.dart';

// --- Events ---
abstract class LiquidityPoolEvent extends Equatable {
  const LiquidityPoolEvent();
  
  @override
  List<Object> get props => [];
}

class LoadLiquidityPools extends LiquidityPoolEvent {}

class RefreshLiquidityPools extends LiquidityPoolEvent {}

// --- States ---
abstract class LiquidityPoolState extends Equatable {
  const LiquidityPoolState();
  
  @override
  List<Object> get props => [];
}

class LiquidityPoolInitial extends LiquidityPoolState {}

class LiquidityPoolLoading extends LiquidityPoolState {}

class LiquidityPoolLoaded extends LiquidityPoolState {
  final List<LiquidityPool> pools;
  
  const LiquidityPoolLoaded(this.pools);
  
  @override
  List<Object> get props => [pools];
}

class LiquidityPoolError extends LiquidityPoolState {
  final String message;
  
  const LiquidityPoolError(this.message);
  
  @override
  List<Object> get props => [message];
}

// --- BLoC ---
class LiquidityPoolBloc extends Bloc<LiquidityPoolEvent, LiquidityPoolState> {
  final LiquidityPoolRepository liquidityPoolRepository;
  
  LiquidityPoolBloc({required this.liquidityPoolRepository}) : super(LiquidityPoolInitial()) {
    on<LoadLiquidityPools>(_onLoadLiquidityPools);
    on<RefreshLiquidityPools>(_onRefreshLiquidityPools);
  }
  
  Future<void> _onLoadLiquidityPools(
    LoadLiquidityPools event,
    Emitter<LiquidityPoolState> emit,
  ) async {
    emit(LiquidityPoolLoading());
    
    try {
      final pools = await liquidityPoolRepository.getLiquidityPools();
      emit(LiquidityPoolLoaded(pools));
    } catch (e) {
      emit(LiquidityPoolError('Failed to load liquidity pools: ${e.toString()}'));
    }
  }
  
  Future<void> _onRefreshLiquidityPools(
    RefreshLiquidityPools event,
    Emitter<LiquidityPoolState> emit,
  ) async {
    try {
      final pools = await liquidityPoolRepository.getLiquidityPools();
      emit(LiquidityPoolLoaded(pools));
    } catch (e) {
      emit(LiquidityPoolError('Failed to refresh liquidity pools: ${e.toString()}'));
    }
  }
}