part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;
  final bool? isGoogle;

  AuthAuthenticated({
    this.token = '',
    this.isGoogle,
  });

  @override
  List<Object?> get props => [token, isGoogle];
}

class AuthUnauthenticated extends AuthState {}

class AuthCodeSent extends AuthState {}

class AuthCodeVerified extends AuthState {}

class AuthProfileImageUploaded extends AuthState {}

class AuthProfileCompleted extends AuthState {}

class AuthChildrenAdded extends AuthState {}

class AuthListChildrenFetched extends AuthState {
  final List<Child> children;

  AuthListChildrenFetched({required this.children});

  @override
  List<Object?> get props => [children];
}

class AuthForgotPasswordSent extends AuthState {
  final Map<String, dynamic> data;

  AuthForgotPasswordSent({required this.data});

  @override
  List<Object?> get props => [data];
}

class AuthVerifyForgotPasswordSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
