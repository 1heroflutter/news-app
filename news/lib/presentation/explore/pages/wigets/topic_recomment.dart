import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/bloc/generic_data_cubit.dart';
import 'package:news/common/bloc/generic_data_state.dart';
import 'package:news/common/helper/mapper/user_mapper.dart';
import 'package:news/common/widgets/topic/topic_item.dart';
import 'package:news/common/widgets/trending/TrendingNewsItem.dart';
import 'package:news/domain/news/entities/topics_entity.dart';
import 'package:news/domain/news/usecase/get_trending.dart';
import 'package:news/presentation/main/bloc/user_cubit.dart';
import 'package:news/presentation/main/bloc/user_state.dart';
import '../../../../common/widgets/widget_header/widget_header.dart';
import '../../../../data/user/models/user_req_params.dart';
import '../../../../domain/user/usecases/update_user_profile.dart';
import '../../../../service_locator.dart';
import '../../../splash/pages/splash.dart';

class TopicRecomment extends StatefulWidget {
  const TopicRecomment({super.key});

  @override
  State<TopicRecomment> createState() => _TopicRecommentState();
}

class _TopicRecommentState extends State<TopicRecomment> {
  List<TopicsEntity> randomTopics = [];

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().loadTopicsFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<UserCubit, UserState>(
          buildWhen: (prev, curr) => curr is TopicLoaded,
          builder: (context, state) {
            if (state is TopicLoading) {
              return SizedBox(height:220,child: Center(child: CircularProgressIndicator(),));
            }

            if (state is TopicLoaded) {
              if (randomTopics.isEmpty) {
                final topics = List<TopicsEntity>.from(state.topic)..shuffle();
                randomTopics = topics.take(3).toList();
              }
              return Column(
                children: [
                  BuildWidgetHeader(leading: "Topic", onTap: null),
                  SizedBox(height: 12),
                  ...randomTopics.map((topic) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 8,
                      ),
                      child: TopicItem(
                        topic: topic,
                        onPress: () async {
                          final topicName = topic.name!.toLowerCase();
                          setState(() {
                            topic.isSaved = !topic.isSaved;
                            if (topic.isSaved) {
                              context.read<UserCubit>().selectedTopic.add(
                                topicName,
                              );
                            } else {
                              context.read<UserCubit>().selectedTopic.remove(
                                topicName,
                              );
                            }
                          });
                          await context.read<UserCubit>().updateUserProfile(UserMapper.toEntity(UserModel.updateCategory(context.read<UserCubit>().selectedTopic)));
                          setUser();
                        },
                      ),
                    );
                  }).toList(),
                ],
              );
            }
            return SizedBox();
          },
        ),
      ],
    );
  }
}
