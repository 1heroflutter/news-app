import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/widgets/appbar/basic_appbar.dart';
import 'package:news/presentation/explore/pages/wigets/topic_recomment.dart';

import '../../../common/bloc/generic_data_cubit.dart';
import '../../../common/bloc/generic_data_state.dart';
import '../../../common/widgets/trending/TrendingNewsItem.dart';
import '../../../common/widgets/widget_header/widget_header.dart';
import '../../../domain/news/usecase/get_trending.dart';
import '../../../service_locator.dart';
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopBtn = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 400 && !_showScrollToTopBtn) {
        setState(() => _showScrollToTopBtn = true);
      } else if (_scrollController.offset <= 400 && _showScrollToTopBtn) {
        setState(() => _showScrollToTopBtn = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  Future<void> _refreshData() async{
    context.read<GenericDataCubit>().getData(sl<GetTrendingUseCase>());

  }
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                BasicAppBar(
                  icon: null,
                  title: Text(
                    "Explore",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: theme.primaryColor,
                    ),
                  ),
                  onLeadingTap: null,
                  suffer: null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      TopicRecomment(),
                      const SizedBox(height: 16),
                      BuildWidgetHeader(leading: "Popular", onTap: null),
                      const SizedBox(height: 12),

                      // Dùng Bloc để load 5 trending news
                      BlocBuilder<GenericDataCubit, GenericDataState>(
                        builder: (context, state) {
                          if (state is DataLoading) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (state is DataLoaded) {
                            final List<dynamic> allNews = state.data;
                            final trendingFive = allNews.take(5).toList();

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: trendingFive.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: TrendingNewsItem(news: trendingFive[index]),
                                  );
                                },
                              ),
                            );
                          }
                          if (state is FailureLoadData) {
                            return Text(
                              "Error: ${state.errorMessage}",
                              style: TextStyle(color: Colors.red),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 14,
          left: MediaQuery.of(context).size.width/2-28,
          child: SafeArea(
            child: AnimatedOpacity(
              opacity: _showScrollToTopBtn ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: FloatingActionButton.small(
                shape:CircleBorder(),
                onPressed: _scrollToTop,
                backgroundColor: theme.colorScheme.onSecondary,
                child: Icon(
                  Icons.vertical_align_top_outlined,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
