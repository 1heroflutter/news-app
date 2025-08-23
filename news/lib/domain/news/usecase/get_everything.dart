import 'package:dartz/dartz.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/domain/news/repositories/news.dart';

import '../../../service_locator.dart';

class GetEverythingUseCase extends UseCase<Either, dynamic>{
  @override
  Future<Either> call({params}) async {
    return await sl<NewsRepository>().getEverything();
  }
}