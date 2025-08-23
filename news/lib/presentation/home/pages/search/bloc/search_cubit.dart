import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/configs/assets/app_images.dart';
import 'package:news/data/topic/list_topic.dart';
import 'package:news/domain/news/entities/sources_entity.dart';
import 'package:news/domain/news/entities/topics_entity.dart';
import 'package:news/domain/news/usecase/get_sources.dart';
import 'package:news/domain/news/usecase/search.dart';
import 'package:news/presentation/home/pages/search/bloc/search_state.dart';
import 'package:news/presentation/home/pages/search/bloc/selectable_option_cubit.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../service_locator.dart';


class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  List<SourcesEntity> sourcesList = [];
  List<TopicsEntity> topicList = listTopics;
  late List<String> selectedTopic = [];
  late List<String> selectedSource = [];
  String currentQuery = "";

  void search(String query, SearchType seachType) {
    currentQuery = query;
    emit(SearchLoading());
    switch (seachType) {
      case SearchType.news:
        searchNews(query);
        break;
      case SearchType.topic:
        searchTopic(query);
        break;
      case SearchType.source:
        searchSources(query);
        break;
    }
  }

  Future<void> searchNews(String query) async {
    var news = await sl<SearchUseCase>().call(params: query);
    news.fold(
      (error) {
        emit(FailureSearchLoad(errorMessage: error));
      },
      (data) {
        emit(NewsLoaded(news: data));
      },
    );
  }

  Future<void> getTopics() async {
    emit(TopicLoaded(topic: topicList));
  }

  void searchTopic(String query) async {
    if (topicList.isNotEmpty) {
      final List<TopicsEntity> searchedList =
          topicList.where((element) {
            final toLowerName = element.name.toString().toLowerCase();
            final toLowerDes = element.description.toString().toLowerCase();
            final q = query.toLowerCase();
            return toLowerName.contains(q) || toLowerDes.contains(q);
          }).toList();
      emit(TopicLoaded(topic: searchedList));
    }
  }

  Future<void> markSavedTopicsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson == null) return;

    final Map<String, dynamic> userMap = jsonDecode(userJson);

    final List<String> savedTopics =
        userMap['preferredCategory'] != null
            ? List<String>.from(userMap['preferredCategory'])
            : [];
    selectedTopic = savedTopics;
    for (var topic in topicList) {
      topic.isSaved = savedTopics.contains(topic.name?.toLowerCase());
    }
  }

  Future<void> getSource() async {
    emit(SearchLoading());
    final result = await sl<GetSourcesUseCase>().call();
    result.fold(
      (error) {
        emit(FailureSearchLoad(errorMessage: error));
      },
      (data) async {
        final prefs = await SharedPreferences.getInstance();
        final userJson = prefs.getString('user');
        if (userJson == null) return;

        final userMap = jsonDecode(userJson);
        final List<String> savedSources = List<String>.from(
          userMap['following'] ?? [],
        );
        selectedSource = savedSources;

        for (SourcesEntity source in data) {
          source.isFollowed = savedSources.contains(source.name);
        }
        sourcesList = data;
        emit(SourceLoaded(sources: data));
      },
    );
  }

  Future<void> searchSources(String query) async {
    if (sourcesList.isNotEmpty) {
      final List<SourcesEntity> searchedList =
          sourcesList.where((element) {
            final toLowerName = element.name.toString().toLowerCase();
            final toLowerDes = element.description.toString().toLowerCase();
            final q = query.toLowerCase();
            return toLowerName.contains(q) || toLowerDes.contains(q);
          }).toList();
      emit(SourceLoaded(sources: searchedList));
    }
  }
}
