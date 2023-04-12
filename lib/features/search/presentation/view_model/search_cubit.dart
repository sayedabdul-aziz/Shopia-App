import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopia/features/search/presentation/view_model/search_states.dart';

import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/constants.dart';
import '../../data/search_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialSatate());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {'text': text})
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState(error.toString()));
    });
  }
}
