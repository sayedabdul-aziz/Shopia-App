import 'package:shopia/core/utils/functions.dart';

import '../../../core/utils/cache_helper.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/extensions.dart';
import 'package:flutter/material.dart';
import '../../../layouts/home_layout.dart';
import '../../auth/presentation/login/login_screen.dart';
import '../../on_boarding/on_boarding_screen.dart';
import 'sliding_text.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _sliding;
  Widget? nextRoot;

  @override
  void initState() {
    super.initState();
    bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
    token = CacheHelper.getData(key: 'token');

    if (onBoarding != null) {
      if (token != null) {
        nextRoot = const HomeLayout();
      } else {
        nextRoot = LoginScreen();
      }
    } else {
      nextRoot = const OnBoardingScreen();
    }
    initAnimation();
    navigateToHome();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splash.png',
            width: MediaQuery.of(context).size.width * .6,
          ),
          7.ph,
          SlidingText(sliding: _sliding),
        ],
      ),
    );
  }

  void initAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _sliding = Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
        .animate(_animationController);
    _animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        navigateAndStop(context, nextRoot);
      },
    );
  }
}
