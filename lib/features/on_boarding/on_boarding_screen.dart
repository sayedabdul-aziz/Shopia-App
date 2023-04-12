import 'package:flutter/material.dart';
import 'package:shopia/core/styles/color_manager.dart';
import 'package:shopia/core/utils/extensions.dart';
import 'package:shopia/core/utils/functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../auth/presentation/login/login_screen.dart';
import 'data/onboarding_model.dart';
import '../../core/utils/cache_helper.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boardingModel = [
    BoardingModel(
        image: 'assets/images/onboarding1.png',
        title: 'Easy and Safe Payment',
        body: 'pay for the products you buy safely and easily'),
    BoardingModel(
        image: 'assets/images/onboarding2.png',
        title: 'Find Favorite Items',
        body: 'find your favorite products that you want to buy easily'),
    BoardingModel(
        image: 'assets/images/onboarding3.png',
        title: 'Product Delivery',
        body: 'Your product is delivered to ypur home safely and securely'),
  ];

  var controller = PageController();
  int isLast = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              CacheHelper.saveData(key: 'onBoarding', value: true)!
                  .then((value) {
                navigateAndStop(context, LoginScreen());
              });
            },
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: 18,
                color: ColorManager.primaryColor,
              ),
            ),
          )
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: PageView.builder(
              controller: controller,
              onPageChanged: (index) {},
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  onBoardingItem(boardingModel[index]),
              itemCount: boardingModel.length,
            ),
          ),
        ),
        40.ph,
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              SmoothPageIndicator(
                controller: controller,
                count: boardingModel.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: ColorManager.primaryColor,
                  spacing: 6,
                  radius: 13,
                  dotColor: Colors.grey,
                  dotHeight: 12,
                  dotWidth: 10,
                  expansionFactor: 4,
                ),
                onDotClicked: (index) {
                  controller.animateToPage(index,
                      duration: const Duration(milliseconds: 750),
                      curve: Curves.elasticIn);
                },
              ),
              const Spacer(),
              FloatingActionButton(
                mini: true,
                backgroundColor: ColorManager.primaryColor,
                onPressed: () {
                  setState(() {
                    if (isLast == boardingModel.length - 1) {
                      CacheHelper.saveData(key: 'onBoarding', value: true)!
                          .then((value) {
                        navigateAndStop(context, LoginScreen());
                      });
                    } else {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.elasticIn);
                      isLast++;
                    }
                  });
                },
                child: const Icon(Icons.arrow_forward_ios_rounded),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget onBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Image(
            image: AssetImage(model.image),
            fit: BoxFit.cover,
          )),
          const SizedBox(
            height: 30,
          ),
          Text(model.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge),
          20.ph,
          Text(model.body,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      );
}
