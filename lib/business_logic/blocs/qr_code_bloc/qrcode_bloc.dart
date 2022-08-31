import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/business_logic/models/loyalty_card.dart';
import 'package:mobile/business_logic/models/product.dart';

import 'package:mobile/business_logic/repository/loyalty_cards_repo.dart';
import 'package:mobile/business_logic/repository/product_repo.dart';
import 'package:mobile/business_logic/repository/user_repo.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'qrcode_event.dart';
part 'qrcode_state.dart';

class QrcodeBloc extends Bloc<QrcodeEvent, QrcodeState> {
  LoyaltyCardsRepository loyaltyrepo;
  ProductRepository productRepository;
  UserRepository userRepository;
  QrcodeBloc(this.loyaltyrepo, this.productRepository, this.userRepository)
      : super(QrCodeScanning()) {
    on<StartEvent>(_onStart);
    on<QrCodeScannedEvent>(_onQrcodeScanned);
  }

  void _onStart(StartEvent event, Emitter<QrcodeState> emit) {
    emit(
      QrCodeScanning(),
    );
  }

  void _onQrcodeScanned(
      QrCodeScannedEvent event, Emitter<QrcodeState> emit) async {
    try {
      var pref = await SharedPreferences.getInstance();
      var userId = pref.get("userId");
      print(event.code);
      final String idQ = jsonDecode(event.code.toString())["id"];

      final String action = jsonDecode(event.code.toString())["action"];
      if (action == "addL") {
        await loyaltyrepo.addLoyaltyCardByIdUser(
            idProgram: idQ, idUser: pref.getString("userId"));
        emit(QrCodeScannedSucc());
      } else if (action == "addP") {
        LoyaltyCard loyaltyCard = await loyaltyrepo.getLoyaltyCardById(
            id: event.idLoyaltyCard.toString());
        loyaltyCard.reached++;
        if (loyaltyCard.reached == loyaltyCard.checkPoints) {
          loyaltyCard.reached = 0;
          loyaltyCard.rewards.add('30PT Stamp good buy');
        }

        await loyaltyrepo.updateLoyaltyCardById(loyaltyCard: loyaltyCard);
        Product product = await productRepository.getProduct(id: idQ);
        var wallet = await userRepository.getUserWallet(id: userId.toString());
        await userRepository.updateWallet(
            id: userId.toString(),
            amount: wallet[0]['balance'] - product.price);
        emit(QrCodeScannedProductSucc(product: product));
      }
    } catch (e) {
      emit(QrCodeScanningFailed(e.toString()));
    }
  }
}
