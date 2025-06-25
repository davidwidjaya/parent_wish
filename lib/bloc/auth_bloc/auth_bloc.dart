import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:parent_wish/data/models/index.dart';
import 'package:parent_wish/data/repositories/auth_repository.dart';
import 'package:parent_wish/data/repositories/repository_manager.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = RepositoryManager.authRepository;
  AuthBloc() : super(AuthInitial()) {
    on<AuthRegisterManual>((event, emit) {
      emit(AuthLoading());
      authRepository
          .registerManual(
        username: event.username,
        email: event.email,
        password: event.password,
      )
          .then((result) {
        emit(AuthAuthenticated(token: result.token));
      }).catchError((error) {
        emit(AuthError(message: error.toString()));
      });
    });

    on<AuthLoginManual>((event, emit) {
      emit(AuthLoading());
      authRepository
          .loginManual(
        email: event.email,
        password: event.password,
      )
          .then((result) {
        emit(AuthAuthenticated(token: result.token));
      }).catchError((error) {
        emit(AuthError(message: error.toString()));
      });
    });
  }
}
