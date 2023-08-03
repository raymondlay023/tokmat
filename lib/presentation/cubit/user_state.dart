part of 'user_cubit.dart';

enum UserStatus { initial, success, loading, failure }

class UserState extends Equatable {
  final UserEntity user;
  final UserStatus status;
  const UserState({
    required this.status,
    required this.user,
  });

  factory UserState.initial() =>
      const UserState(status: UserStatus.initial, user: UserEntity());

  UserState copyWith({UserEntity? user, UserStatus? status}) {
    return UserState(status: status ?? this.status, user: user ?? this.user);
  }

  @override
  List<Object> get props => [user];
}
