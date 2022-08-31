part of 'card_info_bloc.dart';

abstract class CardInfoEvent extends Equatable {
  const CardInfoEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends CardInfoEvent {}

class ConfirmBuyCardPressed extends CardInfoEvent {
  final int amount;

  const ConfirmBuyCardPressed({required this.amount});
}
