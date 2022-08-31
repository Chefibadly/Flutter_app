import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/business_logic/blocs/qr_code_bloc/qrcode_bloc.dart';
import 'package:mobile/business_logic/repository/loyalty_cards_repo.dart';
import 'package:mobile/business_logic/repository/product_repo.dart';
import 'package:mobile/business_logic/repository/user_repo.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/login_screen.dart';
import 'package:mobile/screens/loyalty_cards_screen.dart';
import 'package:mobile/screens/steps_screen.dart';

import 'business_logic/blocs/auth_bloc/auth_bloc.dart';
import 'business_logic/repository/auth_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthRepository())),
        BlocProvider(
            create: (context) => QrcodeBloc(LoyaltyCardsRepository(),
                ProductRepository(), UserRepository()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': ((context) => LoginScreen()),
          '/home': ((context) => const HomeScreen()),
          '/steps': ((context) => const StepsScreen()),
          '/loyaltyCards': ((context) => LoyaltyCardsScreen()),
        },
      ),
    );
  }
}
