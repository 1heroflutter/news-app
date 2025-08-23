import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/common/helper/limit_text.dart';
import 'package:news/domain/news/entities/topics_entity.dart';

import '../../../core/configs/theme/app_colors.dart';

class TopicItem extends StatelessWidget {
  final TopicsEntity topic;
  final VoidCallback onPress;
  const TopicItem({
    super.key,
    required this.topic,
    required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(topic.img!, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                limitText(topic.name!, 15),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                topic.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        SizedBox(
          height: 38,
          child: ElevatedButton(
            style: ButtonStyle(
              side: WidgetStatePropertyAll(BorderSide(color: AppColors.primary,width: 1.2,)),
              backgroundColor: WidgetStatePropertyAll(
                topic.isSaved
                    ? theme.primaryColor
                    : theme.colorScheme.onSecondaryContainer,
              ),
            ),
            onPressed: onPress,
            child: Row(
              children: [
                if (!topic.isSaved)
                  Icon(Icons.add, color: theme.primaryColor, size: 18),
                Text(
                  topic.isSaved ? "Saved" : "Save",
                  style: TextStyle(
                    color: topic.isSaved
                        ? Colors.white
                        : theme.primaryColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
