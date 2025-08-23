import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/common/helper/limit_text.dart';
import 'package:news/common/helper/mapper/formatPublishedDate.dart';
import 'package:news/core/configs/assets/app_images.dart';
import 'package:news/domain/news/entities/news_entity.dart';

import '../../../core/configs/assets/app_vectors.dart';
import '../../../presentation/news_detail/pages/news_detail_page.dart';
import '../../helper/app_navigator.dart';

class LatestItem extends StatelessWidget {
  final NewsEntity news;
  const LatestItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: (){
        AppNavigator.push(context, NewsDetailPage(news: news, ));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    news.urlToImage ?? AppImages.imgNotFound,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          SizedBox(width: 4,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.author ?? "NA",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Text(
                  news.title ?? "NA",
                  maxLines:2,
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(alignment: Alignment(0, 10),AppVectors.channel, fit: BoxFit.cover,),
                      ),
                    ),
                    Text(
                      limitText(news.source?.name ?? "NA", 10),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.watch_later_outlined, size: 12),
                    Text(
                      news.publishedAt != null
                          ? formatPublishedDate(news.publishedAt!)
                          : "NA",
                      style: TextStyle(fontSize: 10),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        color: theme.primaryColor,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
