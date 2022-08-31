import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/business_logic/models/user.dart';

import '../business_logic/blocs/Card_info_bloc/card_info_bloc.dart';
import '../business_logic/repository/user_repo.dart';

class CardInfoScreen extends StatefulWidget {
  CardInfoScreen({Key? key}) : super(key: key);

  @override
  State<CardInfoScreen> createState() => _cardInfoScreenState();
}

// ignore: camel_case_types
class _cardInfoScreenState extends State<CardInfoScreen> {
  bool confirmed = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) => CardInfoBloc(UserRepository())..add(StartEvent()),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 95, 178, 224),
                    Color.fromARGB(255, 90, 90, 90),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 1],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.circular(15.0),
                border: null,
                boxShadow: const [
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
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.only(top: 40, bottom: 10),
                          child: BlocBuilder<CardInfoBloc, CardInfoState>(
                            builder: (context, state) {
                              if (state is CardInfoLoadingState) {
                                return CircularProgressIndicator();
                              }
                              if (state is CardInfoLoadedState) {
                                return Text(
                                  state.balance.toString() + ' PT',
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                );
                              } else if (state is CardInfoErrState) {
                                return Text(
                                  state.message.toString(),
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                );
                              } else {
                                return Text('errrr');
                              }
                            },
                          ),
                        ),
                        Center(
                          child: Container(
                            //margin: const EdgeInsets.only(top: 5),
                            height: 0.5,
                            width: 200,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(80, 56, 56, 56),
                                  spreadRadius: 0.5,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            child: const Text(
                              'Available until 20/2/2023',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 25),
                height: 0.5,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(80, 56, 56, 56),
                      spreadRadius: 0.5,
                      blurRadius: 3,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.025),
                child: const Text(
                  'Recharge PT points',
                  style: TextStyle(
                      color: Color.fromARGB(255, 95, 124, 224),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: BlocBuilder<CardInfoBloc, CardInfoState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //shrinkWrap: true,
                        children: <Widget>[
                          buildCardPT(context, 10),
                          buildCardPT(context, 20),
                          buildCardPT(context, 30),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Row(
                    //shrinkWrap: true,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildCardPT(context, 40),
                      buildCardPT(context, 50),
                      buildCardPT(context, 100),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirm(int amount) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => CardInfoBloc(UserRepository()),
            child: AlertDialog(
              title: const Text('Please Confirm'),
              content: Text('Are you sure to buy $amount ?'),
              actions: [
                // The "Yes" button
                BlocBuilder<CardInfoBloc, CardInfoState>(
                  builder: (context, state) {
                    return TextButton(
                        onPressed: () {
                          context
                              .read<CardInfoBloc>()
                              .add(ConfirmBuyCardPressed(amount: amount));
                          Navigator.of(context).popAndPushNamed('/home');
                        },
                        child: const Text('Yes'));
                  },
                ),

                TextButton(
                    onPressed: () {
                      setState(() {
                        confirmed = false;
                      });
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('No'))
              ],
            ),
          );
        });
  }

  InkWell buildCardPT(BuildContext context, int amount) {
    return InkWell(
      onTap: (() {
        _confirm(amount);
      }),
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(15.0),
          border: null,
          boxShadow: const [
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                '$amount PT',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                '$amount DT',
                style: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
