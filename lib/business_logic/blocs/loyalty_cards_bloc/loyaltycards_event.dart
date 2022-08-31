part of 'loyaltycards_bloc.dart';

abstract class LoyaltycardsEvent extends Equatable {
  const LoyaltycardsEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends LoyaltycardsEvent {}
