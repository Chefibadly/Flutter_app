part of 'loyaltycards_bloc.dart';

abstract class LoyaltyCardsState extends Equatable {
  const LoyaltyCardsState();

  @override
  List<Object> get props => [];
}

class LoyaltyCardsLoadingState extends LoyaltyCardsState {}

class LoyaltyCardsLoadedState extends LoyaltyCardsState {
  final List<LoyaltyCard> loyaltyCards;

  const LoyaltyCardsLoadedState({this.loyaltyCards = const <LoyaltyCard>[]});
  @override
  List<Object> get props => [loyaltyCards];
}

class LoyaltyCardsErrState extends LoyaltyCardsState {
  final String message;
  const LoyaltyCardsErrState({required this.message});
}
