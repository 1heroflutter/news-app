import 'package:news/data/news/models/news_model.dart';
import 'package:news/domain/news/entities/news_entity.dart';
import 'package:news/domain/user/entities/user_req_params.dart';

class NewsMapper {
  static NewsEntity toEntity(NewsModel newsModel) {
    return NewsEntity(
      source:
          newsModel.source != null
              ? SourceMapper.toEntity(newsModel.source!)
              : null,
      author: newsModel.author,
      title: newsModel.title,
      description: newsModel.description,
      url: newsModel.url,
      urlToImage: newsModel.urlToImage,
      publishedAt: newsModel.publishedAt,
      content: newsModel.content,
    );
  }
}

class SourceMapper {
  static SourceEntity toEntity(SourceModel model) {
    return SourceEntity(id: model.id, name: model.name);
  }
}
