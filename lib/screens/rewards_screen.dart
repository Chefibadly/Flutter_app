import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/business_logic/repository/loyalty_cards_repo.dart';
import 'package:mobile/business_logic/repository/user_repo.dart';
import 'package:mobile/screens/all_confetti.dart';
import 'package:mobile/screens/qr_code_camera_screen.dart';

import '../business_logic/blocs/reward_bloc/reward_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RewardsScreen extends StatefulWidget {
  final String idLoyaltyCard;
  const RewardsScreen({Key? key, required this.idLoyaltyCard})
      : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue.shade100,
      body: SingleChildScrollView(
        child: Center(
          child: Stack(children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
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
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: buildCard(context, widget.idLoyaltyCard),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, String idLoyaltyCard) => BlocProvider(
        create: (context) =>
            RewardBloc(LoyaltyCardsRepository(), UserRepository())
              ..add(StartEvent(idLoyaltyCard: idLoyaltyCard)),
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height * 1.40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: const RadialGradient(
              center: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 99, 99, 99),
                Color.fromARGB(224, 0, 0, 0),
              ],
              stops: [0.1, 1],
              radius: 1,
              //stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(10.0),
            border: null,
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
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
            //direction: Axis.horizontal,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://res.cloudinary.com/dotwb03aj/image/upload/v1655632437/test/g8u7trajnax6yscx2ap7.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 2.0,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Sportif',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Membership Stamp Card ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  )),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 2.0,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Stamp Description ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: BlocBuilder<RewardBloc, RewardState>(
                    builder: (context, state) {
                      if (state is RewardLoadingState) {
                        return CircularProgressIndicator();
                      }
                      if (state is RewardLoadedState) {
                        print(state.loyaltyCard.toString());
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state.loyaltyCard.description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        );
                      }
                      if (state is RewardLoadedStateReached) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state.loyaltyCard.description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        );
                      } else {
                        return Text(
                          "error loading try again",
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.white),
                        );
                      }
                    },
                  )),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Stamp Collected ',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  )),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<RewardBloc, RewardState>(
                builder: (context, state) {
                  if (state is RewardLoadedState) {
                    return Wrap(
                      direction: Axis.horizontal,
                      spacing: 4,
                      runAlignment: WrapAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < state.loyaltyCard.reached; i++)
                          stampCheckW(true),
                        for (int j = 0;
                            j <
                                state.loyaltyCard.checkPoints -
                                    state.loyaltyCard.reached;
                            j++)
                          stampCheckW(false),
                        SizedBox(height: 20),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: state.loyaltyCard.rewards.length != 0
                                ? Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 30,
                                    runAlignment: WrapAlignment.spaceBetween,
                                    children: [
                                      for (int i = 0;
                                          i < state.loyaltyCard.rewards.length;
                                          i++)
                                        InkWell(
                                          onTap: () => {
                                            context.read<RewardBloc>().add(
                                                RewardIconPressed(
                                                    idLoyaltyCard:
                                                        state.loyaltyCard.id))
                                          },
                                          child: const FaIcon(
                                            FontAwesomeIcons.gift,
                                            color: Colors.orangeAccent,
                                            size: 30,
                                          ),
                                        ),
                                    ],
                                  )
                                : Text(''))
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 25, 129, 225),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.qr_code_scanner,
                          color: Colors.white,
                          size: 40,
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.of(context).pop(),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QrCodeCameraScreen(
                                          idLoyaltyCard:
                                              idLoyaltyCard.toString(),
                                        ))),
                            /* Navigator.popAndPushNamed(context, "/qrCodeCameraScreen",
                              arguments: <String,String>{
                                "idLoyaltyCard": idLoyaltyCard.toString()
                              }), */
                          },
                          child: const Text(
                            'Scan a product ',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /* Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red,
                    ),
                    child: BlocBuilder<RewardBloc, RewardState>(
                      builder: (context, state) {
                        return InkWell(
                            onTap: () => {
                                  print(context.read<RewardBloc>()),
                                  _showMyDialog(context.read<RewardBloc>()),
                                },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 40,
                            ));
                      },
                    ),
                  ), */
                ],
              ),
            ],
          ),
        ),
      );

  Widget stampCheckW(bool isChecked) => Stack(
        children: [
          Container(
            height: 55,
            width: 55,
            margin: const EdgeInsets.only(top: 12, left: 12),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isChecked == true
                    ? Color.fromARGB(255, 25, 129, 225)
                    : Colors.white54),
          ),
          Container(
            height: 22,
            width: 22,
            margin: EdgeInsets.only(top: 28, left: 28),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                border: null,
                color: isChecked == true ? Colors.white : Colors.grey.shade700,
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
                ]),
          ),
          Transform.rotate(
            angle: -math.pi / 4,
            child: Container(
                height: 22,
                width: 22,
                margin: EdgeInsets.only(top: 40, left: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  border: null,
                  color:
                      isChecked == true ? Colors.white : Colors.grey.shade700,
                ),
                child: Transform.rotate(
                  angle: math.pi / 4,
                  child: Icon(
                    Icons.done,
                    size: 20,
                    color: isChecked == true
                        ? Color.fromARGB(255, 25, 129, 225)
                        : Colors.white,
                  ),
                )),
          ),
        ],
      );

  Future<void> _showMyDialog(RewardBloc bloc) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('confirm your unsubscription please'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                    'after pressing confirm all your rewards points and this card will be discarded'),
                Text('Would you like to approve of this?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                bloc.add(ConfirmDeleteButtonPressed(
                    idLoyaltyCard: widget.idLoyaltyCard));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
