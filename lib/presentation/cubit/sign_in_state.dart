part of 'sign_in_cubit.dart';

enum SignInStatus { initial, submitting, success, error }

class SignInState extends Equatable {
  final String email;
  final String password;
  final SignInStatus status;

  const SignInState({
    required this.email,
    required this.password,
    required this.status,
  });

  factory SignInState.initial() {
    return const SignInState(
      email: '',
      password: '',
      status: SignInStatus.initial,
    );
  }

  SignInState copyWith({
    String? email,
    String? password,
    SignInStatus? status,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  @override
  List<Object> get props => [];
}
