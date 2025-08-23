import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/helper/app_navigator.dart';
import 'package:news/common/helper/mapper/formatPublishedDate.dart';
import 'package:news/common/widgets/appbar/basic_appbar.dart';
import 'package:news/common/widgets/source/source_following.dart';
import 'package:news/core/configs/assets/app_images.dart';
import 'package:news/domain/news/entities/news_entity.dart';
import 'package:news/domain/user/entities/user_req_params.dart';
import 'package:news/presentation/main/bloc/user_cubit.dart';
import 'package:news/presentation/main/bloc/user_state.dart';
import 'package:news/presentation/news_detail/pages/news_webview_page.dart';
import 'package:news/presentation/source_detail/widgets/bottom_bar.dart';
import 'package:news/presentation/splash/pages/splash.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsEntity news;
  const NewsDetailPage({super.key, required this.news});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late bool isFollowed;

  @override
  void initState() {
    super.initState();
    final userState = context.read<UserCubit>().state;
    if (userState is UserLoaded) {
      final following = userState.user.following ?? [];
      isFollowed = following.contains(widget.news.source?.name ?? "NA");
    } else {
      isFollowed = false;
    }
  }

  void toggleFollow() {
    final userCubit = context.read<UserCubit>();
    final state = userCubit.state;

    if (state is UserLoaded) {
      final selected = List<String>.from(userCubit.selectedSource);
      if (isFollowed) {
        selected.remove(widget.news.source?.name);
      } else {
        selected.add(widget.news.source!.name!);
      }
      userCubit.updateUserProfile(
        UserEntity(
          isFirstLogin: null,
          following: selected,
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
      setState(() {
        isFollowed = !isFollowed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final news = widget.news;

    return Scaffold(
      bottomNavigationBar: NewsDetailBottomBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicAppBar(
            icon: Icons.arrow_back,
            onLeadingTap: () => AppNavigator.pop(context),
            suffer: [
              IconButton(onPressed: () {}, icon: Icon(Icons.share_rounded)),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            ], title: null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SourceFollowing(
                  name: news.source?.name ?? "NA",
                  time: news.publishedAt != null
                      ? formatPublishedDate(news.publishedAt!)
                      : "NA",
                  category: null,
                  isFollowed: isFollowed,
                  onPress: toggleFollow, source: null,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
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
                SizedBox(height: 16),
                Text(
                  news.author ?? "NA",
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  news.title ?? "NA",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  news.content ?? "NA",
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                ),
                GestureDetector(
                  onTap: () {
                    AppNavigator.push(
                      context,
                      NewsWebViewPage(url: news.url ?? "NA"),
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "See all (copyright issues)",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

