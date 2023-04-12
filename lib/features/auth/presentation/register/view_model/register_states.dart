import 'package:shopia/features/auth/data/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  late final LoginModel model;
  RegisterSuccessState({
    required this.model,
  });
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class ChangePassIcon extends RegisterStates {}
