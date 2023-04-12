import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/constants.dart';
import '../../../data/login_model.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel model;

  void userLogin({required String email, required String pass}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': pass},
    ).then((value) {
      model = LoginModel.fromJSON(value.data);
      emit(LoginSuccessState(loginModel: model));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  bool obscureText = true;
  IconData suffix = Icons.visibility_rounded;
  void changeEyeIcon() {
    obscureText = !obscureText;
    suffix =
        obscureText ? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(ChangePassIcon());
  }
}
