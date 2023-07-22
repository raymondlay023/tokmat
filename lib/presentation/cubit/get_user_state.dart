part of 'get_user_cubit.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

class GetUserInitial extends GetUserState {}

class GetUserLoaded extends GetUserState {
  final UserEntity user;

  const GetUserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class GetUserLoading extends GetUserState {}

class GetUserFailure extends GetUserState {}
