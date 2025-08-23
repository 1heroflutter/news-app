import 'package:dartz/dartz.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/domain/news/repositories/news.dart';

import '../../../service_locator.dart';

class GetByCategoryUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<NewsRepository>().getByCategory(params!);
  }
}
