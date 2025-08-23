import 'package:dartz/dartz.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/domain/user/repositories/user.dart';

import '../../../service_locator.dart';

class IsFirstTimeUseCase extends UseCase<Either, String>{
  @override
  Future<Either> call({String? params}) async {
    return await sl<UserRepository>().isFirstTimeUser();
  }
}