import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/business_logic/repository/loyalty_cards_repo.dart';
import 'package:mobile/business_logic/repository/product_repo.dart';
import 'package:mobile/screens/product_details_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../business_logic/blocs/qr_code_bloc/qrcode_bloc.dart';
import '../business_logic/repository/user_repo.dart';

class QrCodeCameraScreen extends StatefulWidget {
  final String idLoyaltyCard;
  const QrCodeCameraScreen({Key? key, required this.idLoyaltyCard})
      : super(key: key);

  @override
  State<QrCodeCameraScreen> createState() => _QrCodeCameraScreenState();
}

class _QrCodeCameraScreenState extends State<QrCodeCameraScreen> {
  final qrKey = GlobalKey(debugLabel: 'QRCODE');
  Barcode? barcode;
  QRViewController? qrController;
  late QrcodeBloc qrBloc = BlocProvider.of<QrcodeBloc>(context);
  DateTime? lastScan;

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    // TODO: implement reassemble
    super.reassemble();
    if (Platform.isAndroid) {
      await qrController!.pauseCamera();
    }
    qrController!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QrcodeBloc(
          LoyaltyCardsRepository(), ProductRepository(), UserRepository())
        ..add(StartEvent()),
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildQRView(context),
              Positioned(bottom: 10, child: buildResult(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResult(BuildContext context) => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white24,
        ),
        child: BlocBuilder<QrcodeBloc, QrcodeState>(
          builder: (context, state) {
            return BlocListener<QrcodeBloc, QrcodeState>(
              listener: (context, state) {
                // TODO: implement listener
                print(state);
              },
              child: Text(
                barcode != null ? 'Result : ${barcode!.code}' : 'Scan a code!',
                maxLines: 3,
              ),
            );
          },
        ),
      );

  Widget buildQRView(BuildContext context) => Scaffold(
        extendBody: true,
        body: QRView(
          key: qrKey,
          onQRViewCreated: onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.cyan,
            borderRadius: 10,
            borderLength: 20,
            borderWidth: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.8,
          ),
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      qrController = controller;
    });
    controller.scannedDataStream.listen((barcode) => setState(() {
          final currentScan = DateTime.now();
          if (lastScan == null ||
              currentScan.difference(lastScan!) > const Duration(seconds: 1)) {
            lastScan = currentScan;
            print(barcode.code);
            qrBloc.add(
                QrCodeScannedEvent(widget.idLoyaltyCard, code: barcode.code));
            final String action = jsonDecode(barcode.code.toString())["action"];

            if (action == "addP") {
              final String id = jsonDecode(barcode.code.toString())["id"];
              //Navigator.of(context).pop();

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                          productId: id, loyaltyCardId: widget.idLoyaltyCard)));
            } else {
              Navigator.popAndPushNamed(context, "/home");
            }

            //Navigator.pop(context);
            this.barcode = barcode;
          }
        }));
  }
}
