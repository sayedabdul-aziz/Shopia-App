part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeChangeBottomNavState extends HomeState {}

class AppChangeModeState extends HomeState {}

class HomeDataLoadingState extends HomeState {}

class HomeDataSuccessState extends HomeState {}

class HomeDataErrorState extends HomeState {
  final String error;

  HomeDataErrorState(this.error);
}

class CategoryDataSuccessState extends HomeState {}

class CategoryDataErrorState extends HomeState {
  final String error;

  CategoryDataErrorState(this.error);
}

class ChangeSuccessState extends HomeState {}

class ChangeIconSuccessState extends HomeState {}

class ChangeFavSuccessState extends HomeState {
  final InFavModel inFavModel;

  ChangeFavSuccessState(this.inFavModel);
}

class ChangeFavErrorState extends HomeState {
  final String error;

  ChangeFavErrorState(this.error);
}

class FavoriteDataLoadingState extends HomeState {}

class FavoriteDataSuccessState extends HomeState {}

class FavoriteDataErrorState extends HomeState {
  final String error;

  FavoriteDataErrorState(this.error);
}

class UserDataLoadingState extends HomeState {}

class UserDataSuccessState extends HomeState {}

class UserDataErrorState extends HomeState {
  final String error;

  UserDataErrorState(this.error);
}

class UserUpdateLoadingState extends HomeState {}

class UserUpdateSuccessState extends HomeState {
  final LoginModel model;

  UserUpdateSuccessState(this.model);
}

class UserUpdateErrorState extends HomeState {
  final String error;

  UserUpdateErrorState(this.error);
}

class ChangeCartSuccessState extends HomeState {
  final InCartModel inCartModel;

  ChangeCartSuccessState(this.inCartModel);
}

class ChangeCartErrorState extends HomeState {
  final String error;

  ChangeCartErrorState(this.error);
}

class CartDataLoadingState extends HomeState {}

class CartDataSuccessState extends HomeState {}

class CartDataErrorState extends HomeState {
  final String error;

  CartDataErrorState(this.error);
}
