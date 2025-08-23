import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/common/helper/app_navigator.dart';
import 'package:news/common/helper/limit_text.dart';
import 'package:news/common/helper/mapper/formatPublishedDate.dart';
import 'package:news/core/configs/assets/app_vectors.dart';
import 'package:news/domain/news/entities/news_entity.dart';
import 'package:news/presentation/news_detail/pages/news_detail_page.dart';

import '../../../core/configs/assets/app_images.dart';

class TrendingNewsItem extends StatelessWidget {
  final NewsEntity news;

  const TrendingNewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, NewsDetailPage(news: news,));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.36,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(
                    news.urlToImage ?? AppImages.imgNotFound,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            news.author ?? "NA",
            maxLines: 1,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 14,
              color: theme.colorScheme.onSecondary,
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(height: 4),
          Text(
            news.title ?? "NA",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 22,
                width: 22,
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(AppVectors.channel, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 4),
              Text(
                limitText(news.source?.name ?? "NA", 15),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: theme.colorScheme.onSecondary,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.watch_later_outlined, size: 12),
              SizedBox(width: 4),
              Text(
                news.publishedAt.toString().isNotEmpty
                    ? formatPublishedDate(news.publishedAt!)
                    : "NA",
                style: TextStyle( fontSize: 12),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz,
                  size: 14,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
