import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/business_logic/repository/product_repo.dart';
import 'package:mobile/screens/rewards_screen.dart';

import '../business_logic/blocs/product/product_bloc.dart';
import '../business_logic/models/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  final String loyaltyCardId;
  const ProductDetailsScreen(
      {Key? key, required this.productId, required this.loyaltyCardId})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => ProductBloc(ProductRepository())
          ..add(StartEvent(productId: widget.productId)),
        child: Stack(children: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductLoadedState) {
                return Stack(
                  children: [
                    Positioned(
                      bottom: MediaQuery.of(context).size.height / 2,
                      child: Container(
                          margin: const EdgeInsets.only(left: 50, top: 40),
                          width: MediaQuery.of(context).size.width / 1.25,
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    state.product.image.url.toString())),
                          )),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 4,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: MediaQuery.of(context).size.height / 1.25,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
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
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(40)),
                        ),
                        child: Column(children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Name",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            state.product.name,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          SizedBox(height: 20),
                          Text('Price',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          SizedBox(height: 10),
                          Text(state.product.price.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                          Text('Reference',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          SizedBox(height: 10),
                          Text(state.product.reference.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                          Text('Description',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          SizedBox(height: 10),
                          Text(state.product.description,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.white60)),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 200,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(255, 25, 129, 225),
                            ),
                            child: TextButton(
                              onPressed: () => {
                                Navigator.of(context).pop(),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RewardsScreen(
                                            idLoyaltyCard:
                                                widget.loyaltyCardId)))
                              },
                              child: const Text(
                                'Confirm buying ',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    )
                  ],
                );
              } else if (state is ProductErrorLoadingState) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'An error has occured try later',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                );
              }
            },
          )
        ]),
      ),
    );
  }
}
