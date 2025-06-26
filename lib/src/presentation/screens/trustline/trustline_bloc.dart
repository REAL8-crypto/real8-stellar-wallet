// TODO: Implement feature for REAL8 wallet
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// --- Events ---
abstract class TrustlineEvent extends Equatable {
  const TrustlineEvent();

  @override
  List<Object> get props => [];
}

class AddTrustlineEvent extends TrustlineEvent {
  final String assetCode;
  final String issuer;

  const AddTrustlineEvent({required this.assetCode, required this.issuer});

  @override
  List<Object> get props => [assetCode, issuer];
}

// --- States ---
abstract class TrustlineState extends Equatable {
  const TrustlineState();

  @override
  List<Object> get props => [];
}

class TrustlineInitial extends TrustlineState {}

class TrustlineLoading extends TrustlineState {}

class TrustlineSuccess extends TrustlineState {
  final String message;
  TrustlineSuccess(this.message); // Removed const

  @override
  List<Object> get props => [message];
}

class TrustlineError extends TrustlineState {
  final String message;
  const TrustlineError(this.message);

  @override
  List<Object> get props => [message];
}

// --- BLoC ---
class TrustlineBloc extends Bloc<TrustlineEvent, TrustlineState> {
  TrustlineBloc() : super(TrustlineInitial()) {
    on<AddTrustlineEvent>(_onAddTrustline);
  }

  Future<void> _onAddTrustline(
    AddTrustlineEvent event,
    Emitter<TrustlineState> emit,
  ) async {
    emit(TrustlineLoading());
    try {
      // Simulate API call or business logic
      await Future.delayed(const Duration(seconds: 1));
      if (event.assetCode.isEmpty || event.issuer.isEmpty) {
        emit(const TrustlineError('Asset Code and Issuer cannot be empty.'));
      } else {
        emit(TrustlineSuccess('Trustline added for ${event.assetCode} with issuer ${event.issuer}')); // Removed const
      }
    } catch (e) {
      emit(TrustlineError('Failed to add trustline: ${e.toString()}'));
    }
  }
}
