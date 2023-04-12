import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/constants.dart';
import '../../../data/login_model.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  late LoginModel model;

  void userRegister(
      {required String name,
      required String email,
      required String pass,
      required String phone}) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {'name': name, 'email': email, 'password': pass, 'phone': phone},
    ).then((value) {
      model = LoginModel.fromJSON(value.data);
      emit(RegisterSuccessState(model: model));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
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
