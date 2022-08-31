import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_events.dart';
import 'auth_state.dart';
import '../../repository/auth_repo.dart';

// this class holds the the auth bloc logic
class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthRepository repo;

  AuthBloc(this.repo) : super(LoginInitState()) {
    on<StartEvent>(_onStart);
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onStart(StartEvent event, Emitter<AuthState> emit) {
    emit(
      LoginInitState(),
    );
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<AuthState> emit) async {
    var pref = await SharedPreferences.getInstance();
    emit(
      LoginLoadingState(),
    );

    var data = await repo.login(event.phoneNumber, event.password);
    //log(data["user"]["_id"].toString());
    // check the token if its not empty then save token and userId as you login
    if (data['token'] != "") {
      pref.setString("token", data["token"]);
      pref.setString("userId", data["user"]["_id"].toString());
      emit(UserLoginSuccState());
    } else {
      emit(LoginErrState(message: "auth failed check your credentials"));
    }
  }
}
