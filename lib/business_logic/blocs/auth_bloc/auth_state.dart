import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginInitState extends AuthState {}

class LoginLoadingState extends AuthState {}

class UserLoginSuccState extends AuthState {}

class LoginErrState extends AuthState {
  final String message;
  LoginErrState({required this.message});
}
