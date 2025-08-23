import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/bloc/generic_data_cubit.dart';
import 'package:news/common/widgets/latest/build_latest_item.dart';
import 'package:news/core/usecase/usecase.dart';
import '../../../common/bloc/generic_data_state.dart';

class GetLatestNews extends StatelessWidget {
  final UseCase useCase;
  final String? category;
  const GetLatestNews({super.key, required this.useCase, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenericDataCubit()..getData(useCase, params: category),
      child: BlocBuilder<GenericDataCubit, GenericDataState>(
        builder: (context, state) {
          if(state is DataLoading){
            return const Center(child: CircularProgressIndicator(),);
          }
          if (state is DataLoaded) {
            final List<dynamic> allNews = state.data;
            return allNews.isNotEmpty
                ? ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 6),
              itemCount: allNews.length,

              itemBuilder: (context, index) {
                return Column(
                  children: [
                    LatestItem(news: allNews[index]),
                    const SizedBox(height: 26,)
                  ],
                );
              },
            )
                : Center(child: Text("No news available"));
          }

          if(state is FailureLoadData){
            return Center(child: Text(state.errorMessage),);
          }
          return Container();
        },
      ),
    );
  }
}
