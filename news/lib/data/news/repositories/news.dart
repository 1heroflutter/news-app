import 'package:dartz/dartz.dart';
import 'package:news/common/helper/mapper/news_mapper.dart';
import 'package:news/data/news/models/sources_model.dart';
import 'package:news/data/news/sources/news_service.dart';
import 'package:news/domain/news/repositories/news.dart';
import '../../../common/helper/mapper/source_mapper.dart';
import '../../../service_locator.dart';
import '../models/news_model.dart';

class NewsRepositoryImpl extends NewsRepository {
  @override
  Future<Either> getEverything() async {
    var responseData = await sl<NewsService>().getEverything();
    return responseData.fold(
      (error) {
        return Left(error);
      },
      (response) {
        var data =
            List.from(
              response,
            ).map((item) => NewsMapper.toEntity(NewsModel.fromJson(item))).toList();
        return Right(data);
      },
    );
  }

  @override
  Future<Either> getTrending() async {
    var resonseData = await sl<NewsService>().getTrending();
    return resonseData.fold(
      (e) {
        return Left(e);
      },
      (response) {
        var data =
            List.from(
              response,
            ).map((item) => NewsMapper.toEntity(NewsModel.fromJson(item))).toList();
        return Right(data);
      },
    );
  }

  @override
  Future<Either> getByCategory(String category) async {
    var resonseData = await sl<NewsService>().getByCategory(category);
    return resonseData.fold(
          (e) {
        return Left(e);
      },
          (response) {
        var data =
        List.from(
          response,
        ).map((item) => NewsMapper.toEntity(NewsModel.fromJson(item))).toList();
        return Right(data);
      },
    );
  }

  @override
  Future<Either> search(String context) async {
    var resonseData = await sl<NewsService>().search(context);
    return resonseData.fold(
          (e) {
        return Left(e);
      },
          (response) {
        var data =
        List.from(
          response,
        ).map((item) => NewsMapper.toEntity(NewsModel.fromJson(item))).toList();
        return Right(data);
      },
    );
  }

  @override
  Future<Either> getSources() async {
    var responseData = await sl<NewsService>().getSources();
    return responseData.fold(
          (error) {
        return Left(error);
      },
          (response) {
        var data =
        List.from(
          response,
        ).map((item) => SourcesMapper.toEntity(SourcesModel.fromJson(item))).toList();
        return Right(data);
      },
    );
  }

  @override
  Future<Either> getNewsBySource(String name) async {
    var resonseData = await sl<NewsService>().getNewsBySource(name);
    return resonseData.fold(
          (e) {
        return Left(e);
      },
          (response) {
        var data =
        List.from(
          response,
        ).map((item) => NewsMapper.toEntity(NewsModel.fromJson(item))).toList();
        return Right(data);
      },
    );
  }

}
