import 'package:dartz/dartz.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/data/auth/models/signin_req_params.dart';
import 'package:news/domain/auth/repositories/auth.dart';
import 'package:news/domain/user/entities/user_req_params.dart';

import '../../../service_locator.dart';

class AuthCheckUseCase extends UseCase<Either, UserEntity>{
  @override
  Future<Either> call({ UserEntity? params}) async {
    return await sl<AuthRepository>().authCheck();
  }
}