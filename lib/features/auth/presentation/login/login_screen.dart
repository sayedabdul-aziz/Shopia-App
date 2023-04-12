import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shopia/core/styles/color_manager.dart';
import 'package:shopia/core/utils/extensions.dart';
import 'package:shopia/features/auth/presentation/register/register_screen.dart';

import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../layouts/home_layout.dart';
import 'view_model/login_cubit.dart';
import 'view_model/login_states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage("assets/images/splash.png"),
                            width: 200,
                          ),
                          30.ph,
                          Text('Login',
                              style: Theme.of(context).textTheme.headlineLarge),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Please sign in to continue.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomTextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              text: 'Email Address',
                              prefixIcon: Icons.email_rounded,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email address mustn\'t be empty.';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              controller: passController,
                              keyboardType: TextInputType.visiblePassword,
                              text: 'Password',
                              obscureText: LoginCubit.get(context).obscureText,
                              suffixIcon: LoginCubit.get(context).suffix,
                              suffixPress: () {
                                LoginCubit.get(context).changeEyeIcon();
                              },
                              prefixIcon: Icons.lock_rounded,
                              onSubmitted: (value) {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      pass: passController.text);
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password mustn\'t be empty.';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (BuildContext context) => CustomButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        pass: passController.text);
                                  }
                                },
                                text: 'login',
                                icon: Icons.arrow_forward_ios_rounded),
                            fallback: (BuildContext context) => Center(
                                child: CircularProgressIndicator(
                                    color: ColorManager.primaryColor)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                        color: ColorManager.primaryColor),
                                  ))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status ?? false) {
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data!.token)!
                .then((value) {
              token = state.loginModel.data!.token;
              MotionToast(
                      icon: Icons.done_all_rounded,
                      title: Text(
                        (state.loginModel.data!.name) ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                      secondaryColor: Colors.black54,
                      description: Text(state.loginModel.message ?? ''),
                      primaryColor: Colors.green)
                  .show(context);

              navigateAndStop(context, const HomeLayout());
            });
          } else {
            MotionToast.warning(
              description: Text(state.loginModel.message ?? ''),
            ).show(context);
          }
        }
      }),
    );
  }
}
