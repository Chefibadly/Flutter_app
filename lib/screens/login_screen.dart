// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/business_logic/blocs/auth_bloc/auth_state.dart';
import 'package:mobile/business_logic/blocs/auth_bloc/auth_bloc.dart';

import '../business_logic/blocs/auth_bloc/auth_events.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  late AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  final errMsg = BlocBuilder<AuthBloc, AuthState>(
    builder: ((context, state) {
      if (state is LoginErrState) {
        return Container(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            state.message,
            style: TextStyle(color: Colors.red),
          ),
        );
      } else if (state is LoginLoadingState) {
        return Stack(
          children: [Center(child: CircularProgressIndicator())],
        );
      } else {
        return Center(
          child: Text(''),
        );
      }
    }),
  );

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    const IconData phoneIcon = IconData(0xe4a2, fontFamily: 'MaterialIcons');

    var checkbox = Checkbox(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      side: BorderSide(color: Color.fromARGB(255, 90, 90, 90), width: 1.25),
      value: isChecked,
      onChanged: (v) {
        setState(() {
          isChecked = v!;
        });
      },
    );
    var expanded = Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 13.0, right: 13.0),
      child: Container(
        height: 1.0,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 95, 178, 224),
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
    ));
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserLoginSuccState) {
          Navigator.pushNamed(context, '/steps');
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
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
            Positioned(
                right: -getSmallDiameter(context) / 4,
                top: -getBiglDiameter(context) / 1.05,
                child: Container(
                  width: getSmallDiameter(context) * 1.5,
                  height: getSmallDiameter(context) * 1.5,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 82, 146, 255),
                            Color.fromARGB(255, 33, 148, 255)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.80, 2.0])),
                )),
            Positioned(
              //left: getBiglDiameter(context) / 4.5,
              top: getBiglDiameter(context) / 3.5,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.25,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 11,
                    right: MediaQuery.of(context).size.width / 11),
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
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
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
                        child: Text(
                          "E-Loyalty",
                          style: TextStyle(
                              color: Color.fromARGB(255, 75, 150, 237),
                              // TODO: fontFamily: '',
                              fontWeight: FontWeight.w900,
                              fontSize: 40),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      //padding: EdgeInsets.only(top: 15.0, bottom: 40.0),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          expanded,
                          Text("Sign in",
                              style: TextStyle(
                                color: Color.fromARGB(255, 95, 178, 224),
                                // TODO: fontFamily: '',
                                fontWeight: FontWeight.w400,
                              )),
                          expanded,
                        ],
                      ),
                      Container(
                          padding:
                              EdgeInsets.only(top: 15.0, left: 20, right: 20),
                          child: phoneNumberField()),
                      Container(
                        padding: EdgeInsets.only(
                          top: 15.0,
                          left: 20,
                          right: 20,
                        ),
                        child: passwordField(),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 0.0, left: 20),
                        child: Row(
                          children: [
                            checkbox,
                            Text(
                              "Keep me Logged In",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 95, 178, 224),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4 * 3,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 117, 117, 117),
                            borderRadius: BorderRadius.circular(40.0)),
                        child: loginButton(),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Forget your password ?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 95, 178, 224),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.90,
                        height: 1.0,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 95, 178, 224),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(64, 47, 47, 47),
                              spreadRadius: 0.5,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 12.0, left: 12.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            expanded,
                            Text("Or",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 95, 178, 224),
                                  // TODO: fontFamily: '',
                                  fontWeight: FontWeight.w500,
                                )),
                            expanded,
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 4 * 3,
                          decoration: BoxDecoration(
                              //color: Color.fromARGB(255, 117, 117, 117),
                              borderRadius: BorderRadius.circular(40.0),
                              border: Border.all(
                                  color: Color.fromARGB(255, 117, 117, 117))),
                          child: TextButton(
                              child: Text("Sign up ".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color:
                                          Color.fromARGB(255, 117, 117, 117))),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(15)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              onPressed:
                                  // TODO LATER
                                  () => null),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            errMsg,
          ],
        ),
      ),
    );
  }

  TextField phoneNumberField() {
    return TextField(
      controller: phoneNumber,
      onChanged: (value) {
        //Do something with the user input.
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.phone),
        iconColor: Colors.black,
        filled: true,
        fillColor: Color.fromARGB(255, 229, 229, 229),
        hintText: 'Enter phone number',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 229, 229, 229), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
        ),
      ),
    );
  }

  TextField passwordField() {
    return TextField(
      obscureText: true,
      controller: password,
      onChanged: (value) {
        //Do something with the user input.
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.password),
        filled: true,
        fillColor: Color.fromARGB(255, 229, 229, 229),
        hintText: 'Enter password',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 229, 229, 229), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
        ),
      ),
    );
  }

  TextButton loginButton() {
    return TextButton(
        child: Text("Log In ".toUpperCase(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed:
            // TODO LATER
            () => authBloc.add(LoginButtonPressed(
                phoneNumber: phoneNumber.text, password: password.text)));
  }
}
