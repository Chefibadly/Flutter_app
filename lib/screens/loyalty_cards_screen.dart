import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/business_logic/blocs/loyalty_cards_bloc/loyaltycards_bloc.dart';
import 'package:mobile/business_logic/repository/loyalty_cards_repo.dart';
import 'package:mobile/screens/rewards_screen.dart';

class LoyaltyCardsScreen extends StatefulWidget {
  LoyaltyCardsScreen({Key? key}) : super(key: key);

  @override
  State<LoyaltyCardsScreen> createState() => _LoyaltyCardsScreenState();
}

class _LoyaltyCardsScreenState extends State<LoyaltyCardsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoyaltycardsBloc(LoyaltyCardsRepository())..add(StartEvent()),
      child: BlocBuilder<LoyaltycardsBloc, LoyaltyCardsState>(
        builder: (context, state) {
          if (state is LoyaltyCardsLoadedState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.78,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.loyaltyCards.length,
                itemBuilder: (BuildContext context, int index) {
                  if (state.loyaltyCards.isEmpty) {
                    return const Center(
                        child: Text(
                      "you don't have no loyalty card",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                    ));
                  }
                  return InkWell(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RewardsScreen(
                                    idLoyaltyCard: state.loyaltyCards[index].id,
                                  )))
                    },
                    child: buildCard(state.loyaltyCards[index].title,
                        state.loyaltyCards[index].description),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildCard(String title, String description) => Container(
        margin: const EdgeInsets.only(top: 20),
        height: 200,
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
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 15, bottom: 40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: const CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                        "https://res.cloudinary.com/dotwb03aj/image/upload/v1655632437/test/g8u7trajnax6yscx2ap7.png"),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 15, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        title.toString(),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: 200,
                        child: Text(
                          description.length >= 100
                              ? description.substring(0, 100).toString() + '...'
                              : description.toString(),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        /* margin: const EdgeInsets.only(top: 40), */
                        width: 200,
                        child: const Text(
                          'MemberShip Card',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
      );
}
