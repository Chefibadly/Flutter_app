part of 'reward_bloc.dart';

abstract class RewardState extends Equatable {
  const RewardState();

  @override
  List<Object> get props => [];
}

class RewardInitialState extends RewardState {}

class RewardLoadingState extends RewardState {}

class RewardLoadedStateReached extends RewardState {
  final LoyaltyCard loyaltyCard;

  const RewardLoadedStateReached({required this.loyaltyCard});
  @override
  List<Object> get props => [loyaltyCard];
}

class CardDeletedState extends RewardState {}

class RewardLoadedState extends RewardState {
  final LoyaltyCard loyaltyCard;

  const RewardLoadedState({required this.loyaltyCard});
  @override
  List<Object> get props => [loyaltyCard];
}

class RewardErrState extends RewardState {
  final message;

  const RewardErrState({required this.message});
}
