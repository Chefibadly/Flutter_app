part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final User user;

  const ProfileLoadedState({required this.user});
  @override
  List<Object> get props => [user];
}

class ProfilePicLoadingState extends ProfileState {}

class ProfilePicLoadedState extends ProfileState {
  final User user;
  const ProfilePicLoadedState({required this.user});
  @override
  List<Object> get props => [user];
}

class ProfileErrState extends ProfileState {
  final String message;

  const ProfileErrState({required this.message});
}
