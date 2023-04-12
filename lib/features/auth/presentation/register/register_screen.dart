import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shopia/core/utils/functions.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../layouts/home_layout.dart';
import '../../../../core/utils/cache_helper.dart';
import '../login/login_screen.dart';
import 'view_model/register_cubit.dart';
import 'view_model/register_states.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          builder: (context, state) {
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
                          Text(
                            'Register'.toUpperCase(),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Please sign up to continue.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              text: 'Name',
                              prefixIcon: Icons.person_outline_rounded,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Name mustn\'t be empty.';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
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
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              text: 'Phone Number',
                              prefixIcon: Icons.phone_android_rounded,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone Number mustn\'t be empty.';
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
                              obscureText:
                                  RegisterCubit.get(context).obscureText,
                              suffixIcon: RegisterCubit.get(context).suffix,
                              suffixPress: () {
                                RegisterCubit.get(context).changeEyeIcon();
                              },
                              prefixIcon: Icons.lock_rounded,
                              onSubmitted: (value) {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
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
                            condition: state is! RegisterLoadingState,
                            builder: (BuildContext context) => CustomButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        pass: passController.text);
                                  }
                                },
                                text: 'Register',
                                spacer: 10,
                                icon: Icons.arrow_forward_ios_rounded),
                            fallback: (BuildContext context) => const Center(
                                child: CircularProgressIndicator(
                                    color: Color.fromARGB(255, 245, 109, 68))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'I have an account?',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateAndStop(context, LoginScreen());
                                  },
                                  child: const Text('Sign in',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 245, 109, 68),
                                      )))
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
        if (state is RegisterSuccessState) {
          if (state.model.status ?? false) {
            CacheHelper.saveData(key: 'token', value: state.model.data!.token)!
                .then((value) {
              token = state.model.data!.token;
              MotionToast(
                      icon: Icons.done_all_rounded,
                      title: Text(
                        (state.model.data!.name) ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                      secondaryColor: Colors.black54,
                      description: Text(state.model.message ?? ''),
                      primaryColor: Colors.green)
                  .show(context);
              navigateAndStop(context, const HomeLayout());
            });
          } else {
            MotionToast.warning(
              description: Text(state.model.message ?? ''),
            ).show(context);
          }
        }
      }),
    );
  }
}
