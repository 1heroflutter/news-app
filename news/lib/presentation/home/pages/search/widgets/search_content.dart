import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/widgets/latest/build_latest_item.dart';
import 'package:news/common/widgets/source/source_following.dart';
import 'package:news/common/widgets/topic/topic_item.dart';
import 'package:news/core/configs/assets/app_images.dart';
import 'package:news/data/user/models/user_req_params.dart';
import 'package:news/domain/news/entities/news_entity.dart';
import 'package:news/domain/news/entities/topics_entity.dart';
import 'package:news/domain/user/usecases/update_user_profile.dart';
import 'package:news/presentation/main/bloc/user_cubit.dart';
import 'package:news/presentation/splash/pages/splash.dart';

import '../../../../../domain/news/entities/sources_entity.dart';
import '../../../../../service_locator.dart';
import '../bloc/search_cubit.dart';
import '../bloc/search_state.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({super.key});

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();
    final state = context.watch<SearchCubit>().state;

    if (state is SearchLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
          strokeWidth: 6,
        ),
      );
    }

    if (state is NewsLoaded) {
      if (state.news.isEmpty) {
        return Center(child: Image.asset(AppImages.no_result));
      }
      return ListView.builder(
        itemCount: state.news.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: LatestItem(news: state.news[index]),
          );
        },
      );
    }

    if (state is TopicLoaded) {
      if (state.topic.isEmpty) {
        return Center(child: Image.asset(AppImages.no_result));
      }

      return ListView.builder(
        itemCount: state.topic.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          TopicsEntity topic = state.topic[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: TopicItem(
              topic: topic,
              onPress: () async {
                final topicName = topic.name!.toLowerCase();

                setState(() {
                  topic.isSaved = !topic.isSaved;
                  if (topic.isSaved) {
                    searchCubit.selectedTopic.add(topicName);
                  } else {
                    searchCubit.selectedTopic.remove(topicName);
                  }
                });

                await sl<UpdateUserProfileUseCase>().call(
                  params: UserModel.updateCategory(
                    searchCubit.selectedTopic,
                  ),
                );
              },
            ),
          );
        },
      );
    }

    if (state is SourceLoaded) {
      if (state.sources.isEmpty) {
        return Center(child: Image.asset(AppImages.no_result));
      }
      return ListView.builder(
        itemCount: state.sources.length,
        itemBuilder: (context, index) {
          SourcesEntity source = state.sources[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SourceFollowing(
              name: source.name.toString(),
              category: source.category,
              time: null,
              isFollowed: source.isFollowed!,
              source: source,
              onPress: () async {
                setState(() {
                  source.isFollowed = !source.isFollowed!;
                  if (source.isFollowed!) {
                    searchCubit.selectedSource.add(source.name!);
                    context.read<UserCubit>().selectedSource.add(source.name!);
                  } else {
                    searchCubit.selectedSource.remove(source.name!);
                    context.read<UserCubit>().selectedSource.remove(source.name!);
                  }
                });
                await sl<UpdateUserProfileUseCase>().call(
                  params: UserModel(
                    isFirstLogin: null,
                    following: searchCubit.selectedSource,
                    id: null,
                    email: null,
                    username: null,
                    phoneNumber: null,
                    fullName: null,
                    image: null,
                    searchHistory: null,
                    v: null,
                    otp: null,
                    country: null,
                    preferredCategory: null,
                  ),
                );
                setUser();
              },
            ),
          );
        },
      );
    }

    if (state is FailureSearchLoad) {
      return Text(state.errorMessage);
    }

    return const SizedBox.shrink();
  }
}
