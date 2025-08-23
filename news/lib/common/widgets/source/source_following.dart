import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/common/helper/app_navigator.dart';
import 'package:news/common/helper/limit_text.dart';
import 'package:news/core/configs/assets/app_vectors.dart';
import 'package:news/domain/news/entities/news_entity.dart';
import 'package:news/domain/news/entities/sources_entity.dart';
import 'package:news/presentation/source_detail/pages/source_detail_page.dart';

import '../../../core/configs/theme/app_colors.dart';

class SourceFollowing extends StatelessWidget {
  final String name;
  final String? time;
  final String? category;
  final bool isFollowed;
  final VoidCallback onPress;
  final SourcesEntity? source;
  const SourceFollowing({
    super.key,
    required this.name,
    required this.time,
    required this.category,
    required this.isFollowed,
    required this.onPress,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, SourceDetailPage(source: source,name: name,onPress: onPress, isFollowed: isFollowed,));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.asset(AppVectors.channel, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 4),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(limitText(name, 15), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text(time??category!, style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),),
            ],
          ),
          Spacer(),
          SizedBox(height: 38,child: ElevatedButton(
            style: ButtonStyle(
              side: WidgetStatePropertyAll(BorderSide(color: AppColors.primary,width: 1.2,)),
              backgroundColor: WidgetStatePropertyAll(
                isFollowed
                    ? theme.primaryColor
                    : theme.colorScheme.onSecondaryContainer,
              ),
            ),
            onPressed:onPress,
            child: Row(
              children: [
                if (!isFollowed)
                  Icon(Icons.add, color: theme.primaryColor, size: 18),
                Text(
                  isFollowed ? "Following" : "Follow",
                  style: TextStyle(
                    color: isFollowed
                        ? Colors.white
                        : theme.primaryColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),),
      
        ],
      ),
    );
  }
}
