import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/common/widgets/trending/TrendingNewsItem.dart';
import 'package:news/domain/news/entities/news_entity.dart';

import '../../../common/widgets/appbar/basic_appbar.dart';

class TrendingNewsPage extends StatelessWidget {
  final List<dynamic> allNews;

  const TrendingNewsPage({super.key, required this.allNews});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: BasicAppBar(
              icon:Icons.arrow_back,
              title: Text(
                "Trending",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              onLeadingTap: () {
                Navigator.pop(context);
              },
              suffer: [
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: ListView.builder(
                itemCount: allNews.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TrendingNewsItem(news: allNews[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
