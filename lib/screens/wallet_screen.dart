import 'package:flutter/material.dart';
import 'package:mobile/screens/card_info_screen.dart';
import 'package:mobile/screens/loyalty_cards_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int currentPageIndex = 0;
  final screens = [CardInfoScreen(), LoyaltyCardsScreen()];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: currentPageIndex == 0
                        ? Color.fromARGB(255, 25, 129, 225)
                        : Colors.transparent,
                  ),
                  child: TextButton(
                    onPressed: () => setState(() {
                      currentPageIndex = 0;
                    }),
                    child: Text(
                      'Card Info',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: currentPageIndex == 0
                              ? Colors.white
                              : Colors.black54),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: currentPageIndex == 1
                        ? Color.fromARGB(255, 25, 129, 225)
                        : Colors.transparent,
                  ),
                  child: TextButton(
                    onPressed: () => setState(() {
                      currentPageIndex = 1;
                    }),
                    child: Text(
                      'Loyalty cards',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: currentPageIndex == 1
                              ? Colors.white
                              : Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            height: 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color.fromARGB(94, 107, 107, 107),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(80, 56, 56, 56),
                  spreadRadius: 0.3,
                  blurRadius: 3,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
          ),
          Expanded(child: screens[currentPageIndex])
        ],
      ),
    );
  }
}
