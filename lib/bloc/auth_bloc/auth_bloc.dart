import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:parent_wish/data/models/child.dart';
import 'package:parent_wish/data/repositories/auth_repository.dart';
import 'package:parent_wish/data/repositories/repository_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = RepositoryManager.authRepository;
  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckLoggedIn>((event, emit) async {
      emit(AuthLoading());
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null && token.isNotEmpty) {
        emit(AuthAuthenticated(token: token));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<AuthLogout>((event, emit) async {
      emit(AuthLoading());
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');

      emit(AuthUnauthenticated());
    });

    on<AuthRegisterManual>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.registerManual(
          username: event.username,
          email: event.email,
          password: event.password,
        );

        emit(AuthAuthenticated(token: result.token));
      } catch (error) {
        emit(AuthError(message: error.toString()));
      }
    });

    on<AuthRegisterGoogle>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.registerGoogle();

        emit(AuthAuthenticated(token: result.token, isGoogle: true));
      } catch (error) {
        emit(AuthError(message: error.toString()));
      }
    });

    on<AuthSendEmailVerificationCode>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.sendEmailVerification();

        emit(AuthCodeSent());
      } catch (error) {
        emit(AuthError(message: error.toString()));
      }
    });

    on<AuthSubmitEmailVerificationCode>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.submitEmailVerification(
          smsCode: event.smsCode,
        );

        emit(AuthCodeVerified());
      } catch (error) {
        emit(AuthError(message: error.toString()));
      }
    });

    on<AuthUploadImageProfile>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.uploadImageProfile(
          file: event.file,
        );

        emit(AuthProfileImageUploaded());
      } catch (error) {
        emit(AuthError(message: error.toString()));
      }
    });

    on<AuthCompleteProfile>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.completeProfile(
          fullname: event.fullname,
          dateOfBirth: event.dateOfBirth,
          parentType: event.parentType,
          timezone: event.timezone,
        );

        emit(AuthProfileCompleted());
      } catch (error) {
        emit(AuthError(message: error.toString()));
      }
    });

    on<AuthAddChildren>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.addChildren(
          fullname: event.fullname,
          gender: event.gender,
          ageCategory: event.ageCategory,
          schoolDay: event.schoolDay,
          startSchoolTime: event.startSchoolTime,
          endSchoolTime: event.endSchoolTime,
          image: event.image,
        );

        emit(AuthChildrenAdded());
      } catch (error) {
        emit(AuthError(message: error.toString()));
      }
    });

    on<AuthListChildren>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.listChildren();

        emit(AuthListChildrenFetched(children: result.children));
      } catch (error) {
        emit(AuthError(message: error.toString()));
      }
    });

    on<AuthLoginManual>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.loginManual(
          email: event.email,
          password: event.password,
        );

        emit(AuthAuthenticated(token: result.token));
      } catch (error) {
        emit(AuthError(message: error.toString()));
      }
    });

    on<AuthForgotPassword>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.forgotPassword(email: event.email);

        emit(AuthForgotPasswordSent(data: result.data ?? {}));
      } catch (error) {
        emit(
          AuthError(
            message: error.toString(),
          ),
        );
      }
    });

    on<AuthVerifyForgotPassword>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.verifyForgotPassword(
          code: event.code,
          email: event.email,
          newPassword: event.newPassword,
        );

        emit(AuthVerifyForgotPasswordSuccess());
      } catch (error) {
        emit(
          AuthError(
            message: error.toString(),
          ),
        );
      }
    });
  }
}
