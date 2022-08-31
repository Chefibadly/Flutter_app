part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends ProfileEvent {}

class ProfilePictureScannedEvent extends ProfileEvent {
  XFile? file;
  ProfilePictureScannedEvent({required this.file});
}
