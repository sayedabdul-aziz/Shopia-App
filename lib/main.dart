import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopia/core/theme/cubit/cubit.dart';
import 'package:shopia/core/theme/cubit/states.dart';
import 'package:shopia/core/utils/cache_helper.dart';
import 'package:shopia/features/splash_screen/splash_screen.dart';

import 'core/theme/theme_manager.dart';
import 'core/utils/api_service.dart';
import 'layouts/home_cubit/cubit/home_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  DioHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark') ?? false;

  runApp(MyApp(
    isDark!,
  ));
}

class MyApp extends StatelessWidget {
  bool isDark;
  MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ModeCubit()..changeAppMode(shared: isDark),
        ),
        BlocProvider(
            create: (context) => HomeCubit()
              ..getHomeData()
              ..getCategoryData()
              ..getFavListData()
              ..getCartListData()
              ..getUserData()),
      ],
      child: BlocConsumer<ModeCubit, AppStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'OnlineShop',
              theme: lightMode,
              darkTheme: darkMode,
              themeMode: ModeCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: const SplashScreen(),
            );
          },
          listener: (context, state) {}),
    );
  }
}
