import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopia/features/categories_screen/data/category_model.dart';
import 'package:shopia/features/fav_screen/data/fav_list_model.dart';
import 'package:shopia/features/fav_screen/data/favorite_model.dart';
import 'package:shopia/features/home_screen/data/home_model.dart';
import 'package:shopia/features/auth/data/login_model.dart';
import 'package:shopia/features/categories_screen/categories_screen.dart';
import 'package:shopia/features/fav_screen/fav_screen.dart';
import 'package:shopia/features/home_screen/presentation/home_screen.dart';

import '../../../features/cart/data/cart_model.dart';
import '../../../features/cart/data/cart_update.dart';
import '../../../core/utils/api_service.dart';
import '../../../core/utils/constants.dart';
import '../../../features/settings_screen/settings_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavScreen(),
    const SettingsScreen()
  ];

  void changeNavItem(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }

  bool val = false;
  void changeAppMode(bool value) {
    val = value;
    emit(AppChangeModeState());
  }

  HomeModel? homeModel;
  Map<int, bool> favList = {};

  void getHomeData() {
    emit(HomeDataLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJSON(value.data);
      for (var element in homeModel!.data.products) {
        favList.addAll({element.id: element.inFavorites});
        cartList.addAll({element.id: element.inCart});
      }
      print(favList.toString());
      print(cartList.toString());
      emit(HomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeDataErrorState(error.toString()));
    });
  }

  CategoryModel? categoryModel;
  void getCategoryData() {
    DioHelper.getData(
      url: CATEGORY,
      token: token,
    ).then((value) {
      categoryModel = CategoryModel.fromJSON(value.data);
      emit(CategoryDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoryDataErrorState(error.toString()));
    });
  }

  InFavModel? inFavModel;
  void changeFavIcon(int productId) {
    favList[productId] = !(favList[productId] ?? false);
    emit(ChangeSuccessState());
    DioHelper.postData(
      url: IN_FAV,
      token: token,
      data: {'product_id': productId},
    ).then((value) {
      inFavModel = InFavModel.fromJSON(value.data);
      if (inFavModel!.status != true) {
        favList[productId] = !(favList[productId] ?? false);
      } else {
        getFavListData();
      }
      emit(ChangeFavSuccessState(inFavModel!));
    }).catchError((error) {
      favList[productId] = !(favList[productId] ?? false);
      print(error.toString());
      emit(ChangeFavErrorState(error.toString()));
    });
  }

  FavoritesListModel? favoritesListModel;
  void getFavListData() {
    emit(FavoriteDataLoadingState());
    DioHelper.getData(
      url: IN_FAV,
      token: token,
    ).then((value) {
      favoritesListModel = FavoritesListModel.fromJson(value.data);
      emit(FavoriteDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FavoriteDataErrorState(error.toString()));
    });
  }

  LoginModel? userData;
  void getUserData() {
    emit(UserDataLoadingState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userData = LoginModel.fromJSON(value.data);
      print(userData!.data!.name);
      emit(UserDataSuccessState());
    }).catchError((error) {
      print('error $error');
      emit(UserDataErrorState(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(UserUpdateLoadingState());
    DioHelper.putData(url: UPDATE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userData = LoginModel.fromJSON(value.data);
      emit(UserUpdateSuccessState(userData!));
    }).catchError((error) {
      print('error $error');
      emit(UserUpdateErrorState(error.toString()));
    });
  }

  InCartModel? inCartModel;
  Map<int, bool> cartList = {};

  int totalPrice = 0;

  void changeCartIcon(int productId) {
    cartList[productId] = !(cartList[productId] ?? false);
    emit(ChangeIconSuccessState());
    DioHelper.postData(
      url: CART,
      token: token,
      data: {'product_id': productId},
    ).then((value) {
      inCartModel = InCartModel.fromJSON(value.data);
      if (inCartModel!.status != true) {
        cartList[productId] = !(cartList[productId] ?? false);
        if (homeModel!.data.products[productId].inCart) {
          totalPrice += int.parse(homeModel?.data.products[productId].price);
        }
      } else {
        getCartListData();
      }

      print(totalPrice);
      print('done:"');
      emit(ChangeCartSuccessState(inCartModel!));
    }).catchError((error) {
      cartList[productId] = !(cartList[productId] ?? false);
      print(error.toString());
      emit(ChangeCartErrorState(error.toString()));
    });
  }

  CartModel? cartListModel;
  void getCartListData() {
    emit(CartDataLoadingState());
    DioHelper.getData(
      url: CART,
      token: token,
    ).then((value) {
      cartListModel = CartModel.fromJson(value.data);
      print('done:"');
      emit(CartDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CartDataErrorState(error.toString()));
    });
  }
}
