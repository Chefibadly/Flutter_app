import 'package:equatable/equatable.dart';

class AuthEvents extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StartEvent extends AuthEvents {}

class LoginButtonPressed extends AuthEvents {
  final String phoneNumber;
  final String password;
  LoginButtonPressed({required this.phoneNumber, required this.password});
}
