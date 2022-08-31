part of 'qrcode_bloc.dart';

abstract class QrcodeEvent extends Equatable {
  const QrcodeEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends QrcodeEvent {}

class QrCodeScannedEvent extends QrcodeEvent {
  final String? code;
  final String idLoyaltyCard;

  const QrCodeScannedEvent(this.idLoyaltyCard, {required this.code});
}
