// ignore_for_file: prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile/screens/profile_screen.dart';
import 'package:mobile/screens/qr_code_screen.dart';
import 'package:mobile/screens/wallet_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 1;
  bool showNotif = false;
  //int pressedButtonNo = 0;
  final screens = [
    ProfileScreen(),
    QrCodeScreen(),
    WalletScreen(),
  ];
  final titles = ['Profile', 'Home', 'Wallet'];
  final items = <Widget>[
    Icon(Icons.person, size: 30),
    Icon(Icons.qr_code_outlined, size: 30),
    Icon(Icons.wallet_giftcard, size: 30),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
            title: Text(titles[index]),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {
                  /* void notification(){

                  }
                 
                  showNotif = !showNotif;
                  print(showNotif); */
                },
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ))
            ],
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 25, 129, 225)),
        /* drawer: NavigationDrawer(), */
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Stack(children: [screens[index]]),
        bottomNavigationBar: CurvedNavigationBar(
          index: index,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          //color: Colors.,
          height: 60,
          items: items,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) => setState(() {
            this.index = index;
            //pressedButtonNo = index;
          }),
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {},
        ),
      );
}
