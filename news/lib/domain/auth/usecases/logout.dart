import 'package:dartz/dartz.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/data/auth/models/signin_req_params.dart';
import 'package:news/domain/auth/repositories/auth.dart';

import '../../../service_locator.dart';

class LogoutUseCase extends UseCase<Either,bool >{
  @override
  Future<Either> call({bool? params}) async {
    return await sl<AuthRepository>().logout();
  }
}