import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shopia/core/utils/functions.dart';
import 'package:shopia/layouts/home_layout.dart';

import '../../core/utils/cache_helper.dart';
import '../../core/utils/constants.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../../layouts/home_cubit/cubit/home_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(builder: (context, state) {
      var cubit = HomeCubit.get(context);

      nameController.text = cubit.userData!.data!.name ?? '';
      emailController.text = cubit.userData!.data!.email ?? '';
      phoneController.text = cubit.userData!.data!.phone ?? '';
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
                          'Edit Profile'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        if (state is UserUpdateLoadingState)
                          const LinearProgressIndicator(
                            backgroundColor: Colors.deepOrange,
                            color: Colors.white54,
                            minHeight: 2,
                          ),
                        const SizedBox(
                          height: 20,
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
                            text: 'Email Address',
                            keyboardType: TextInputType.emailAddress,
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
                            text: 'Phone Number',
                            keyboardType: TextInputType.phone,
                            prefixIcon: Icons.phone_android_rounded,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone Number mustn\'t be empty.';
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
                          condition: state is! UserUpdateLoadingState,
                          builder: (BuildContext context) => CustomButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  HomeCubit.get(context).updateUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'Done',
                              spacer: 10,
                              icon: Icons.done_rounded),
                          fallback: (BuildContext context) => const Center(
                              child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 245, 109, 68))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              navigateAndStop(context, const HomeLayout());
                            },
                            child: const Text(
                              'back',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 245, 109, 68)),
                            ))
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
      if (state is UserUpdateSuccessState) {
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
    });
  }
}
