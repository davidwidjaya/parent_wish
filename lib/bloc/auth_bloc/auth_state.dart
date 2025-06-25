part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  // final User user;
  final String token;

  AuthAuthenticated({
    // this.user = const User(id: 0, username: '', email: ''),
    this.token = '',
  });

  @override
  List<Object?> get props => [token];
}

class AuthUnauthenticated extends AuthState {}

class AuthCodeSent extends AuthState {}

class AuthCodeVerified extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
