import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/model/trustline.dart';
import '../../../data/repository/trustline_repository.dart';

// --- Events ---
abstract class TrustlineEvent extends Equatable {
  const TrustlineEvent();
  
  @override
  List<Object> get props => [];
}

class LoadTrustlines extends TrustlineEvent {}

class AddTrustline extends TrustlineEvent {
  final String assetCode;
  final String issuer;
  
  const AddTrustline({
    required this.assetCode,
    required this.issuer,
  });
  
  @override
  List<Object> get props => [assetCode, issuer];
}

class RemoveTrustline extends TrustlineEvent {
  final String assetCode;
  final String issuer;
  
  const RemoveTrustline({
    required this.assetCode,
    required this.issuer,
  });
  
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

class TrustlineLoaded extends TrustlineState {
  final List<Trustline> trustlines;
  
  const TrustlineLoaded(this.trustlines);
  
  @override
  List<Object> get props => [trustlines];
}

class TrustlineError extends TrustlineState {
  final String message;
  
  const TrustlineError(this.message);
  
  @override
  List<Object> get props => [message];
}

class TrustlineActionSuccess extends TrustlineState {
  final String message;
  final List<Trustline> trustlines;
  
  const TrustlineActionSuccess(this.message, this.trustlines);
  
  @override
  List<Object> get props => [message, trustlines];
}

// --- BLoC ---
class TrustlineBloc extends Bloc<TrustlineEvent, TrustlineState> {
  final TrustlineRepository trustlineRepository;
  
  TrustlineBloc({required this.trustlineRepository}) : super(TrustlineInitial()) {
    on<LoadTrustlines>(_onLoadTrustlines);
    on<AddTrustline>(_onAddTrustline);
    on<RemoveTrustline>(_onRemoveTrustline);
  }
  
  Future<void> _onLoadTrustlines(
    LoadTrustlines event,
    Emitter<TrustlineState> emit,
  ) async {
    emit(TrustlineLoading());
    
    try {
      final trustlines = await trustlineRepository.getTrustlines();
      emit(TrustlineLoaded(trustlines));
    } catch (e) {
      emit(TrustlineError('Failed to load trustlines: ${e.toString()}'));
    }
  }
  
  Future<void> _onAddTrustline(
    AddTrustline event,
    Emitter<TrustlineState> emit,
  ) async {
    emit(TrustlineLoading());
    
    try {
      if (event.assetCode.isEmpty || event.issuer.isEmpty) {
        emit(const TrustlineError('Asset Code and Issuer cannot be empty.'));
        return;
      }
      
      await trustlineRepository.addTrustline(event.assetCode, event.issuer);
      final trustlines = await trustlineRepository.getTrustlines();
      
      emit(TrustlineActionSuccess(
        'Trustline added for ${event.assetCode}',
        trustlines,
      ));
    } catch (e) {
      emit(TrustlineError('Failed to add trustline: ${e.toString()}'));
    }
  }
  
  Future<void> _onRemoveTrustline(
    RemoveTrustline event,
    Emitter<TrustlineState> emit,
  ) async {
    emit(TrustlineLoading());
    
    try {
      await trustlineRepository.removeTrustline(event.assetCode, event.issuer);
      final trustlines = await trustlineRepository.getTrustlines();
      
      emit(TrustlineActionSuccess(
        'Trustline removed for ${event.assetCode}',
        trustlines,
      ));
    } catch (e) {
      emit(TrustlineError('Failed to remove trustline: ${e.toString()}'));
    }
  }
}