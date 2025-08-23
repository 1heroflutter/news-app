import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/bloc/generic_data_cubit.dart';
import 'package:news/common/helper/app_navigator.dart';
import 'package:news/domain/news/usecase/get_trending.dart';
import 'package:news/presentation/home/pages/TrendingNews.dart';
import 'package:news/presentation/home/pages/search/pages/search_page.dart';
import 'package:news/presentation/home/widgets/get_all_latest_news.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../service_locator.dart';
import '../widgets/first_trending.dart';
import '../widgets/latest.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final SearchController searchController = SearchController();
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopBtn = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >400&&
          !_showScrollToTopBtn) {
        setState(() {
          _showScrollToTopBtn = true;
        });
      } else if (_scrollController.offset <=
          400 &&
          _showScrollToTopBtn) {
        setState(() {
          _showScrollToTopBtn = false;
        });
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
      duration: Duration(milliseconds: 500),
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
                  icon: Icons.search,
                  title: null,
                  onLeadingTap: () {
                    AppNavigator.push(context, SearchPage());
                  },
                  suffer: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      FirstTrendingNews(
                        onTap: (allNews) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => TrendingNewsPage(allNews: allNews),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 6),
                      BuildLatestWidget(),
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
