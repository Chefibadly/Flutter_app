import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/user_repo.dart';

part 'card_info_event.dart';
part 'card_info_state.dart';

//card info bloc
class CardInfoBloc extends Bloc<CardInfoEvent, CardInfoState> {
  UserRepository repo;
  CardInfoBloc(this.repo) : super(CardInfoInitialState()) {
    on<StartEvent>(_onStart);
    on<ConfirmBuyCardPressed>(_onBuy);
  }

  void _onStart(StartEvent event, Emitter<CardInfoState> emit) async {
    emit(
      CardInfoLoadingState(),
    );
    var pref = await SharedPreferences.getInstance();
    try {
      // get the current logged in user id
      var userId = pref.get("userId");
      // retreive the the user wallet
      var wallet = await repo.getUserWallet(id: userId.toString());
      //print(wallet[0]['balance']);

      emit(CardInfoLoadedState(balance: wallet[0]['balance']));
    } catch (e) {
      emit(CardInfoErrState(message: e.toString()));
    }
  }

  void _onBuy(ConfirmBuyCardPressed event, Emitter<CardInfoState> emit) async {
    emit(CardInfoLoadingState());

    var pref = await SharedPreferences.getInstance();

    try {
      // get the current logged in user id
      var userId = pref.get("userId");
      // retreive the the user wallet
      var wallet = await repo.getUserWallet(id: userId.toString());
      // newAmount contains the new balance for this card
      var newAmount = event.amount + wallet[0]['balance'];
      var isSucc = await repo.updateWallet(
          id: userId.toString(), amount: int.parse(newAmount.toString()));
      //print();

      var updatedWallet = await repo.getUserWallet(id: userId.toString());
      // by emitting the new state with the new balance we can update the interface later
      emit(CardInfoLoadedState(balance: updatedWallet[0]['balance']));
    } catch (e) {
      emit(CardInfoErrState(message: e.toString()));
    }
  }
}
