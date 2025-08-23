
import 'package:news/domain/news/entities/news_entity.dart';
import 'package:news/domain/news/entities/topics_entity.dart';

import '../../../../../domain/news/entities/sources_entity.dart';


abstract class SearchState {}
class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class NewsLoaded extends SearchState {
  final List<NewsEntity> news;
  NewsLoaded({required this.news});
}
class TopicLoaded extends SearchState{
  final List<TopicsEntity> topic;
  TopicLoaded({required this.topic});
}
class SourceLoaded extends SearchState {
  final List<SourcesEntity> sources;
  SourceLoaded({required this.sources});
}

class FailureSearchLoad extends SearchState {
  final String errorMessage;
  FailureSearchLoad({required this.errorMessage});
}
