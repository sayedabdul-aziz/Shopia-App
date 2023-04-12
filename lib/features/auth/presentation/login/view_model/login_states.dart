import '../../../data/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  late final LoginModel loginModel;
  LoginSuccessState({
    required this.loginModel,
  });
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class ChangePassIcon extends LoginStates {}
