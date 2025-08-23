import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/bloc/generic_data_cubit.dart';
import 'package:news/common/bloc/generic_data_state.dart';
import 'package:news/common/widgets/trending/TrendingNewsItem.dart';
import 'package:news/domain/news/usecase/get_trending.dart';
import '../../../common/widgets/widget_header/widget_header.dart';
import '../../../service_locator.dart';

class FirstTrendingNews extends StatelessWidget {
  final void Function(List<dynamic> allNews) onTap;

  const FirstTrendingNews({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),
        BlocBuilder<GenericDataCubit, GenericDataState>(
          builder: (context, state) {
            if (state is DataLoading) {
              return SizedBox(
                height: 250,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                    strokeWidth: 6,
                  ),
                ),
              );
            }
            if (state is DataLoaded) {
              final List<dynamic> allNews = state.data;
              return Column(
                children: [
                  BuildWidgetHeader(
                    leading: "Trending",
                    onTap: () {
                      onTap(allNews);
                    },
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TrendingNewsItem(news: allNews[0]),
                  ),
                ],
              );
            }
            if (state is FailureLoadData) {
              print("[Error]:${state.errorMessage}");
              return Center(child: Text(state.errorMessage));
            }
            return Container();
          },
        ),
      ],
    );
  }
}
