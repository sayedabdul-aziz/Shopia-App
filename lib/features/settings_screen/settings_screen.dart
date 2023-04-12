import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopia/core/styles/color_manager.dart';
import 'package:shopia/core/utils/extensions.dart';

import '../../core/utils/functions.dart';
import '../../core/widgets/custom_button.dart';
import '../../layouts/home_cubit/cubit/home_cubit.dart';
import '../../core/theme/cubit/cubit.dart';
import '../../core/utils/cache_helper.dart';
import '../auth/presentation/login/login_screen.dart';
import '../edit_profile/edit_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    15.ph,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        image: NetworkImage(
                          cubit.userData!.data?.image ?? '',
                        ),
                        height: 120,
                        width: 120,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(cubit.userData!.data!.name ?? '',
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 10),
                    Text(cubit.userData!.data!.phone ?? '',
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 10),
                    CustomButton(
                        onPressed: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        width: 160,
                        text: 'Edit Profile',
                        icon: Icons.edit)
                  ],
                ),
                const SizedBox(height: 7),
                const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20),
                const SizedBox(height: 7),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        PrefItem(
                            Icons.language_rounded,
                            'Language',
                            Row(
                              children: [
                                Text('ENGLISH',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: ColorManager.primaryColor,
                                    size: 30,
                                  ),
                                  onPressed: () {},
                                )
                              ],
                            )),
                        const SizedBox(height: 10),
                        PrefItem(
                            Icons.dark_mode_outlined,
                            'Dark Mode',
                            Switch(
                                value: ModeCubit.get(context).isDark,
                                activeColor:
                                    const Color.fromARGB(255, 245, 109, 68),
                                onChanged: (value) {
                                  HomeCubit.get(context).changeAppMode(value);
                                  ModeCubit.get(context).changeAppMode();
                                })),
                        const SizedBox(height: 10),
                        PrefItem(
                            Icons.security_rounded,
                            'Privacy and Security',
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ColorManager.primaryColor,
                                size: 30,
                              ),
                              onPressed: () {},
                            )),
                        const SizedBox(height: 10),
                        PrefItem(
                            Icons.notifications_on_rounded,
                            'Notifications',
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ColorManager.primaryColor,
                                size: 30,
                              ),
                              onPressed: () {},
                            )),
                        const SizedBox(height: 10),
                        PrefItem(
                            Icons.policy_rounded,
                            'Terms and Support',
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ColorManager.primaryColor,
                                size: 30,
                              ),
                              onPressed: () {},
                            )),
                        const SizedBox(height: 10),
                        PrefItem(
                            Icons.question_answer_rounded,
                            'Ask a Question',
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ColorManager.primaryColor,
                                size: 30,
                              ),
                              onPressed: () {},
                            )),
                        const SizedBox(height: 10),
                        PrefItem(
                            Icons.info_outline_rounded,
                            'About',
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ColorManager.primaryColor,
                                size: 30,
                              ),
                              onPressed: () {},
                            )),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CustomButton(
                              onPressed: () {
                                CacheHelper.removeData(key: 'token')
                                    .then((value) {
                                  navigateAndStop(context, LoginScreen());
                                });
                              },
                              radius: 6,
                              text: 'LOGOUT',
                              width: double.infinity,
                              icon: Icons.logout_rounded),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PrefItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget widget;

  const PrefItem(this.icon, this.text, this.widget, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 30,
          color: ColorManager.primaryColor,
        ),
        const SizedBox(
          width: 15,
        ),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
        const Spacer(),
        widget,
      ],
    );
  }
}
