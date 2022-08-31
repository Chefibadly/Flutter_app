part of 'card_info_bloc.dart';

abstract class CardInfoState extends Equatable {
  const CardInfoState();

  @override
  List<Object> get props => [];
}

class CardInfoInitialState extends CardInfoState {}

class CardInfoLoadingState extends CardInfoState {}

class CardInfoErrState extends CardInfoState {
  final String message;

  const CardInfoErrState({required this.message});
}

class CardInfoLoadedState extends CardInfoState {
  final int balance;

  const CardInfoLoadedState({required this.balance});
  @override
  List<Object> get props => [balance];
}
