import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real8_stellar_wallet/src/domain/model/liquidity_pool.dart'; // Import the new LiquidityPool model

// --- Events ---
abstract class LiquidityPoolEvent extends Equatable {
  const LiquidityPoolEvent();

  @override
  List<Object> get props => [];
}

class FetchLiquidityPools extends LiquidityPoolEvent {}

// --- States ---
abstract class LiquidityPoolState extends Equatable {
  const LiquidityPoolState();

  @override
  List<Object> get props => [];
}

class LiquidityPoolInitial extends LiquidityPoolState {}

class LiquidityPoolLoading extends LiquidityPoolState {}

class LiquidityPoolLoaded extends LiquidityPoolState {
  final List<LiquidityPool> pools; // Change to List<LiquidityPool>

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
  LiquidityPoolBloc() : super(LiquidityPoolInitial()) {
    on<FetchLiquidityPools>(_onFetchLiquidityPools);
  }

  Future<void> _onFetchLiquidityPools(
    FetchLiquidityPools event,
    Emitter<LiquidityPoolState> emit,
  ) async {
    emit(LiquidityPoolLoading());
    try {
      // Simulate fetching liquidity pools
      await Future.delayed(const Duration(seconds: 1));
      emit(const LiquidityPoolLoaded([
        LiquidityPool(id: 'Pool-001', totalShares: '1000'),
        LiquidityPool(id: 'Pool-002', totalShares: '500'),
        LiquidityPool(id: 'Pool-003', totalShares: '2000'),
      ])); // Pass list of LiquidityPool objects
    } catch (e) {
      emit(LiquidityPoolError('Failed to fetch liquidity pools: ${e.toString()}'));
    }
  }
}
