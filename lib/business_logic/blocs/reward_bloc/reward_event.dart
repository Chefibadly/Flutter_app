part of 'reward_bloc.dart';

abstract class RewardEvent extends Equatable {
  const RewardEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends RewardEvent {
  final String idLoyaltyCard;

  const StartEvent({required this.idLoyaltyCard});
  @override
  List<Object> get props => [idLoyaltyCard];
}

class RewardIconPressed extends RewardEvent {
  final String idLoyaltyCard;

  const RewardIconPressed({required this.idLoyaltyCard});
}

class ConfirmDeleteButtonPressed extends RewardEvent {
  final String idLoyaltyCard;

  const ConfirmDeleteButtonPressed({required this.idLoyaltyCard});
}
