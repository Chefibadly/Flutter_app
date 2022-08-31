// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class StepsScreen extends StatefulWidget {
  const StepsScreen({Key? key}) : super(key: key);

  @override
  State<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  int index = 0;
  var images = [
    'assets/images/Step_1.png',
    'assets/images/Step_2.png',
    'assets/images/Step_3.png'
  ];
  var titles = [
    'Scan QR-Codes',
    'Recieve exclusive rewards',
    'Get rewarded for your loyalty'
  ];
  var descriptions = [
    'To easily get the product or service you desire',
    'Instant rewards right from the convienience of your phone',
    'Because you deserve it as a loyaly patron to businesses'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // ignore: prefer_const_literals_to_create_immutables
                  colors: [
                    Colors.white,
                    Color.fromARGB(31, 176, 176, 176),
                  ],
                  begin: Alignment(0, 0),
                  end: Alignment.bottomRight,
                  //stops: [0.0, 1.0],
                  tileMode: TileMode.decal,
                ),
              )),
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
              Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.width * 0.04),
              child: Image.asset(
                images[index],
                height: 200,
                width: 200,
              ),
            ),
            Container(
              height: 1.0,
              width: 200,
              decoration: BoxDecoration(
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
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.040),
              child: Text(
                titles[index],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 75, 150, 237)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.085,
                  right: MediaQuery.of(context).size.width * 0.085,
                  top: MediaQuery.of(context).size.height * 0.040),
              child: Text(
                descriptions[index],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.only(
                  /*top: MediaQuery.of(context).size.height * 0.15*/),
              width: 125,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        border: null,
                        shape: BoxShape.circle,
                        color: index == 0
                            ? Color.fromARGB(255, 25, 129, 225)
                            : Color.fromARGB(255, 130, 129, 129)),
                  ),
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        border: null,
                        shape: BoxShape.circle,
                        color: index == 1
                            ? Color.fromARGB(255, 25, 129, 225)
                            : Color.fromARGB(255, 130, 129, 129)),
                  ),
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        border: null,
                        shape: BoxShape.circle,
                        color: index == 2
                            ? Color.fromARGB(255, 25, 129, 225)
                            : Color.fromARGB(255, 130, 129, 129)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  bottom: MediaQuery.of(context).size.height * 0.02),
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/home'),
                child: Text(
                  'Skip',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54),
                ),
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 4 * 3,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 25, 129, 225),
                borderRadius: BorderRadius.circular(20.0),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                    offset: Offset(
                      10.0, // Move to right 10  horizontally
                      7.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: TextButton(
                child: Text("Next ",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  if (index == 2) {
                    Navigator.pushNamed(context, '/home');
                    setState(() {
                      index = 0;
                    });
                  } else {
                    setState(() {
                      index = index + 1;
                    });
                  }
                },
                // TODO LATER
              ),
            )
          ])
        ],
      ),
    );
  }
}
