import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news/core/constant/api_url.dart';
import 'package:news/core/network/dio_client.dart';

import '../../../service_locator.dart';

abstract class NewsService {
  Future<Either> getEverything();

  Future<Either> getTrending();

  Future<Either> getByCategory(String category);

  Future<Either> search(String context);

  Future<Either> getNewsBySource(String name);

  Future<Either> getSources();
}

class NewsServiceImpl extends NewsService {
  final DioClient dio = sl<DioClient>();

  Future<Either> _safeApiCall(Future<Response> Function() request) async {
    try {
      final returnedData = await request();
      return Right(returnedData.data['content']);
    } on DioException catch (e) {
      final message =
          e.response?.data?['message'] ?? e.message ?? 'Unknown error';
      return Left(message);
    }
  }

  @override
  Future<Either> getEverything() {
    return _safeApiCall(() => dio.get(ApiUrl.getEverything));
  }

  @override
  Future<Either> getTrending() {
    return _safeApiCall(() => dio.get(ApiUrl.getTrending));
  }

  @override
  Future<Either> getByCategory(String category) {
    return _safeApiCall(
      () => dio.post(ApiUrl.getByCategory, data: {'category': category}),
    );
  }

  @override
  Future<Either> search(String context) {
    return _safeApiCall(
      () => dio.post(ApiUrl.search, data: {'context': context}),
    );
  }

  @override
  Future<Either> getSources() {
    return _safeApiCall(() => dio.get(ApiUrl.getSources));
  }

  @override
  Future<Either> getNewsBySource(String name) {
    return _safeApiCall(
      () => dio.post(ApiUrl.getBySource, data: {'source': name}),
    );
  }
}
