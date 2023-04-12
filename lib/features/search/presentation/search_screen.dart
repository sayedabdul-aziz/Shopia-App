import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopia/features/search/presentation/widgets/search_item.dart';

import '../../../core/widgets/custom_text_form_field.dart';
import 'view_model/search_cubit.dart';
import 'view_model/search_states.dart';

class SearchScreen extends StatelessWidget {
  var controller = TextEditingController();
  final _controller = ScrollController();
  var formkey = GlobalKey<FormState>();

  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Search'),
            ),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                        controller: controller,
                        keyboardType: TextInputType.text,
                        text: 'Search',
                        prefixIcon: Icons.search_rounded,
                        onSubmitted: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Search field is Empty';
                          }

                          return null;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(
                        backgroundColor: Colors.deepOrange,
                        color: Colors.white54,
                        minHeight: 2,
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                          child: ListView.separated(
                              controller: _controller,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => SearchBuildItem(
                                  SearchCubit.get(context)
                                      .searchModel!
                                      .data!
                                      .data![index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: SearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .data!
                                  .length)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
