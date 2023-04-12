import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopia/core/theme/cubit/states.dart';

import '../../utils/cache_helper.dart';

class ModeCubit extends Cubit<AppStates> {
  ModeCubit() : super(AppInitialState());
  static ModeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool? shared}) {
    if (shared != null) {
      isDark = shared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark)!.then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
