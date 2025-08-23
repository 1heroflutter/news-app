import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/configs/assets/app_vectors.dart';
import 'package:news/domain/news/usecase/get_by_source.dart';
import 'package:news/presentation/source_detail/pages/source_webview_page.dart';
import '../../../common/bloc/generic_data_cubit.dart';
import '../../../common/bloc/generic_data_state.dart';
import '../../../common/helper/app_navigator.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../common/widgets/latest/build_latest_item.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/news/entities/sources_entity.dart';
import '../../../service_locator.dart';

class SourceDetailPage extends StatefulWidget {
  final SourcesEntity? source;
  final String? name;
  final bool isFollowed;
  final VoidCallback onPress;

  const SourceDetailPage({
    super.key,
    required this.source,
    required this.name,
    required this.isFollowed,
    required this.onPress,
  });

  @override
  State<SourceDetailPage> createState() => _SourceDetailPageState();
}

class _SourceDetailPageState extends State<SourceDetailPage> {
  bool isFollowed = false;

  @override
  void initState() {
    super.initState();
    isFollowed = widget.isFollowed;
  }

  @override
  Widget build(BuildContext context) {
    final source = widget.source;
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BasicAppBar(
                icon: Icons.arrow_back,
                title: null,
                onLeadingTap: () {
                  Navigator.pop(context);
                },
                suffer: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.15,
                          child: Image.asset(AppVectors.channel, fit: BoxFit
                              .cover),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Category:",
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 12,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.005,
                            ),
                            Text(
                              source?.category?.toUpperCase() ?? "NA",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Language:",
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 12,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.005,
                            ),
                            Text(
                              source?.language?.toUpperCase() ?? "NA",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Country:",
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 12,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.005,
                            ),
                            Text(
                              source?.country?.toUpperCase() ?? "NA",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02),
                    Text(
                      source?.name ?? "NA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.01),
                    Text(
                      source?.description ?? "NA",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.06,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              side: WidgetStatePropertyAll(
                                BorderSide(
                                    color: AppColors.primary, width: 1.2),
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                isFollowed
                                    ? theme.primaryColor
                                    : theme.colorScheme.onSecondaryContainer,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isFollowed = !isFollowed;
                              });
                              widget.onPress();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!isFollowed)
                                  Icon(
                                    Icons.add,
                                    color: theme.primaryColor,
                                    size: 18,
                                  ),
                                Text(
                                  isFollowed ? "Following" : "Follow",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color:
                                    isFollowed
                                        ? theme.colorScheme.onPrimary
                                        : theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.06,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,

                          child: ElevatedButton(
                            style: ButtonStyle(
                              side: WidgetStatePropertyAll(
                                BorderSide(
                                    color: AppColors.primary, width: 1.2),
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                theme.primaryColor,
                              ),
                            ),
                            onPressed: () {
                              AppNavigator.push(
                                context,
                                SourceWebViewPage(url: source?.url ?? "NA"),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Website',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.015),
                    SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.8,
                        child: BlocProvider(create: (context) =>
                        GenericDataCubit()
                          ..getData(sl<GetBySourceUseCase>(),
                              params: source?.id??"NA" ),
                            child: BlocBuilder<
                                GenericDataCubit,
                                GenericDataState>(
                              builder: (context, state) {
                                if (state is DataLoading) {
                                  return SizedBox(
                                    height: 250,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.blueAccent,
                                        strokeWidth: 6,
                                      ),
                                    ),
                                  );
                                }
                                if (state is DataLoaded) {
                                  final List<dynamic> allNews = state.data;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: ListView.builder(
                                      itemCount: allNews.length,
                                      itemBuilder: (context, index) {
                                        return LatestItem(news: allNews[index]);
                                      },
                                    ),
                                  );
                                }
                                if (state is FailureLoadData) {
                                  print("[Error]:${state.errorMessage}");
                                  return Center(
                                      child: Text(state.errorMessage));
                                }
                                return Container();
                              },
                            ),)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
