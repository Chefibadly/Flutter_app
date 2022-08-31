import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/screens/qr_code_camera_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            //Colors.white24,
            Color.fromARGB(255, 238, 238, 238),
          ],
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          stops: [0, 1],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //extendBody: true,
        body: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.2,
                  left: MediaQuery.of(context).size.width * 0.2),
              color: Colors.transparent,
              child: const Text(
                'Tap to scan',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Container(
                //color: Colors.black,
                //width: MediaQuery.of(context).size.width,
                //height: 175,
                margin: EdgeInsets.only(
                    top: 20,
                    right: MediaQuery.of(context).size.width * 0.2,
                    left: MediaQuery.of(context).size.width * 0.2),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QrCodeCameraScreen(
                                  idLoyaltyCard: '1',
                                )));
                  },
                  splashColor: Colors.white10,
                  child: Ink.image(
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                    image: AssetImage('assets/images/QR_Code.png'),
                  ),
                )
                /* Image.asset(
                'assets/images/QR_Code.png',
                height: 250,
                width: 250,
              ), */
                ),
            Container(
              height: 60,
              margin: const EdgeInsets.only(top: 40),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.orange,
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange,
                      //Colors.white24,
                      Colors.orange.shade300,
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    stops: const [0, 1],
                    tileMode: TileMode.clamp,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.shade100,
                      spreadRadius: 0.7,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 8, left: 10),
                          child: const Text(
                            'Your Blanace :',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: const <Widget>[
                              Icon(
                                Icons.account_balance_wallet,
                                size: 20,
                                color: Colors.white,
                              ),
                              Text('1400 PT',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: const Icon(
                        Icons.add_box,
                        size: 40,
                        color: Colors.white,
                      ),
                    )
                  ]),
            ),
            Container(
              height: 1.0,
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: const BoxDecoration(
                color: Color.fromARGB(94, 0, 0, 0),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(64, 56, 56, 56),
                    spreadRadius: 0.5,
                    blurRadius: 3,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
