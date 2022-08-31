import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/business_logic/models/user.dart';
import 'package:mobile/business_logic/repository/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository repo;
  ProfileBloc(this.repo) : super(ProfileLoadingState()) {
    on<StartEvent>(_onStart);
    on<ProfilePictureScannedEvent>(_profilePicScanned);
  }

  void _onStart(StartEvent event, Emitter<ProfileState> emit) async {
    emit(
      ProfileLoadingState(),
    );
    var pref = await SharedPreferences.getInstance();
    try {
      var userId = pref.get("userId");
      User user = await repo.getUser(id: userId.toString());

      emit(ProfileLoadedState(user: user));
    } catch (e) {
      emit(ProfileErrState(message: e.toString()));
    }
  }

  void _profilePicScanned(
      ProfilePictureScannedEvent event, Emitter<ProfileState> emit) async {
    //emit(ProfilePicLoadingState());

    try {
      var pref = await SharedPreferences.getInstance();
      var res = await repo.upload(File(event.file!.path));

      res.stream.transform(utf8.decoder).listen((value) async {
        Map<String, dynamic> data = json.decode(value);
        print(data['url']);

        var userId = pref.get("userId");
        await repo.updateUser(id: userId.toString(), url: data['url']);
      });

      var userId = pref.get("userId");
      User user = await repo.getUser(id: userId.toString());

      //emit(ProfilePicLoadedState(user: user));
    } catch (e) {
      emit(ProfileErrState(message: e.toString()));
    }
  }
}
