import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/modules/login/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller;

  const LoginPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<LoginController, LoginState>(
      bloc: controller,
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          final message = state.errorMessage ?? "Erro ao realizar login";

          AsukaSnackbar.alert(message).show();
        }
      },
      child: Scaffold(
        body: Container(
          width: size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0XFF0092B9),
                Color(0XFF0167B2),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png"),
              SizedBox(height: size.height * 0.1),
              SizedBox(
                width: size.width * 0.8,
                height: 49,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[200],
                  ),
                  onPressed: () {
                    controller.singnIn();
                  },
                  child: Image.asset("assets/images/google.png"),
                ),
              ),
              BlocSelector<LoginController, LoginState, bool>(
                bloc: controller,
                selector: (state) => state.status == LoginStatus.loading,
                builder: (context, show) {
                  return Visibility(
                    visible: show,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
