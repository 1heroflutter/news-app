import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/user/entities/user_req_params.dart';
import 'package:news/presentation/home/pages/search/widgets/selectable_option.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/search_cubit.dart';
import '../bloc/selectable_option_cubit.dart';

class SearchOption extends StatelessWidget {
  const SearchOption({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectableOptionCubit, SearchType>(
      builder: (context, state) {
        final searchCubit = context.read<SearchCubit>();
        final optionCubit = context.read<SelectableOptionCubit>();

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableOption(
              title: 'News',
              isSelected:
                  context.read<SelectableOptionCubit>().state ==
                  SearchType.news,
              onTap: () {
                context.read<SelectableOptionCubit>().selectedNews();
                if (searchCubit.currentQuery.isNotEmpty) {
                  context.read<SearchCubit>().search(
                  searchCubit.currentQuery,
                  SearchType.news,
                );
                }
              },
            ),
            SizedBox(width: 14),
            SelectableOption(
              title: 'Topics',
              isSelected:
              context.read<SelectableOptionCubit>().state ==
                  SearchType.topic,
              onTap: () async {
                optionCubit.selectedTopic();
                await searchCubit.markSavedTopicsFromPrefs();
                if (searchCubit.currentQuery.isEmpty) {
                  searchCubit.getTopics(); // sẽ emit topicList đã có isSaved đúng
                } else {
                  searchCubit.search(searchCubit.currentQuery, SearchType.topic);
                }
              },
            ),
            SizedBox(width: 14),
            SelectableOption(
              title: 'Source',
              isSelected:
              optionCubit.state ==
                  SearchType.source,
              onTap: () {
                optionCubit.selectedSource();
                if (searchCubit.currentQuery.isEmpty) {
                  searchCubit.getSource();
                }
                context.read<SearchCubit>().search(
                  searchCubit.currentQuery,
                  SearchType.source,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
