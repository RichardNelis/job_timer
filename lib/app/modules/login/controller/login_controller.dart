import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/app/services/auth/auth_service.dart';

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final IAuthService _authService;

  LoginController({required IAuthService authService})
      : _authService = authService,
        super(const LoginState.initial());

  Future<void> singnIn() async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      //await _authService.signOut();
      await _authService.signIn();
    } catch (e, s) {
      log("Erro ao realizar login", error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: "Erro ao realizar login",
        ),
      );
    }
  }
}
