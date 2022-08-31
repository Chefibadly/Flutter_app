import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/business_logic/repository/user_repo.dart';

import '../business_logic/blocs/profile_bloc/bloc/profile_bloc.dart';

import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isChecked = false;
  XFile? _imageFile;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(UserRepository())..add(StartEvent()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            // backgroundColor: Colors.blue.shade100,
            body: Stack(children: [
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
              ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            imageProfile(context),
                            BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                                if (state is ProfileLoadingState) {
                                  return Text('...');
                                } else if (state is ProfileLoadedState) {
                                  return Wrap(
                                    children: [
                                      Text(
                                        state.user.name
                                                .substring(0, 1)
                                                .toUpperCase() +
                                            state.user.name.substring(1) +
                                            ' ' +
                                            state.user.lastname.toUpperCase(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Text('errr');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 40, left: 20),
                        //color: Colors.black,
                        child: Text(
                          'Account Settings',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 25, 129, 225)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Edit phone number',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                            BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                                if (state is ProfileLoadingState) {
                                  return Text('...');
                                } else if (state is ProfileLoadedState) {
                                  return Text(state.user.phoneNumber.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300));
                                } else {
                                  return Text('errr');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1.0,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(94, 0, 0, 0),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(64, 56, 56, 56),
                              spreadRadius: 0.5,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Notifications',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                            Switch(
                              value: isChecked,
                              onChanged: (bool value) {
                                setState(() {
                                  isChecked = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1.0,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(94, 0, 0, 0),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(64, 56, 56, 56),
                              spreadRadius: 0.5,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Language',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                            Icon(
                              Icons.language,
                              color: Colors.black45,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1.0,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(94, 0, 0, 0),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(64, 56, 56, 56),
                              spreadRadius: 0.5,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 40, left: 20),
                        //color: Colors.black,
                        child: Text(
                          'Support & Legal',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 25, 129, 225)),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Column(
                          children: [
                            Text(
                              'Term of services: \nTerms of service are the legal agreements between a service provider and a person who wants to use that service. The person must agree to abide by the terms of',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 200,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ]),
          );
        },
      ),
    );
  }

  Widget imageProfile(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 90, 90, 90),
                    Color.fromARGB(255, 25, 129, 225),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  tileMode: TileMode.decal)),
        ),
        Positioned(
          left: 10,
          top: 10,
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadedState) {
                return CircleAvatar(
                    radius: 65,
                    backgroundImage: _imageFile == null
                        ? NetworkImage(state.user.url)
                        : FileImage(File(_imageFile!.path)) as ImageProvider);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              /* if (state is ProfilePicLoadingState) {
                return CachedNetworkImage(
                  imageUrl: "http://via.placeholder.com/350x150",
                );
              } else if (state is ProfilePicLoadedState) {
                return CircleAvatar(
                    radius: 65,
                    backgroundImage: _imageFile == null
                        ? FileImage(File(_imageFile!.path)) as ImageProvider
                        : NetworkImage(state.user.url));
              } else if (state is ProfileLoadedState) {
                return CircleAvatar(
                    radius: 65, backgroundImage: NetworkImage(state.user.url));
              } else {
                return CircularProgressIndicator();
              } */
            },
          ),
        ),
        Positioned(
            top: 110,
            left: 110,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: ((builder) => buttomSheet(context)));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt_sharp,
                    color: Colors.black,
                    size: 28,
                  ),
                ],
              ),
            ))
      ],
    );
  }

  Widget buttomSheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: <Widget>[
        Text(
          "Choose profile photo",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              onPressed: () {
                takePhoto(context, ImageSource.camera);
              },
              child: Icon(Icons.camera),
            ),
            TextButton(
              onPressed: () {
                takePhoto(context, ImageSource.gallery);
              },
              child: Icon(Icons.image),
            ),
          ],
        )
      ]),
    );
  }

  void takePhoto(BuildContext context, ImageSource imageSource) async {
    final XFile? photo = await _picker.pickImage(source: imageSource);

    setState(() {
      _imageFile = photo;
      print("heer test  " + _imageFile!.path.toString());
      context
          .read<ProfileBloc>()
          .add(ProfilePictureScannedEvent(file: _imageFile));
    });
  }
}
