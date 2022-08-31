import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/business_logic/models/loyalty_card.dart';
import 'package:mobile/business_logic/repository/loyalty_cards_repo.dart';
import 'package:mobile/business_logic/repository/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'reward_event.dart';
part 'reward_state.dart';

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  LoyaltyCardsRepository loyaltyRepo;
  UserRepository userRepo;
  RewardBloc(this.loyaltyRepo, this.userRepo) : super(RewardInitialState()) {
    on<StartEvent>(_onStart);
    on<RewardIconPressed>(_onRewardIconPressed);
    on<ConfirmDeleteButtonPressed>(_onDeleteCard);
  }

  void _onDeleteCard(
      ConfirmDeleteButtonPressed event, Emitter<RewardState> emit) async {
    emit(RewardLoadingState());

    try {
      bool isSucc =
          await loyaltyRepo.deleteLoyaltyCardById(id: event.idLoyaltyCard);

      emit(CardDeletedState());
    } catch (e) {
      emit(RewardErrState(message: e.toString()));
    }
  }

  void _onRewardIconPressed(
      RewardIconPressed event, Emitter<RewardState> emit) async {
    emit(RewardLoadingState());

    var pref = await SharedPreferences.getInstance();

    var userId = pref.get("userId");

    try {
      var userId = pref.get("userId");
      var wallet = await userRepo.getUserWallet(id: userId.toString());

      await userRepo.updateWallet(
          id: userId.toString(), amount: wallet[0]['balance'] + 30);
      LoyaltyCard loyaltyCard =
          await loyaltyRepo.getLoyaltyCardById(id: event.idLoyaltyCard);
      loyaltyCard.rewards.removeAt(0);
      await loyaltyRepo.updateLoyaltyCardById(loyaltyCard: loyaltyCard);
      LoyaltyCard loyaltyCardupdated =
          await loyaltyRepo.getLoyaltyCardById(id: event.idLoyaltyCard);
      emit(RewardLoadedState(loyaltyCard: loyaltyCardupdated));
    } catch (e) {
      emit(RewardErrState(message: e.toString()));
    }
  }

  void _onStart(StartEvent event, Emitter<RewardState> emit) async {
    emit(RewardLoadingState());

    try {
      print(event.idLoyaltyCard.toString());
      LoyaltyCard loyaltyCard = await loyaltyRepo.getLoyaltyCardById(
          id: event.idLoyaltyCard.toString());
      emit(RewardLoadedState(loyaltyCard: loyaltyCard));
    } catch (e) {
      emit(RewardErrState(message: e.toString()));
    }
  }
}
