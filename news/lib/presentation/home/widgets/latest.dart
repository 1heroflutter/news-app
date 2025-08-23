import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/domain/news/usecase/get_by_category.dart';
import 'package:news/domain/news/usecase/get_everything.dart';
import 'package:news/presentation/home/widgets/get_all_latest_news.dart';

import '../../../common/widgets/widget_header/widget_header.dart';
import '../../../service_locator.dart';

class BuildLatestWidget extends StatefulWidget {
  const BuildLatestWidget({super.key});

  @override
  State<BuildLatestWidget> createState() => _BuildTabbarState();
}

class _BuildTabbarState extends State<BuildLatestWidget> {
  final List<Tab> tabs = const [
    Tab(text: "All", ),
    Tab(text: "Health"),
    Tab(text: 'Science'),
    Tab(text: 'Business'),
    Tab(text: 'Entertainment'),
    Tab(text: "Sports"),
    Tab(text: "Technology"),
  ];

  final List<Widget> tabViews = [
    GetLatestNews(useCase: sl<GetEverythingUseCase>(), category: null,),
    GetLatestNews(useCase: sl<GetByCategoryUseCase>(), category: 'health',),
    GetLatestNews(useCase: sl<GetByCategoryUseCase>(), category: 'science',),
    GetLatestNews(useCase: sl<GetByCategoryUseCase>(), category: 'business',),
    GetLatestNews(useCase: sl<GetByCategoryUseCase>(), category: 'entertainment',),
    GetLatestNews(useCase: sl<GetByCategoryUseCase>(), category: 'sports',),
    GetLatestNews(useCase: sl<GetByCategoryUseCase>(), category: 'technology',),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        BuildWidgetHeader(leading: "Latest", onTap: null),
        DefaultTabController(
          length: tabs.length,
          initialIndex: 0,
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: TabBar(
                  tabAlignment:TabAlignment.start,
                  labelPadding: EdgeInsets.only(right: 10) ,
                  dividerHeight: 0,
                  unselectedLabelColor: theme.colorScheme.onSecondary,
                  unselectedLabelStyle: TextStyle(fontSize: 16),
                  indicatorColor: theme.primaryColor,
                  labelColor: theme.colorScheme.onPrimary,
                  isScrollable: true,
                  labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  tabs: tabs,
                ),
              ),
              SizedBox(height: 12,),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                width: double.infinity,
                child: TabBarView(
                  children: tabViews,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
