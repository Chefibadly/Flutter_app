part of 'qrcode_bloc.dart';

abstract class QrcodeState extends Equatable {
  const QrcodeState();

  @override
  List<Object> get props => [];
}

class QrCodeScanning extends QrcodeState {}

class QrCodeScannedSucc extends QrcodeState {}

class QrCodeScannedProductSucc extends QrcodeState {
  final Product product;

  const QrCodeScannedProductSucc({required this.product});
}

class QrCodeScanningFailed extends QrcodeState {
  final String message;

  const QrCodeScanningFailed(this.message);
}
