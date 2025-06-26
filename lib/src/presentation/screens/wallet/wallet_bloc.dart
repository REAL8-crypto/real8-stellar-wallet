import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real8_stellar_wallet/src/domain/model/wallet.dart'; // Import the new Wallet model

// --- Events ---
abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class FetchWalletDetails extends WalletEvent {}

// --- States ---
abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final Wallet wallet; // Change to Wallet model

  const WalletLoaded(this.wallet);

  @override
  List<Object> get props => [wallet];
}

class WalletError extends WalletState {
  final String message;
  const WalletError(this.message);

  @override
  List<Object> get props => [message];
}

// --- BLoC ---
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<FetchWalletDetails>(_onFetchWalletDetails);
  }

  Future<void> _onFetchWalletDetails(
    FetchWalletDetails event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletLoading());
    try {
      // Simulate fetching wallet details
      await Future.delayed(const Duration(seconds: 1));
      emit(const WalletLoaded(Wallet(publicKey: 'GABC...XYZ', balance: '100.00 XLM'))); // Pass Wallet object
    } catch (e) {
      emit(WalletError('Failed to fetch wallet details: ${e.toString()}'));
    }
  }
}
