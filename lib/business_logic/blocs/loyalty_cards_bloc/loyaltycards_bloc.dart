import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/business_logic/models/loyalty_card.dart';
import 'package:mobile/business_logic/repository/loyalty_cards_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'loyaltycards_event.dart';
part 'loyaltycards_state.dart';

class LoyaltycardsBloc extends Bloc<LoyaltycardsEvent, LoyaltyCardsState> {
  LoyaltyCardsRepository repo;
  LoyaltycardsBloc(this.repo) : super(LoyaltyCardsLoadingState()) {
    on<StartEvent>(_onStart);
  }

  void _onStart(StartEvent event, Emitter<LoyaltyCardsState> emit) async {
    emit(
      LoyaltyCardsLoadingState(),
    );
    var pref = await SharedPreferences.getInstance();
    try {
      var user = pref.get("userId");
      print(user.toString() + 'heeere 1');
      var loyaltyCards =
          await repo.getAllLoyaltyCardsByIdUser(id: user.toString());
      print(loyaltyCards);
      emit(LoyaltyCardsLoadedState(loyaltyCards: loyaltyCards));
    } catch (e) {
      emit(LoyaltyCardsErrState(message: e.toString()));
    }
  }
}
